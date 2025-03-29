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

import 'library_request.dart';
import 'library_response.dart';


enum ApiStatus { loading, empty, error, success }

class LibraryGetController extends GetxController {
  var library = <LibraryResponse>[].obs;
  var status = ApiStatus.loading.obs;


  @override
  void onInit() {
    super.onInit();
    initController();
  }
  Future<void> initController() async {
    String loginTrx = await General.getPrefString(ConstantValues.MSG, "");
    await checkUser(loginTrx: loginTrx);
  }

  checkUser({required String loginTrx }) async {
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
          int? classId = checkUserResponse.classid;
          fetchLibraryBooksFromApi( classId);
        }
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    } finally {
      ProgressHud.shared.stopLoading();
    }
  }

  fetchLibraryBooksFromApi(int? classID) async {
    if (classID == null) {
      showToast("Invalid data received",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
      return;
    }

    try {
      LibraryRequest request = LibraryRequest(
          classid:  classID );
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.LIBRARY_URL,
        body: request.toJson(),
      ).post();
      if (response!.statusCode == 200) {
        if (response.body != null) {
          List data = jsonDecode(utf8.decode(response.body!));
          status.value = ApiStatus.success;
          library.value =
              data.map((item) => LibraryResponse.fromJson(item))
                  .toList();
        } else {
          status.value = ApiStatus.empty;
          Get.snackbar('Error', 'An error occurred while fetching book');
        }
      } else {
        status.value = ApiStatus.error;
      }
    } catch (e) {
      showToast("Something went wrong while fetching library: $e",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }



  bool get isLoading => status.value == ApiStatus.loading;

  bool get isEmpty => status.value == ApiStatus.empty;

  bool get isError => status.value == ApiStatus.error;

  bool get isSuccess => status.value == ApiStatus.success;
}
