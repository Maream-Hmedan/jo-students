import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:oktoast/oktoast.dart';

import 'interactive_request.dart';
import 'interactive_response.dart';


class InterActiveController extends GetxController {
  var likesMap = <String, bool>{}.obs;
  var dislikesMap = <String, bool>{}.obs;

  String _getKey(int bookId) => '$bookId';

  addLike({required int bookId}) async {
    try {
      int? userID = await General.getPrefInt(ConstantValues.ID);
      InterActiveRequest request = InterActiveRequest(
          userid: userID ?? -1,
          bookId: bookId,
          );
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.LIKE_URL,
        body: request.toJson(),
      ).post();
      if (response != null && response.body != null) {
        InterActiveResponse interActiveResponse =
        InterActiveResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200) {
          if (interActiveResponse.status == 1) {
            likesMap[_getKey(bookId)] = true;
            dislikesMap[_getKey(bookId)] = false;
          }
        }
      }
    } catch (_) {
      showToast("Something went wrong",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  addDisLike({required int bookId}) async {
    try {
      int? userID = await General.getPrefInt(ConstantValues.ID);
      InterActiveRequest request = InterActiveRequest(
          userid: userID ?? -1,
          bookId: bookId);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.DISLIKE_URL,
        body: request.toJson(),
      ).post();
      if (response != null && response.body != null) {
        InterActiveResponse interActiveResponse =
        InterActiveResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200) {
          if (interActiveResponse.status == 1) {
            dislikesMap[_getKey(bookId)] = true;
            likesMap[_getKey(bookId)] = false;
          }
        }
      }
    } catch (_) {
      showToast("Something went wrong",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  bool isLiked(int bookId) {
    return likesMap[_getKey(bookId)] ?? false;
  }

  bool isDisliked(int bookId, int subjectId) {
    return dislikesMap[_getKey(bookId)] ?? false;
  }
}
