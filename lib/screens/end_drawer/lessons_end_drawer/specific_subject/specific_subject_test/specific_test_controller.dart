import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_request.dart';
import 'package:jo_students/check_user/check_user_response.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:oktoast/oktoast.dart';

import 'specific_test_request.dart';
import 'specific_test_response.dart';



enum ApiStatus { loading, empty, error, success }

class BooksTestController extends GetxController {
  var booksTestResponse = <BooksTestResponse>[].obs;
  var status = ApiStatus.loading.obs;
  checkUser({required String loginTrx,required int subjectID}) async {
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
          fetchBooksTestFromApi(
              semesterID: checkUserResponse.semesterid,
              classID: checkUserResponse.classid,subjectID: subjectID);
        }
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }


  fetchBooksTestFromApi(
      {required int semesterID,
        required int classID,
        required int subjectID}) async {
    try {
      BooksTestRequest request = BooksTestRequest(
          semesterId: semesterID, classId: classID, subjectId: subjectID);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.LOAD_BOOKS_TEST_SUBJECTID,
        body: request.toJson(),
      ).post();
      if (response!.statusCode == 200) {
        if (response.body != null) {
          List data = jsonDecode(utf8.decode(response.body!));
          status.value = ApiStatus.success;
          booksTestResponse.value = data
              .map((item) =>BooksTestResponse.fromJson(item))
              .toList();
        } else {
          status.value = ApiStatus.empty;
          Get.snackbar('Error', 'An error occurred while fetching data');
        }
      } else {
        status.value = ApiStatus.error;
      }
    } catch (_) {
      showToast("Something went wrong",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  bool get isLoading => status.value == ApiStatus.loading;

  bool get isEmpty => status.value == ApiStatus.empty;

  bool get isError => status.value == ApiStatus.error;

  bool get isSuccess => status.value == ApiStatus.success;
}
