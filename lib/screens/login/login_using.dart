import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/login/login_controller.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';

class LoginUsing extends StatefulWidget {
  const LoginUsing({super.key});

  @override
  State<LoginUsing> createState() => _LoginUsingState();
}

class _LoginUsingState extends State<LoginUsing> {
  final List<WayOfLogin> _wayOfLogin = [];
  final LoginController controller = Get.put(LoginController());
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passEmailController = TextEditingController();
  final TextEditingController _passPhoneController = TextEditingController();
  final GlobalKey<FormState> _keyPhone = GlobalKey();
  final GlobalKey<FormState> _keyEmail = GlobalKey();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passPhoneFocusNode = FocusNode();
  final FocusNode _passEmailFocusNode = FocusNode();
  final errorPhonePassMessage = RxString('');
  final errorEmailPassMessage = RxString('');
  final errorPhoneMessage = RxString('');
  final errorEmailMessage = RxString('');


  @override
  void initState() {
    super.initState();
    _fillWayOfLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: _wayOfLogin.asMap().entries.map((entry) {
            int index = entry.key;
            WayOfLogin way = entry.value;

            return CommonViews().customClickableContainer(
                onTap: () => _changeItem(index),
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                color: way.isSelected
                    ? AppColors.backGroundColor
                    : Colors.transparent,
                child: Center(
                  child: CommonViews().customText(
                    textContent: way.title,
                    fontSize: 11.sp,
                    textColor: way.isSelected ? Colors.white : Colors.black,
                  ),
                ));
          }).toList(),
        ),
        Column(
          children: _wayOfLogin
              .where((way) => way.isSelected)
              .map((way) => way.view)
              .toList(),
        ),
      ],
    );
  }

  void _fillWayOfLogin() {
    _wayOfLogin.addAll(
      [
        WayOfLogin(
          title: "من خلال البريد الإلكتروني",
          view: Form(
            key: _keyEmail,
            child: Column(
              children: [
                SizedBox(height: 3.h),
                CommonViews().customText(
                  textContent: "البريد الإلكتروني",
                  fontSize: 12.sp,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(height: 1.h),
                CommonViews().createTextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onSubmitted: (v) => _passEmailFocusNode.requestFocus(),
                  errorBorder: false,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorEmailMessage.value= "يرجى التأكد من معلومات الدخول";
                      return "";
                    }
                    if (v.length < 5) {
                      errorEmailMessage.value="يرجى التأكد من معلومات الدخول";
                      return "";
                    }
                    if (v.contains(" ")) {
                      errorEmailMessage.value="يرجى التأكد من معلومات الدخول";
                      return "";
                    }
                    if (!isValidEmail(v)) {
                      errorEmailMessage.value="يرجى التأكد من معلومات الدخول";
                      return "";
                    }
                    return null;
                  },
                  hint: "   jostudents@gmail.com : مثال ",
                ),
                SizedBox(height: 2.h),
                CommonViews().customText(
                  textContent: "كلمة السر",
                  fontSize: 12.sp,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(height: 1.h),
                CommonViews().createTextFormField(
                  controller: _passEmailController,
                  focusNode: _passEmailFocusNode,
                  isObscure: true,
                  errorBorder: false,
                  keyboardType: TextInputType.multiline,
                  inputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  onSubmitted: (v) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorEmailPassMessage.value ="يرجى التأكد من معلومات الدخول";
                      return "";
                    }
                    if (v.length < 6) {
                      errorEmailPassMessage.value =
                      "يرجى التأكد من معلومات الدخول";
                      return "";
                    }
                    return null;
                  },
                  hint: "مثال : 12345678",
                ),
                SizedBox(height: 3.h),
                Obx(() {
                  if (errorEmailMessage.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CommonViews().customText(
                          textContent:  errorEmailMessage.value,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,textColor: Colors.red)
                    );
                  }
                  if (errorEmailPassMessage.isNotEmpty) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CommonViews().customText(
                            textContent:  errorEmailPassMessage.value,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,textColor: Colors.red)
                    );
                  }
                  if (controller.errorEmailLoginMessage.isNotEmpty) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CommonViews().customText(
                            textContent:controller.errorEmailLoginMessage.value,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,textColor: Colors.red)
                    );
                  }
                  return const SizedBox.shrink();
                }),
                SizedBox(height: 3.h),
                CommonViews().customClickableContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 24,
                      ),
                      CommonViews().customText(
                        textContent: "تسجيل الدخول",
                        fontSize: 11.sp,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  onTap: () {
                    errorEmailMessage.value="";
                    errorEmailPassMessage.value="";
                    if (_keyEmail.currentState!.validate()) {
                      errorEmailMessage.value="";
                      errorEmailPassMessage.value="";
                      General.savePrefString(
                          ConstantValues.PASSWORD, _passEmailController.text);
                      controller.loginWithEmail(
                          email: _emailController.text,
                          password: _passEmailController.text,
                          reqType: "email");
                    }
                  },
                ),
                SizedBox(height: 7.h),
              ],
            ),
          ),
        ),
        WayOfLogin(
          title: "من خلال رقم الهاتف",
          view: Form(
            key: _keyPhone,
            child: Column(
              children: [
                SizedBox(height: 3.h),
                CommonViews().customText(
                  textContent: "رقم الهاتف",
                  fontSize: 12.sp,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(height: 1.h),
                CommonViews().createTextFormField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  onSubmitted: (v) => _passPhoneFocusNode.requestFocus(),
                  errorBorder: false,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                       errorPhoneMessage.value= "يرجى التأكد من معلومات الدخول";
                       return "";
                    }
                    if (v.length < 10) {
                      errorPhoneMessage.value="يرجى التأكد من معلومات الدخول";
                      return "";
                    }
                    if (v.length > 10) {
                      errorPhoneMessage.value="يرجى التأكد من معلومات الدخول";
                      return "";
                    }
                    if (v.contains(" ")) {
                      errorPhoneMessage.value="يرجى التأكد من معلومات الدخول";
                      return "";
                    }
                    if (!v.startsWith("07")) {
                      errorPhoneMessage.value= "يرجى التأكد من معلومات الدخول";
                      return "";
                    }
                    return null;
                  },
                  hint: "مثال : 0790000000",
                ),
                SizedBox(height: 2.h),
                CommonViews().customText(
                  textContent: "كلمة السر",
                  fontSize: 12.sp,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(height: 1.h),
                CommonViews().createTextFormField(
                    controller: _passPhoneController,
                    focusNode: _passPhoneFocusNode,
                    inputAction: TextInputAction.done,
                    isObscure: true,
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.center,
                    onSubmitted: (v) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        errorPhonePassMessage.value = "يرجى التأكد من معلومات الدخول";
                        return "";
                      }
                      if (v.length < 6) {
                        errorPhonePassMessage.value =
                        "يرجى التأكد من معلومات الدخول";
                        return "";
                      }
                      return null;
                    },
                    hint: "مثال : 12345678",
                    errorBorder: false),
                SizedBox(height: 3.h),
                Obx(() {
                  if (errorPhoneMessage.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        errorPhoneMessage.value,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    );
                  }
                  if (errorPhonePassMessage.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        errorPhonePassMessage.value,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    );
                  }
                  if (controller.errorPhoneLoginMessage.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        controller.errorPhoneLoginMessage.value,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                SizedBox(height: 3.h),
                CommonViews().customClickableContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 24,
                        color: Colors.black,
                      ),
                      CommonViews().customText(
                        textContent: "تسجيل الدخول",
                        fontSize: 11.sp,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  onTap: () {
                    errorPhonePassMessage.value = '';
                    errorPhoneMessage.value="";
                    if (_keyPhone.currentState!.validate()) {
                      errorPhonePassMessage.value = '';
                      errorPhoneMessage.value="";
                      General.savePrefString(
                          ConstantValues.PASSWORD, _passPhoneController.text);
                      controller.loginWithPhone(
                          phone: _phoneController.text,
                          password: _passPhoneController.text,
                          reqType: "phone");
                    }
                  },
                ),
                SizedBox(height: 7.h),
              ],
            ),
          ),
          isSelected: true,
        ),
      ],
    );
  }

  void _changeItem(int index) {
    setState(() {
      for (int i = 0; i < _wayOfLogin.length; i++) {
        _wayOfLogin[i].isSelected = i == index;
      }
    });
  }

  bool isValidEmail(String value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}

class WayOfLogin {
  String title;
  bool isSelected;
  Widget view;

  WayOfLogin({
    required this.title,
    this.isSelected = false,
    required this.view,
  });
}
