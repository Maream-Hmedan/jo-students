import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_controller.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/dashboard_screen.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/screens/login/login_request_email.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/helpers/progress_hud.dart';
import 'package:oktoast/oktoast.dart';
import 'login_request_phone.dart';
import 'login_response.dart';

class LoginController extends GetxController {
  final errorPhoneLoginMessage = RxString('');
  final errorEmailLoginMessage = RxString('');
  final CheckUserController checkUserController =
      Get.put(CheckUserController());

  loginWithPhone(
      {required String phone,
      required String password,
        bool showLoading=true,
      required String reqType}) async {
    try {
      LoginRequestPhone req = LoginRequestPhone(
          txtphone: phone.trim(), sPassword: password.trim(), reqType: reqType);
      ApiResponse? response = await HttpWrapper(
              context: Get.context!,
              showLoading: showLoading,
              url: ApiEndPoint.LOGIN_URL,
              body: req.toJson())
          .post();
      if (response != null && response.body != null) {
        LoginResponse loginResponse =
            LoginResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200) {
          if (loginResponse.status == 1) {
            General.savePrefString(ConstantValues.MSG, loginResponse.msg);//todo
            await checkUserController.checkUser();
            bool userChecked = await checkUserController.checkUser();
            if (userChecked) {
              AppNavigator.of(Get.context!)
                  .pushAndRemoveUntil(const DashboardScreen());
            }else {
              showToast("User verification failed", // Custom message
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 5));
            }
          }else if (loginResponse.status == 0) {
            return  errorPhoneLoginMessage.value= "يرجى التأكد من معلومات الدخول";
          }
        }
      }
    } catch (_) {
      ProgressHud.shared.stopLoading();
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  loginWithEmail(
      {required String email,
        bool showLoading=true,
      required String password,
      required String reqType}) async {
    try {
      LoginRequestEmail req = LoginRequestEmail(
          sPassword: password.trim(),
          reqType: reqType,
          sEmailAdd: email.trim());
      ApiResponse? response = await HttpWrapper(
              context: Get.context!,
              showLoading:showLoading,
              url: ApiEndPoint.LOGIN_URL,
              body: req.toJson())
          .post();
      if (response != null && response.body != null) {
        LoginResponse loginResponse =
            LoginResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200) {
          if (loginResponse.status == 1) {
            General.savePrefString(ConstantValues.MSG, loginResponse.msg);
            await checkUserController.checkUser();
            bool userChecked = await checkUserController.checkUser();
            if (userChecked) {
              AppNavigator.of(Get.context!)
                  .pushAndRemoveUntil(const DashboardScreen());
            }else {
              showToast("User verification failed", // Custom message
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 5));
            }
          } else if (loginResponse.status == 0) {
            return  errorEmailLoginMessage.value= "يرجى التأكد من معلومات الدخول";
          }
        }
      }
    } catch (_) {
      ProgressHud.shared.stopLoading();
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }
}
