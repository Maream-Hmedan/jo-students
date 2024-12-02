import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_request.dart';
import 'package:jo_students/check_user/check_user_response.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'specific_workbooks_request.dart';
import 'specific_workbooks_response.dart';
import 'workboke_details_response.dart';
import 'workbook_details_request.dart';

enum ApiStatus { loading, empty, error, success }

class WorkBooksController extends GetxController {
  var workBooksResponse = <WorkBooksResponse>[].obs;
  var status = ApiStatus.loading.obs;
  var webViewController = Rxn<WebViewController>();
  var semester = "".obs;
  var bookDesc = "".obs;
  var bookSubTitle = "".obs;
  var bookName = ''.obs;
  var grade = "".obs;
  var numberOfOther = ''.obs;
  var teacherName = "".obs;
  var semesterId = 0.obs;
  var classId = 0.obs;

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

  fetchWorkBooksFromApi({required int subjectId}) async {
    try {
      WorkBooksRequest request = WorkBooksRequest(
          semesterId: semesterId.value,
          classId: classId.value,
          subjectId: subjectId);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.LOAD_BOOKS_WORKBOOKS_SUBJECTID,
        body: request.toJson(),
      ).post();
      if (response!.statusCode == 200) {
        if (response.body != null) {
          List data = jsonDecode(utf8.decode(response.body!));
          status.value = ApiStatus.success;
          workBooksResponse.value =
              data.map((item) => WorkBooksResponse.fromJson(item)).toList();
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

  fetchWorkBooksDetailsFromApi(
      {required int bookID, required int subjectID}) async {
    try {
      WorkBookDetailsRequest request = WorkBookDetailsRequest(
          semesterId: semesterId.value,
          classId: classId.value,
          subjectId: subjectID,
          bookId: bookID);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.LOAD_BOOKS_WORKBOOKS_DETAILS,
        body: request.toJson(),
      ).post();
      if (response != null && response.body != null) {
        status.value = ApiStatus.success;
        WorkBookDetailsResponse workBookDetailsResponse =
        WorkBookDetailsResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200) {
          _loadHtmlContent(workBookDetailsResponse.bookDescription);
          semester.value = workBookDetailsResponse.semesterTitleAr;
          grade.value = workBookDetailsResponse.classTitleAr;
          teacherName.value = workBookDetailsResponse.tFullName;
          numberOfOther.value=workBookDetailsResponse.numberOfOtherBooks;
          bookName.value = workBookDetailsResponse.subjectTitleAr;
          bookSubTitle.value=workBookDetailsResponse.bookTitle;
        }
      } else {
        status.value = ApiStatus.empty;
        Get.snackbar('Error', 'An error occurred while fetching data');
      }
    } catch (_) {
      status.value = ApiStatus.error;
      showToast("Something went wrong",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  bool get isLoading => status.value == ApiStatus.loading;

  bool get isEmpty => status.value == ApiStatus.empty;

  bool get isError => status.value == ApiStatus.error;

  bool get isSuccess => status.value == ApiStatus.success;
}
