import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/reviews_end_drawer/my_reviews_list/my_reviews_controller.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:oktoast/oktoast.dart';
import 'delete_review_request.dart';
import 'delete_review_response.dart';

class DeleteReviewController extends GetxController {
  Future<void> deleteReview({required int txtID}) async {
    try {
      int userID = await General.getPrefInt(ConstantValues.ID) ?? -1;
      DeleteReviewRequest request = DeleteReviewRequest(
        userid: userID,
        txtqid: txtID,
      );
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.DELETE_REVIEWS_LISTS_URL,
        body: request.toJson(),
      ).post();

      if (response != null && response.body != null) {
        DeleteReviewResponse deleteReviewResponse =
        DeleteReviewResponse.fromRawJson(utf8.decode(response.body!));

        if (response.statusCode == 200 && deleteReviewResponse.status == 1) {
          MyReviewsController myReviewsController = Get.find<MyReviewsController>();
          myReviewsController.refreshReviews();
          AppNavigator.of(Get.context!).pop();
        }
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }
}








