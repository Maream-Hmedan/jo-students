import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_request.dart';
import 'package:jo_students/check_user/check_user_response.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/helpers/progress_hud.dart';
import 'package:oktoast/oktoast.dart';

import 'notification_request.dart';
import 'notification_response.dart';


enum ApiStatus { loading, empty,error, success }

class NotificationController extends GetxController{
  var notification = <NotificationResponse>[].obs;
  var status = ApiStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    _initController();
  }

  void _initController() async {
    String loginTrx = await General.getPrefString(ConstantValues.MSG, "");
    checkUser(loginTrx: loginTrx);
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
          int? semesterId = checkUserResponse.semesterid;
          int? classId = checkUserResponse.classid;
          fetchNotificationFromApi(semesterId, classId);
        }
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    } finally {
      ProgressHud.shared.stopLoading();
    }
  }

  fetchNotificationFromApi(int semesterId, int classId) async {
    try {
      int? userID = await General.getPrefInt(ConstantValues.ID);
      NotificationRequest request = NotificationRequest(
        semesterId: semesterId,
        classId: classId,
        userid: userID ?? -1,
      );

      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.NOTIFICATION_URL,
        body: request.toJson(),
      ).post();

      if (response != null && response.statusCode == 200) {
        if (response.body != null) {
          List data = jsonDecode(utf8.decode(response.body!));

          // Check if the decoded data list is empty
          if (data.isEmpty) {
            status.value = ApiStatus.empty;
          } else {
            notification.value =
                data.map((item) => NotificationResponse.fromJson(item)).toList();
            status.value = ApiStatus.success;
          }
        } else {
          // If response.body is null, consider it as empty
          status.value = ApiStatus.empty;
        }
      } else {
        status.value = ApiStatus.error;
        Get.snackbar('Error', 'An error occurred while fetching notification');
      }
    } catch (e) {
      status.value = ApiStatus.error;
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }
  bool get isLoading => status.value == ApiStatus.loading;
  bool get isEmpty=> status.value == ApiStatus.empty;

  bool get isError => status.value == ApiStatus.error;

  bool get isSuccess => status.value == ApiStatus.success;
}