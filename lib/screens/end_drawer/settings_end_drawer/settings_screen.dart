import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';

import 'update_settings/update_settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _passConformController = TextEditingController();

  final FocusNode _phoneFocusNode = FocusNode();

  final FocusNode _passConformFocusNode = FocusNode();

  final FocusNode _emailFocusNode = FocusNode();

  final FocusNode _passFocusNode = FocusNode();

  final UpdateSettingsController updateSettingsController=
  Get.put(UpdateSettingsController());
  final errorNameMessage = RxString('');
  final errorPhoneMessage = RxString('');
  final errorEmailMessage = RxString('');
  final errorPassMessage = RxString('');
  final errorConPassMessage = RxString('');

  @override
  void initState() {
    super.initState();
    updateSettingsController.loadInitialSettings();
  }

  void _saveChanges() {
    if (_key.currentState!.validate()) {
      errorNameMessage.value="";
      errorPhoneMessage.value="";
      errorEmailMessage.value="";
      errorPassMessage.value="";
      errorConPassMessage.value="";
      updateSettingsController.updateSettings(
        email: _emailController.text,
        phone: _phoneController.text,
        pass: _passController.text,
      );
    }
  }

  void _cancelChanges() {
    _emailController.text = updateSettingsController.email.value;
    _phoneController.text = updateSettingsController.phone.value;
    _passController.text = updateSettingsController.password.value;
    _passConformController.text = updateSettingsController.password.value;
    errorNameMessage.value="";
    errorPhoneMessage.value="";
    errorEmailMessage.value="";
    errorPassMessage.value="";
    errorConPassMessage.value="";
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const EndDrawerView(),
        appBar:  CustomProfileAppBar(),
        body:Obx(() {
          _emailController.text = updateSettingsController.email.value;
          _phoneController.text = updateSettingsController.phone.value;
          _passController.text = updateSettingsController.password.value;
          _passConformController.text = updateSettingsController.password.value;
          return SingleChildScrollView(
            child: Form(
              key: _key,
              child: SizedBox(
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      width: 100.w,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .appBarTheme
                            .backgroundColor,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CommonViews().customText(
                                  textContent: 'الإعدادات',
                                  fontSize: 14.sp,
                                  textColor: Theme
                                      .of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                  fontWeight: FontWeight.bold),
                              Transform.scale(
                                scale: 0.6,
                                child: Image.asset(
                                  nineMenuImage,
                                  color: Theme
                                      .of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            width: 100.w,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .appBarTheme
                                  .backgroundColor,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CommonViews().customText(
                                    textContent: 'إعدادات الحساب',
                                    fontSize: 12.sp,
                                    textColor: Theme
                                        .of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    fontWeight: FontWeight.w800),
                                SizedBox(height: 2.h),
                                CommonViews().customText(
                                    textContent: 'البريد الإلكتروني',
                                    fontSize: 10.sp,
                                    textColor: Theme
                                        .of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                CommonViews().createTextFormField(
                                    controller: _emailController,
                                    focusNode: _emailFocusNode,
                                    textColor: Theme.of(context).textTheme.bodyLarge!.color,
                                    keyboardType: TextInputType.emailAddress,
                                    onSubmitted: (v) {
                                      _phoneFocusNode.requestFocus();
                                    },
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        errorEmailMessage.value =
                                        "يرجى التحقق من البريد الإلكتروني";
                                        return "";
                                      }
                                      if (v.length < 5) {
                                        errorEmailMessage.value =
                                        "يرجى التحقق من البريد الإلكتروني";
                                        return "";
                                      }
                                      if (v.contains(" ")) {
                                        errorEmailMessage.value =
                                        "يرجى التحقق من البريد الإلكتروني";
                                        return "";
                                      }
                                      if (!isValidEmail(v)) {
                                        errorEmailMessage.value =
                                        "يرجى التحقق من البريد الإلكتروني";
                                        return "";
                                      }
                                      return null;
                                    },
                                    errorBorderColor:  Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    borderColor: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    fillColor: Theme
                                        .of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    radius: 5),
                                SizedBox(height: 2.h),
                                CommonViews().customText(
                                    textContent: 'رقم الهاتف',
                                    fontSize: 11.sp,
                                    textColor: Theme
                                        .of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                CommonViews().createTextFormField(
                                  controller: _phoneController,
                                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                                  focusNode: _phoneFocusNode,
                                  errorBorderColor:  Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                  keyboardType: TextInputType.phone,
                                  onSubmitted: (v) {
                                    _passFocusNode.requestFocus();
                                  },
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      errorPhoneMessage.value = "يرجى التحقق من رقم الهاتف";
                                      return "";
                                    }
                                    if (v.length < 10) {
                                      errorPhoneMessage.value = "يرجى التحقق من رقم الهاتف";
                                      return "";
                                    }
                                    if (v.length > 10) {
                                      errorPhoneMessage.value = "يرجى التحقق من رقم الهاتف";
                                      return "";
                                    }
                                    if (v.contains(" ")) {
                                      errorPhoneMessage.value = "يرجى التحقق من رقم الهاتف";
                                      return "";
                                    }
                                    if (!v.startsWith("07")) {
                                      errorPhoneMessage.value = "يرجى التحقق من رقم الهاتف";
                                      return "";
                                    }
                                    return null;
                                  },

                                  borderColor: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                  fillColor: Theme
                                      .of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  radius: 5,
                                ),
                                SizedBox(height: 2.h),
                                CommonViews().customText(
                                    textContent: 'كلمة السر',
                                    fontSize: 11.sp,
                                    textColor: Theme
                                        .of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                CommonViews().createTextFormField(
                                  isObscure: true,
                                  controller: _passController,
                                  focusNode: _passFocusNode,
                                  errorBorderColor:  Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                  keyboardType: TextInputType.multiline,
                                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                                  onSubmitted: (v) {
                                    _passConformFocusNode.requestFocus();
                                  },
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      errorPassMessage.value =
                                      "كلمة المرور يجب ان لا تقل عن 6 احرف او ارقام";
                                      return "";
                                    }
                                    if (v.length < 6) {
                                      errorPassMessage.value =
                                      "كلمة المرور يجب ان لا تقل عن 6 احرف او ارقام";
                                      return "";
                                    }
                                    return null;
                                  },
                                  borderColor: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                  fillColor: Theme
                                      .of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  radius: 5,
                                ),
                                SizedBox(height: 2.h),
                                CommonViews().customText(
                                    textContent: 'تأكيد كلمة السر',
                                    fontSize: 11.sp,
                                    textColor: Theme
                                        .of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                CommonViews().createTextFormField(
                                  isObscure: true,
                                  controller: _passConformController,
                                  focusNode: _passConformFocusNode,
                                  keyboardType: TextInputType.multiline,
                                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                                  onSubmitted: (v) {
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                  },
                                  errorBorderColor:  Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      errorConPassMessage.value =
                                      "كلمة السر المدخله غير متطابقة";
                                      return "";
                                    }
                                    if (v.length < 6) {
                                      errorConPassMessage.value =
                                      "كلمة السر المدخله غير متطابقة";
                                      return "";
                                    }
                                    if (v != _passController.text) {
                                      errorConPassMessage.value =
                                      "كلمة السر المدخله غير متطابقة";
                                      return "";
                                    }
                                    return null;
                                  },
                                  borderColor: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                  fillColor: Theme
                                      .of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  radius: 5,
                                ),
                                SizedBox(height: 2.h),
                                Obx(() {
                                  if (errorNameMessage.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        errorNameMessage.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                      ),
                                    );
                                  }
                                  if (errorPhoneMessage.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        errorPhoneMessage.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                      ),
                                    );
                                  }
                                  if (errorEmailMessage.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        errorEmailMessage.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                      ),
                                    );
                                  }
                                  if (errorPassMessage.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        errorPassMessage.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                      ),
                                    );
                                  }
                                  if (errorConPassMessage.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        errorConPassMessage.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    CommonViews().customClickableContainer(
                                        onTap: () {
                                          _cancelChanges();
                                        },
                                        radius: 5,
                                        width: 20.w,
                                        colorBorder: Colors.transparent,
                                        color: Theme
                                            .of(context)
                                            .textTheme
                                            .titleSmall!
                                            .color,
                                        child: Center(
                                          child: CommonViews().customText(
                                            textContent: 'الغاء',
                                            fontSize: 12.sp,
                                            textColor: Theme
                                                .of(context)
                                                .textTheme
                                                .titleMedium!
                                                .color,
                                          ),
                                        )),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    CommonViews().customClickableContainer(
                                        onTap: () {
                                          errorNameMessage.value="";
                                          errorPhoneMessage.value="";
                                          errorEmailMessage.value="";
                                          errorPassMessage.value="";
                                          errorConPassMessage.value="";
                                          _saveChanges();
                                        },
                                        radius: 5,
                                        width: 30.w,
                                        colorBorder: Colors.transparent,
                                        color: const Color(0xff7367f0),
                                        child: Center(
                                          child: CommonViews().customText(
                                            textContent: 'حفظ المعلومات',
                                            fontSize: 12.sp,
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                CommonViews().customText(
                                    textContent: 'اشتراكاتي   ',
                                    fontSize: 14.sp,
                                    textColor: Theme
                                        .of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    fontWeight: FontWeight.w800),
                                SizedBox(height: 1.h),
                                CommonViews().customClickableContainer(
                                    width: 100.w,
                                    height: 17.h,
                                    color: Colors.transparent,
                                    margin: const EdgeInsets.all(10),
                                    colorBorder: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color ?? Colors.black,
                                    radius: 5,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 7.h,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.arrow_back_ios,
                                                color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .color,
                                              ),
                                              SizedBox(
                                                width: 40.w,
                                              ),
                                              CommonViews().customText(
                                                textContent: "المنهاج",
                                                fontSize: 13.sp,
                                                textColor:
                                                Theme
                                                    .of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .color,
                                              )
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                        SizedBox(
                                          height: 7.h,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.arrow_back_ios,
                                                color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .color,
                                              ),
                                              SizedBox(
                                                width: 26.w,
                                              ),
                                              CommonViews().customText(
                                                textContent: "خطط الإشتراك",
                                                fontSize: 13.sp,
                                                textColor:
                                                Theme
                                                    .of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .color,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                SizedBox(height: 4.h),
                                CommonViews().customText(
                                    textContent: 'عن جو ستيودنتس  ',
                                    fontSize: 14.sp,
                                    textColor: Theme
                                        .of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    fontWeight: FontWeight.w800),
                                CommonViews().customClickableContainer(
                                  width: 100.w,
                                  height: 17.h,
                                  color: Colors.transparent,
                                  margin: const EdgeInsets.all(10),
                                  colorBorder: Theme
                                      .of(context)
                                      .textTheme
                                      .bodySmall!
                                      .color ?? Colors.black,
                                  radius: 5,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 7.h,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_back_ios,
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .color,
                                            ),
                                            SizedBox(
                                              width: 26.w,
                                            ),
                                            CommonViews().customText(
                                              textContent: "شروط الاستخدام",
                                              fontSize: 13.sp,
                                              textColor: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .color,
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        height: 7.h,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_back_ios,
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .color,
                                            ),
                                            SizedBox(
                                              width: 26.w,
                                            ),
                                            CommonViews().customText(
                                              textContent: "اتفاقية الخصوصية",
                                              fontSize: 13.sp,
                                              textColor: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .color,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        }) ,

      ),
    );
  }

  bool isValidEmail(String value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
