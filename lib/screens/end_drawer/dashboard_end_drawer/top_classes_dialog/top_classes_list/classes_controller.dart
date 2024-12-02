import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_classes_dialog/top_classes_list/classes_response.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:oktoast/oktoast.dart';


enum ApiStatus { loading, empty,error, success }

class ClassesController extends GetxController{
  var classes = <ClassesResponse>[].obs;
  var status = ApiStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    fetchClassesFromApi();
  }

  fetchClassesFromApi() async {
    ApiResponse? response = await HttpWrapper(
      context: Get.context,
      url: ApiEndPoint.CLASSES_URL,
    ).get();
    if(response!.statusCode==200){
      if (response.body != null) {
        List data = jsonDecode(utf8.decode(response.body!));
        status.value = ApiStatus.success;
        classes.value =
            data.map((item) => ClassesResponse.fromJson(item)).toList();
      } else {
        status.value = ApiStatus.empty;
        Get.snackbar('Error', 'An error occurred while fetching data');
      }
    }else{
      status.value = ApiStatus.error;
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }

  }
  bool get isLoading => status.value == ApiStatus.loading;
  bool get isEmpty=> status.value == ApiStatus.empty;

  bool get isError => status.value == ApiStatus.error;

  bool get isSuccess => status.value == ApiStatus.success;
}