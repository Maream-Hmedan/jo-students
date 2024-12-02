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
import 'delete_question_request.dart';
import 'delete_question_response.dart';

class DeleteQuestionController extends GetxController {
  var semesterId = 0.obs;
  var classId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initController();
  }

  initController() async {
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
          semesterId.value = checkUserResponse.semesterid;
          classId.value = checkUserResponse.classid;
        }
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  deleteQuestion({required int questionId}) async {
    try {
      int? userID = await General.getPrefInt(ConstantValues.ID);
      if (userID == null || userID == -1) {
        showToast("User ID is not valid.",
            backgroundColor: Colors.red, duration: const Duration(seconds: 3));
        return;
      }
      DeleteQuestionRequest request = DeleteQuestionRequest(
        userid: userID,
        classid: classId.value,
        semesterId: semesterId.value, txtqid: questionId,
      );

      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.DELETE_QUESTION_URL,
        body: request.toJson(),
      ).post();

      if (response != null && response.body != null) {
        DeleteQuestionResponse deleteQuestionResponse =
        DeleteQuestionResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200 && deleteQuestionResponse.status == 1) {
          MyQuestionController myQuestionController = Get.find<MyQuestionController>();
          myQuestionController.refreshQuestions();
          AppNavigator.of(Get.context!).pop();
        }
      }
    } catch (_) {
      showToast("Something went wrong",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }
}

