import 'dart:async';
import 'package:jo_students/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/dashboard_screen.dart';
import 'package:jo_students/screens/intro/intro_page_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController controller = Get.put(LoginController());

  Future<void> _checkUserLogin() async {
    try {
      int? userId = await General.getPrefInt(ConstantValues.ID);
      if (userId != null) {
        _navigateToDashboard();
      } else {
        _navigateToIntroScreen();
      }
    } catch (_) {}
  }

  void _navigateToDashboard() async {
    String email = await General.getPrefString(ConstantValues.EMAIL, "");
    String phone = await General.getPrefString(ConstantValues.PHONE, "");
    String password = await General.getPrefString(ConstantValues.PASSWORD, "");
    if (email != "" && password != "") {
      controller.loginWithEmail(
        showLoading: false,
          email: email, password: password, reqType: "email");
      Timer(const Duration(seconds: 2), () {
        AppNavigator.of(context).pushReplacement(const DashboardScreen());
      });
    }
    else if (phone != "" && password != "") {
      controller.loginWithPhone(
          showLoading: false,
          phone: phone, password: password, reqType: "phone");
      Timer(const Duration(seconds: 2), () {
        AppNavigator.of(context).pushReplacement(const DashboardScreen());
      });
    } else {
      _navigateToIntroScreen();
    }
  }

  void _navigateToIntroScreen() {
    Timer(const Duration(seconds: 2), () {
      AppNavigator.of(context).pushReplacement(const IntroScreen());
    });
  }

  @override
  void initState() {
    _checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Center(
          child: Image.asset(
        appLogo,
        width: 60.w,
        height: 70.h,
      )),
    );
  }
}
