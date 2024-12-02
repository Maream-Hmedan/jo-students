import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/helpers/progress_hud.dart';
import 'package:oktoast/oktoast.dart';

import 'check_user_request.dart';
import 'check_user_response.dart';

enum ApiStatus { loading, empty, error, success }

class CheckUserController extends GetxController {
  var status = ApiStatus.loading.obs;
  var streakImage="".obs;
  var streakOuterImage="".obs;
  var streakText="".obs;
  var isSubscription=(-1).obs;
  var numberOfLoginStreak= (-1).obs;

  Future<bool> checkUser() async {
    try {

      String loginTrx = await General.getPrefString(ConstantValues.MSG, "");

      CheckUserRequest request = CheckUserRequest(
          loginTrx: loginTrx
      );
      ApiResponse? response = await HttpWrapper(
        context: Get.context!,
        url: ApiEndPoint.CHECK_USER_URL,
        body: request.toJson(),
      ).post();

      if (response != null && response.body != null) {
        CheckUserResponse checkUserResponse =
        CheckUserResponse.fromRawJson(utf8.decode(response.body!));

        if (response.statusCode == 200) {
          General.savePrefInt(ConstantValues.ID, checkUserResponse.userid);
          General.savePrefString(ConstantValues.EMAIL, checkUserResponse.sEmailAdd);
          General.savePrefString(ConstantValues.NAME, checkUserResponse.sFirstName);
          General.savePrefString(ConstantValues.PHONE, checkUserResponse.sPhoneNumber);
          General.savePrefInt(ConstantValues.showSubscriptionButton, checkUserResponse.intIsSubActive);
          isSubscription.value=checkUserResponse.intIsSubActive;
          streakImage.value = checkUserResponse.strLoginStreakImage;
          streakOuterImage.value = checkUserResponse.strLoginStreakOuterImage;
          streakText.value = checkUserResponse.strLoginStreakText;

          numberOfLoginStreak.value = checkUserResponse.intNumberOfLoginStreak;
          status.value = ApiStatus.success;
          //todo add the user in current session
          //todo add message in current session
          // save the username and password on shared prefs
          return true;
        } else {
          ProgressHud.shared.stopLoading();
          status.value = ApiStatus.error;
        }
      }
    } catch (e) {
      status.value = ApiStatus.error;
      ProgressHud.shared.stopLoading();
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
    return false;
  }



  bool get isLoading => status.value == ApiStatus.loading;

  bool get isSuccess => status.value == ApiStatus.success;
}

