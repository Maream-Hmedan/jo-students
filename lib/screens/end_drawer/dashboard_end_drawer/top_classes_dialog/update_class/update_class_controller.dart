import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_controller.dart';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/curriculums/curriculums_controller.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/dashboard_screen.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_classes_dialog/class_name/class_name_controller.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_classes_dialog/update_class/update_class_response.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_notification_dialog/notification_controller.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/lessons_controller/lessons_controller.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/specific_subject/specific_lessons_card/specific_lessons_card_controller.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/specific_subject/specific_subject_book/specific_books_controller.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/specific_subject/specific_subject_test/specific_test_controller.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/specific_subject/specific_subject_video/specific_video_controller.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/specific_subject/specific_subject_workbooks/specific_workbooks_controller.dart';
import 'package:jo_students/screens/end_drawer/live_class_end_drawer/live_class_controller.dart';
import 'package:jo_students/screens/end_drawer/question_answer_end_drawer/add_questions/add_question_controller.dart';
import 'package:jo_students/screens/end_drawer/question_answer_end_drawer/my_question/my_question_controller.dart';
import 'package:jo_students/screens/end_drawer/subscription_end_drawer/subscription_table/subscription_controller.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:oktoast/oktoast.dart';

import 'update_class_request.dart';


class UpdateClassController extends GetxController {
  final CurriculumsController curriculumsController =
      Get.put(CurriculumsController());
  ClassNameController classNameController = Get.put(ClassNameController());

  final LiveClassController liveClassController =
  Get.put(LiveClassController());

  final CheckUserController checkUserController =
      Get.put(CheckUserController());

  updateClass({required int classID, required int userid}) async {
    try {
      UpdateClassRequest request =
          UpdateClassRequest(classid: classID, userid: userid);
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.CLASSES_UPDATE_URL,
        body: request.toJson(),
      ).post();

      if (response?.statusCode == 200 && response?.body != null) {
        UpdateClassResponse updateClassResponse =
            UpdateClassResponse.fromRawJson(utf8.decode(response!.body!));
        if (updateClassResponse.status == 1) {
          Get.delete<ClassNameController>();
          Get.delete<CurriculumsController>();
          Get.delete<LiveClassController>();
          Get.delete<AddQuestionController>();
          Get.delete<MyQuestionController>();
          Get.delete<SpecificCardDetailsController>();
          Get.delete<BooksBySubjectIdController>();
          Get.delete<SubscriptionController>();
          Get.delete<SubjectNameByIdController>();
          Get.delete<BooksTestController>();
          Get.delete<BooksVideoController>();
          Get.delete<WorkBooksController>();
          Get.delete<NotificationController>();
          General.savePrefInt(ConstantValues.selectedIndexKey, 0);
          await checkUserController.checkUser();
          bool userChecked = await checkUserController.checkUser();
          if (userChecked) {
            AppNavigator.of(Get.context!)
                .pushAndRemoveUntil(const DashboardScreen());
          }
        }
      }
    } catch (_) {
      showToast("No internet connection",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }
}
