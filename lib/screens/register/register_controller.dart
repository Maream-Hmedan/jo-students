import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/screens/login/login_screen.dart';
import 'package:jo_students/screens/register/register_request.dart';
import 'package:jo_students/screens/register/register_response.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/progress_hud.dart';
import 'package:oktoast/oktoast.dart';
class RegisterController extends GetxController {
  final errorRegisterMessage = RxString('');
  register(
      {required String fullName,
      required String email,
      required String phone,
      required String password}) async {
    try {
      RegisterRequest req = RegisterRequest(
          txtemail: email,
          txtfullname: fullName,
          txtpass: password,
          txtphone: phone);
      ApiResponse? response = await HttpWrapper(
              context: Get.context!,
              showLoading: true,
              url: ApiEndPoint.REGISTER_URL,
              body: req.toJson())
          .post();
      if (response != null && response.body != null){
        RegisterResponse registerResponse =
        RegisterResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200) {
          if (registerResponse.status == 1) {
            AppNavigator.of(Get.context!)
                .pushAndRemoveUntil(const LoginScreen());
          }
          else if(registerResponse.status == 0) {
          return  errorRegisterMessage.value=registerResponse.msg??"";
          } else{
            showToast("Make sure that you have entered all fields",
                backgroundColor: Colors.blueGrey,
                duration: const Duration(seconds: 4));
          }
        } else {
          showToast("Something went wrong",
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3));
        }
      }

    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
      ProgressHud.shared.stopLoading();
    }
  }


}



