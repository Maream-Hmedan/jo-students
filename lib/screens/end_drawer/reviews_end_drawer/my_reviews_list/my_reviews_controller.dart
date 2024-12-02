import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_request.dart';
import 'package:jo_students/check_user/check_user_response.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/reviews_end_drawer/add_book_to_review/add_book_to_review_request.dart';
import 'package:jo_students/screens/end_drawer/reviews_end_drawer/add_book_to_review/add_book_to_review_response.dart';
import 'package:jo_students/screens/end_drawer/reviews_end_drawer/reviews_screen.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/helpers/progress_hud.dart';
import 'package:oktoast/oktoast.dart';

import 'my_reviews_request.dart';
import 'my_reviews_response.dart';

enum ApiStatus { loading, empty, error, success }
class MyReviewsController extends GetxController {
  var myReviews = <MyReviewsListResponse>[].obs;
  var status = ApiStatus.loading.obs;
  int? semesterId;
  int? classId;

  @override
  void onInit() {
    super.onInit();
    _initController();
  }

  void _initController() async {
    String loginTrx = await General.getPrefString(ConstantValues.MSG, "");
    await checkUser(loginTrx: loginTrx);
  }

  checkUser({required String loginTrx}) async {
    try {
      int userId = await General.getPrefInt(ConstantValues.ID) ?? -1;
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
          semesterId = checkUserResponse.semesterid;
          classId = checkUserResponse.classid;
          await fetchMyReviewFromApi(userID: userId, classID: classId, semesterID: semesterId);
        }
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    } finally {
      ProgressHud.shared.stopLoading();
    }
  }

  fetchMyReviewFromApi(
      {required userID, required classID, required semesterID}) async {
    try {
      MyReviewsListRequest request = MyReviewsListRequest(
          studentId: userID, classid: classID, semesterId: semesterID);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.MY_REVIEWS_LISTS_URL,
        body: request.toJson(),
      ).post();

      if (response!.statusCode == 200) {
        if (response.body != null) {
          List data = jsonDecode(utf8.decode(response.body!));
          if (data.isEmpty) {
            status.value = ApiStatus.empty;
          }else{
            myReviews.value =
                data.map((item) => MyReviewsListResponse.fromJson(item)).toList();
            status.value = ApiStatus.success;
          }
        } else {
          status.value = ApiStatus.empty;
          Get.snackbar('Error', 'An error occurred while fetching reviews');
        }
      } else {
        status.value = ApiStatus.error;
      }
    } catch (e) {
      showToast("Something went wrong while fetching reviews: $e",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }


  addBookToReviewFromApi(
      {required bookID, required listID}) async {
    try {
      AddBookToListRequest request = AddBookToListRequest(bookId: bookID,
          listId: listID);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.ADD_BOOK_TO_REVIEWS_LISTS_URL,
        body: request.toJson(),
      ).post();
      if (response != null && response.body != null) {
        AddBookToListResponse addBookToListResponse =
        AddBookToListResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200 && addBookToListResponse.status == 1) {
          AppNavigator.of(Get.context!).pop();
        await refreshReviews();
          General.savePrefInt(ConstantValues.selectedIndexKey, 4);
          AppNavigator.of(Get.context!).push(const ReviewsScreen());

        }
      }else {
        status.value = ApiStatus.error;
      }
    } catch (e) {
      showToast("Something went wrong while fetching reviews: $e",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  // fetchMyReviewById({required  listID }) async {
  //   if(semesterId!= null && classId !=null){
  //     try {
  //       int userId = await General.getPrefInt(ConstantValues.ID) ?? -1;
  //
  //       MyReviewIdRequest request =
  //       MyReviewIdRequest(studentId: userId,
  //            listId: listID,
  //           classid: classId!, semesterId: semesterId!);
  //       ApiResponse? response = await HttpWrapper(
  //         context: Get.context,
  //         url: ApiEndPoint.MY_QUESTION_BY_ID_URL,
  //         body: request.toJson(),
  //       ).post();
  //       if (response!.statusCode == 200) {
  //         if (response.body != null) {
  //           List data = jsonDecode(utf8.decode(response.body!));
  //           status.value = ApiStatus.success;
  //           myQuestionID.value =
  //               data.map((item) => MyQuestionIdResponse.fromJson(item)).toList();
  //         } else {
  //           status.value = ApiStatus.empty;
  //           Get.snackbar('Error', 'An error occurred while fetching question id');
  //         }
  //       } else {
  //         status.value = ApiStatus.error;
  //       }
  //     } catch (e) {
  //       showToast("Something went wrong while question id: $e",
  //           backgroundColor: Colors.red, duration: const Duration(seconds: 3));
  //     }
  //   }
  //
  // }


  Future<void> refreshReviews() async {
    int userId = await General.getPrefInt(ConstantValues.ID) ?? -1;
    await fetchMyReviewFromApi(userID: userId, classID: classId, semesterID: semesterId);
  }

  bool get isLoading => status.value == ApiStatus.loading;
  bool get isEmpty => status.value == ApiStatus.empty;
  bool get isError => status.value == ApiStatus.error;
  bool get isSuccess => status.value == ApiStatus.success;
}


