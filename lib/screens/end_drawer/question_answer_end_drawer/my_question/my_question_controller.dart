import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:oktoast/oktoast.dart';

import 'my_question_id_request.dart';
import 'my_question_id_response.dart';
import 'my_question_request.dart';
import 'my_question_response.dart';

enum ApiStatus { loading, empty, error, success }

class MyQuestionController extends GetxController {
  var myQuestions = <MyQuestionResponse>[].obs;
  var myQuestionID = <MyQuestionIdResponse>[].obs;
  var status = ApiStatus.loading.obs;
  var semester = "".obs;
  var grade = "".obs;

  @override
  void onInit() {
    super.onInit();
    _initController();
  }

  void _initController() async {
    int userId = await General.getPrefInt(ConstantValues.ID) ?? -1;
    fetchMyQuestionFromApi(userID: userId);
  }


  fetchMyQuestionFromApi({required userID}) async {
    try {
      MyQuestionRequest request = MyQuestionRequest(studentId: userID);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.MY_QUESTION_URL,
        body: request.toJson(),
      ).post();
      if (response!.statusCode == 200) {
        if (response.body != null) {
          List data = jsonDecode(utf8.decode(response.body!));
          status.value = ApiStatus.success;
          myQuestions.value =
              data.map((item) => MyQuestionResponse.fromJson(item)).toList();
        } else {
          status.value = ApiStatus.empty;
          Get.snackbar('Error', 'An error occurred while fetching question');
        }
      } else {
        status.value = ApiStatus.error;
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  fetchMyQuestionById({required userID, required quesID}) async {
    try {
      MyQuestionIdRequest request =
          MyQuestionIdRequest(studentId: userID, questionId: quesID);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.MY_QUESTION_BY_ID_URL,
        body: request.toJson(),
      ).post();
      if (response!.statusCode == 200) {
        if (response.body != null) {
          List data = jsonDecode(utf8.decode(response.body!));
          status.value = ApiStatus.success;
          myQuestionID.value =
              data.map((item) => MyQuestionIdResponse.fromJson(item)).toList();
        } else {
          status.value = ApiStatus.empty;
          Get.snackbar('Error', 'An error occurred while fetching question id');
        }
      } else {
        status.value = ApiStatus.error;
      }
    } catch (e) {
      showToast("Something went wrong while question id: $e",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }


  Future<void> refreshQuestions() async {
    int userId = await General.getPrefInt(ConstantValues.ID) ?? -1;
    await fetchMyQuestionFromApi(userID: userId);
  }




  bool get isLoading => status.value == ApiStatus.loading;

  bool get isEmpty => status.value == ApiStatus.empty;

  bool get isError => status.value == ApiStatus.error;

  bool get isSuccess => status.value == ApiStatus.success;
}
