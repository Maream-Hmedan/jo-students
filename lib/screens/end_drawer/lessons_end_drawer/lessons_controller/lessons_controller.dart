import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:oktoast/oktoast.dart';

import 'lessons_request.dart';
import 'lessons_response.dart';

class SubjectNameByIdController extends GetxController{
  var teacherName = ''.obs;
  var subjectName = ''.obs;
  var subjectColor = ''.obs;
  var icon = ''.obs;

  fetchSubjectNameById({required int subjectId}) async {
    try {
      SubjectByIdRequest  request = SubjectByIdRequest (subjectId: subjectId);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.LOAD_SUBJECT_NAME_BYID,
        body:request.toJson(),
      ).post();
      if (response != null && response.body != null) {
        SubjectByIdResponse subjectByIdResponse =
        SubjectByIdResponse.fromRawJson(utf8.decode(response.body!));
        if (response.statusCode == 200) {
          subjectName.value= subjectByIdResponse.subjectTitleAr;
          teacherName.value=subjectByIdResponse.tFullName;
         subjectColor.value=subjectByIdResponse.subjectColor;
         icon.value=subjectByIdResponse.subjectIconHref;
        }
      }
    } catch (_) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }

}