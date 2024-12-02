import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/login/login_screen.dart';
import 'package:jo_students/screens/register/register_controller.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController controller = Get.put(RegisterController());

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passConformController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _passConformFocusNode = FocusNode();

  final errorNameMessage = RxString('');
  final errorPhoneMessage = RxString('');
  final errorEmailMessage = RxString('');
  final errorPassMessage = RxString('');
  final errorConPassMessage = RxString('');

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        backgroundColor: AppColors.secondaryBackGroundColorLight,
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 100.w,
              height: 100.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  CommonViews().customText(
                    textContent: "انشاء حساب جديد",
                    textColor: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  CommonViews().customText(
                    textContent: "لطفا قم بتعبئة تفاصيل التسجيل في الاسفل",
                    textColor: Colors.grey.shade700,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w200,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CommonViews().customText(
                        textContent: "الاسم الثلاثي   ",
                        fontSize: 10.sp,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CommonViews().createTextFormField(
                      controller: _nameController,
                      errorBorder: false,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          errorNameMessage.value = "يرجى ادخال الاسم الثلاثي";
                          return "";
                        }
                        return null;
                      },
                      focusNode: _nameFocusNode,
                      keyboardType: TextInputType.name,
                      onSubmitted: (v) {
                        _phoneFocusNode.requestFocus();
                      },
                      hint: "احمد محمد عبدالله"),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CommonViews().customText(
                        textContent: "رقم الهاتف   ",
                        fontSize: 10.sp,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CommonViews().createTextFormField(
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      errorBorder: false,
                      keyboardType: TextInputType.phone,
                      onSubmitted: (v) {
                        _emailFocusNode.requestFocus();
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
                      hint: "مثال : 0790000000"),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CommonViews().customText(
                        textContent: "البريد الالكتروني   ",
                        fontSize: 10.sp,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CommonViews().createTextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      errorBorder: false,
                      onSubmitted: (v) {
                        _passFocusNode.requestFocus();
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
                      hint: "   jostudents@gmail.com : مثال "),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CommonViews().customText(
                        textContent: "كلمة السر   ",
                        fontSize: 10.sp,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CommonViews().createTextFormField(
                      isObscure: true,
                      controller: _passController,
                      focusNode: _passFocusNode,
                      errorBorder: false,
                      keyboardType: TextInputType.multiline,
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
                      hint: "مثال : 12345678"),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CommonViews().customText(
                        textContent: "تأكيد كلمة السر   ",
                        fontSize: 10.sp,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CommonViews().createTextFormField(
                      controller: _passConformController,
                      errorBorder: false,
                      focusNode: _passConformFocusNode,
                      keyboardType: TextInputType.multiline,
                      inputAction: TextInputAction.done,
                      isObscure: true,
                      onSubmitted: (v) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
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
                      hint: "مثال : 12345678"),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                    width: 100.w,
                    height: 8.h,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'بإنشائك حساباً على جو ستيودنتس فأنت توافق على ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              fontFamily: 'GE Dinar One',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: 'شروط الخدمة و سياسة الخصوصية ',
                            style: TextStyle(
                              color: const Color.fromRGBO(50, 155, 142, 1),
                              fontSize: 12.sp,
                              fontFamily: 'GE Dinar One',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
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
                    if (controller.errorRegisterMessage.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          controller.errorRegisterMessage.value,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  SizedBox(
                    height: 1.h,
                  ),
                  CommonViews().customClickableContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonViews().customText(
                            textContent: "انشاء حساب جديد",
                            fontSize: 11.sp,
                            textColor: Colors.black,
                            fontWeight: FontWeight.w400),
                        const Icon(
                          Icons.person_outline,
                          size: 24,
                        ),
                      ],
                    ),
                    onTap: () {
                      errorNameMessage.value = "";
                      errorPhoneMessage.value = "";
                      errorEmailMessage.value = "";
                      errorPassMessage.value = "";
                      errorConPassMessage.value = "";
                      if (_key.currentState!.validate()) {
                        errorNameMessage.value = "";
                        errorPhoneMessage.value = "";
                        errorEmailMessage.value = "";
                        errorPassMessage.value = "";
                        errorConPassMessage.value = "";
                        General.savePrefString(
                            ConstantValues.PASSWORD, _passController.text);
                        controller.register(
                            fullName: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            password: _passController.text);
                      }
                    },
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            size: 20,
                            color: Color.fromRGBO(50, 155, 142, 1),
                          ),
                          CommonViews().customClickableText(
                              textContent: "تسجيل الدخول",
                              textColor: const Color.fromRGBO(50, 155, 142, 1),
                              fontSize: 12.sp,
                              onTap: () {
                                AppNavigator.of(context).push(const LoginScreen());
                              }),
                        ],
                      ),
                      CommonViews().customText(
                        textContent: "لديك حساب ؟",
                        textColor: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
