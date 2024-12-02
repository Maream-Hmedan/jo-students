import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:oktoast/oktoast.dart';

import 'subscription_request.dart';
import 'subscription_response.dart';




enum ApiStatus { loading, empty, error, success }

class SubscriptionController extends GetxController {
  var subscriptions = <SubscriptionResponse>[].obs;
  var filteredSubscriptions = <SubscriptionResponse>[].obs;
  var status = ApiStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionFromApi();
  }



  fetchSubscriptionFromApi() async {
    try {
      int? userID = await General.getPrefInt(ConstantValues.ID);
      SubscriptionRequest request = SubscriptionRequest(userid: userID ?? -1);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.SUBSCRIPTION_URL,
        body: request.toJson(),
      ).post();

      if (response!.statusCode == 200) {
        if (response.body != null) {
          List data = jsonDecode(utf8.decode(response.body!));
          if (data.isEmpty) {
            status.value = ApiStatus.empty;
          }else{
            List<SubscriptionResponse> subscriptionList = data
                .map((item) => SubscriptionResponse.fromJson(item))
                .toList();
            subscriptionList.sort((a, b) => b.studentSubId.compareTo(a.studentSubId));
            subscriptions.value = subscriptionList;
            filteredSubscriptions.value= subscriptions;
            status.value = ApiStatus.success;
          }

        }
      }
    } catch (e) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

  void filterLiveClasses(String query) {
    if (query.isEmpty) {
      filteredSubscriptions.value = subscriptions;
    } else {
      filteredSubscriptions.value = subscriptions.where((subscription) {
        return subscription.subjectTitleAr
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
  }

  void resetFilter() {
    filteredSubscriptions.value = subscriptions;
  }


  bool get isLoading => status.value == ApiStatus.loading;

  bool get isEmpty => status.value == ApiStatus.empty;

  bool get isError => status.value == ApiStatus.error;

  bool get isSuccess => status.value == ApiStatus.success;
}
