import 'package:flutter/material.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/screens/login/login_using.dart';
import 'package:jo_students/screens/register/register_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        backgroundColor: AppColors.secondaryBackGroundColorLight,
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 100.w,
            height: 100.h,
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                CommonViews().customText(
                  textContent: "تسجيل الدخول",
                  textColor: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CommonViews().customText(
                      textContent:
                      "ادخل رقم الهاتف او البريد الإلكتروني الذي قمت   ",
                      textColor: Colors.grey.shade700,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CommonViews().customText(
                      textContent: "بالتسجيل به, وابدأ تجربتك   ",
                      textColor: Colors.grey.shade700,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  height: 3.h,
                ),
                const LoginUsing(),

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
                            textContent: "انشاء حساب جديد",
                            textColor: const Color.fromRGBO(50, 155, 142, 1),
                            fontSize: 12.sp,
                            onTap: () {
                              AppNavigator.of(context).push(
                                  const RegisterScreen());
                            }),
                      ],
                    ),
                    CommonViews().customText(
                      textContent: "ليس لديك حساب بعد؟",
                      textColor: Colors.black,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
