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
import 'package:webview_flutter/webview_flutter.dart';

import 'specific_lessons_card_request.dart';
import 'specific_lessons_card_response.dart';

enum ApiStatus { loading, empty, error, success }

class SpecificCardDetailsController extends GetxController {
  var webViewController = Rxn<WebViewController>();
  var teacherName = ''.obs;
  var subjectName = ''.obs;
  var bookName = ''.obs;
  var grade = ''.obs;
  var semester = ''.obs;
  var numberOfOther = ''.obs;
  var status = ApiStatus.loading.obs;
  var semesterId = 0.obs;
  var classId = 0.obs;
  var contentHeight = 0.0.obs;
  var contentWidth = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeWebView();
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
    } finally {
      ProgressHud.shared.stopLoading();
    }
    return null;
  }


  void _initializeWebView() {
    webViewController.value ??= WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF0F0F0))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          // Inject JavaScript to enable zoom and adjust viewport
          webViewController.value?.runJavaScript('''
          var meta = document.createElement('meta');
          meta.name = 'viewport';
          meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=yes';
          document.getElementsByTagName('head')[0].appendChild(meta);
        ''');
        },
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ));
  }

  void _loadHtmlContent(String htmlContent) async {
    final Uri uri = Uri.dataFromString(
      htmlContent,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    );
    await webViewController.value?.loadRequest(uri);
  }

  Future<void> fetchDetailsCard(
      {required int bookId, required int subjectId}) async {
    try {
      SpecificCardRequest request = SpecificCardRequest(
          bookId: bookId,
          subjectId: subjectId,
          semesterId: semesterId.value,
          classId: classId.value);
      ApiResponse? response = await HttpWrapper(
        context: Get.context!,
        url: ApiEndPoint.LOAD_BOOK_DETAILS,
        body: request.toJson(),
      ).post();

      if (response != null && response.body != null) {
        SpecificCardResponse specificCardResponse =
        SpecificCardResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200) {
          status.value = ApiStatus.success;
          _loadHtmlContent(specificCardResponse.bookDescriptionAndroid);
          subjectName.value = specificCardResponse.bookTitle;
          bookName.value = specificCardResponse.subjectTitleAr;
          semester.value = specificCardResponse.semesterTitleAr;
          teacherName.value = specificCardResponse.tFullName;
          numberOfOther.value = specificCardResponse.numberOfOtherBooks;
          grade.value = specificCardResponse.classTitleAr;
        } else {
          status.value = ApiStatus.empty;
        }
      }
    } catch (e) {
      ProgressHud.shared.stopLoading();
      status.value = ApiStatus.error;
      showToast("Something went wrong $e",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  bool get isLoading => status.value == ApiStatus.loading;

  bool get isEmpty => status.value == ApiStatus.empty;

  bool get isError => status.value == ApiStatus.error;

  bool get isSuccess => status.value == ApiStatus.success;
}
