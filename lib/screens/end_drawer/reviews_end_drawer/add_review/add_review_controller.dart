import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/reviews_end_drawer/add_review/add_review_request.dart';
import 'package:jo_students/screens/end_drawer/reviews_end_drawer/my_reviews_list/my_reviews_controller.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:oktoast/oktoast.dart';

import 'add_review_response.dart';


class AddReviewController extends GetxController {

  addReview({required txtName,required txtDescription}) async {
    try {
      int userID = await General.getPrefInt(ConstantValues.ID) ?? -1;
      AddMyReviewsListRequest request = AddMyReviewsListRequest(
        userid: userID,
        txtname: txtName, txtdescription: txtDescription,
      );
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.ADD_REVIEWS_LISTS_URL,
        body: request.toJson(),
      ).post();
      if (response != null && response.body != null) {
        AddMyReviewsListResponse addMyReviewsListResponse =
        AddMyReviewsListResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200 && addMyReviewsListResponse.status == 1) {
          AppNavigator.of(Get.context!).pop();
            Get.find<MyReviewsController>().refreshReviews();

        }
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }
}
