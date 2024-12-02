import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_request.dart';
import 'package:jo_students/check_user/check_user_response.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/question_answer_end_drawer/my_question/my_question_controller.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:oktoast/oktoast.dart';

import 'add_question_request.dart';
import 'add_question_response.dart';

class AddQuestionController extends GetxController {
  var semesterId = 0.obs;
  var classId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initController();
  }


  Future<void> initController() async {
    String loginTrx = await General.getPrefString(ConstantValues.MSG, "");
    var userResponse = await checkUser(loginTrx: loginTrx);
    if (userResponse != null) {
      semesterId.value = userResponse.semesterid;
      classId.value = userResponse.classid;
    }
  }

  Future<CheckUserResponse?> checkUser({required String loginTrx}) async {
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
          return checkUserResponse;
        }
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
    return null;
  }

  addQuestion({required int txtchkid,required txtMessage}) async {
    try {
      int? userID = await General.getPrefInt(ConstantValues.ID);
      AddQuestionRequest request = AddQuestionRequest(
        userid: userID ?? -1,
        classid: classId.value,
        semesterId: semesterId.value,
        txtchkid: txtchkid,
        txtMessage: txtMessage,
      );
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.ADD_QUESTION_URL,
        body: request.toJson(),
      ).post();
      if (response != null && response.body != null) {
        AddQuestionResponse addQuestionResponse =
        AddQuestionResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200 && addQuestionResponse.status == 1) {
          AppNavigator.of(Get.context!).pop();
          if (userID != null) {
            Get.find<MyQuestionController>().refreshQuestions();
            showToast("تم اضافة سؤالك بنجاح",
                backgroundColor: Colors.green, duration: const Duration(seconds: 3));
          }
        }
      }
    } catch (_) {
      showToast("Something went wrong",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }
}
