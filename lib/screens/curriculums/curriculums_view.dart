// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/curriculums/curriculums_controller.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/specific_subject/specific_subject_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CurriculumsView extends StatelessWidget {
   CurriculumsView({super.key});

   final CurriculumsController controller = Get.find<CurriculumsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 1.h),
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: CommonViews().customText(
              textContent: 'مواد المنهاج',
              fontWeight: FontWeight.w600,
              textColor: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: CommonViews().customText(
              textContent: 'تصفح جميع مواد منهاج صفك',
              fontWeight: FontWeight.w600,
              textColor: Theme.of(context).textTheme. displayLarge!.color,
              fontSize: 12.sp,
            ),
          ),
          _curriculumsView(),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }

  Widget _curriculumsView() {
    return Obx(() {
      if (controller.isLoading) {
        return _getShimmerView();
      }
      if (controller.isError) {
        return Center(
          child:
          CommonViews().customText(
            textContent: "An Error Occurred While Fetching Subject",
            withFontFamily: false,
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 13.sp,
          ),
        );
      }
      if (controller.isEmpty) {
        return Center(
          child:
          CommonViews().customText(
            textContent: "!! لا يوجد مواد ليتم عرضها",
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 15.sp,
          ),
        );
      }
      if (controller.isSuccess) {
        return Column(
          children: controller.curriculums.map((item) {
            return GestureDetector(
              onTap: () {
                AppNavigator.of(Get.context!).push(SpecificSubjectScreen(
                  subjectID: item.subjectId,
                ));
                _saveSelectedItem(1);
              },
              child: Container(
                width:  MediaQuery.of(Get.context!).size.width,
                height: 10.h,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: parseColor(item.subjectColor),
                  // Use the parseColor function
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.subjectIconHref,
                      color: Colors.black,
                      width: 15.w,
                      height: 4.h,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    SizedBox(height: 1.h),
                    CommonViews().customText(
                      textContent: item.subjectTitleAr,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }
      return Container();
    });
  }
   Future<void> _saveSelectedItem(int index) async {
     General.savePrefInt(ConstantValues.selectedIndexKey, index);
   }
  Color parseColor(String colorString) {
    colorString = colorString.replaceFirst('#', "0xff");
    return Color(int.parse(colorString));
  }


  Widget _getShimmerView() {
    return SizedBox(
      width: double.infinity,
      height: 13.h*4,
      child: Column(
        children: List.generate(4, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300] ?? Colors.grey,
            highlightColor: Colors.grey[100] ?? Colors.white,
            child: Container(
              width: double.infinity,
              height: 10.h,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }),
      ),
    );
  }
}
