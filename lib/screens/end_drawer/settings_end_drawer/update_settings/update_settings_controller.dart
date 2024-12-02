import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:oktoast/oktoast.dart';
import 'update_settings_request.dart';
import 'update_settings_response.dart';

class UpdateSettingsController extends GetxController {
  var isLoading = false.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;
  @override
  void onInit() {
    super.onInit();
    loadInitialSettings();
  }

  Future<void> loadInitialSettings() async {
    email.value = await General.getPrefString(ConstantValues.EMAIL, "");
    phone.value = await General.getPrefString(ConstantValues.PHONE, "");
    password.value = await General.getPrefString(ConstantValues.PASSWORD, "");
  }

  Future<void> updateSettings({
    required String email,
    required String phone,
    required String pass,
  }) async {
    isLoading.value = true;
    this.email.value = email;
    this.phone.value = phone;
    password.value = pass;
    // Save updated values
    await General.savePrefString(ConstantValues.EMAIL, email);
    await General.savePrefString(ConstantValues.PHONE, phone);
    await General.savePrefString(ConstantValues.PASSWORD, pass);
    try {
      final int? userID = await General.getPrefInt(ConstantValues.ID);
      final request = UpdateMySettingsRequest(
        userid: userID ?? -1,
        txtemailadd: email,
        txtphonenumber: phone,
        txtpass: pass,
      );

      final response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.UPDATE_SETTINGS_URL,
        body: request.toJson(),
      ).post();

      if (response != null && response.body != null) {
        final updateMySettingsResponse = UpdateMySettingsResponse.fromRawJson(
            utf8.decode(response.body!));

        if (response.statusCode == 200 && updateMySettingsResponse.status == 1) {
          showToast("تم حفظ معلوماتك بنجاح",
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3));
        } else {
          showToast("Update failed",
              backgroundColor: Colors.red, duration: const Duration(seconds: 3));
        }
      } else {
        showToast("No response from server",
            backgroundColor: Colors.red, duration: const Duration(seconds: 3));
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    } finally {
      isLoading.value = false;
    }
  }
}
