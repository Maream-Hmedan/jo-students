import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_request.dart';
import 'package:jo_students/check_user/check_user_response.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_classes_dialog/class_name/class_name_request.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/helpers/progress_hud.dart';
import 'package:oktoast/oktoast.dart';

import 'class_name_response.dart';

class ClassNameController extends GetxController {
  var className = ''.obs;

  void updateClassName(String newClassName) {
    className.value = newClassName;
  }

  @override
  void onInit() {
    super.onInit();
    initController();
  }

  Future<void> initController() async {
    String loginTrx = await General.getPrefString(ConstantValues.MSG, "");
    await checkUser(loginTrx: loginTrx);
  }

  checkUser({required String loginTrx}) async {
    try {
      CheckUserRequest request = CheckUserRequest(loginTrx: loginTrx);
      ApiResponse? response = await HttpWrapper(
        context: Get.context!,
        url: ApiEndPoint.CHECK_USER_URL,
        body: request.toJson(),
      ).post();

      if (response != null && response.body != null) {
        CheckUserResponse checkUserResponse =
            CheckUserResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200) {
          fetchClassNameFromApi(checkUserResponse.classid);
        }
      }
    } catch (e) {
      ProgressHud.shared.stopLoading();
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  fetchClassNameFromApi(int classID) async {
    try {
      ClassNameRequest request = ClassNameRequest(classid: classID);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.CLASSES_NAME_URL,
        body: request.toJson(),
      ).post();
      if (response!.statusCode == 200) {
        if ((response.body != null)) {
          ClassNameResponse classNameResponse =
              ClassNameResponse.fromRawJson(utf8.decode(response.body!));
          if (response.statusCode == 200) {
            className.value = classNameResponse.className;
          }
        }
      }
    } catch (_) {}
  }
}
