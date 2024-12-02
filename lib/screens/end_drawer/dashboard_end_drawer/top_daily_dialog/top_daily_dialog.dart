import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_controller.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';

class DailyLoginDialog extends StatelessWidget {
   DailyLoginDialog({super.key});

  final CheckUserController controllerCheckUser =
      Get.put(CheckUserController());

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final double dialogHeight = isLandscape
        ? (MediaQuery.of(context).size.height)* 0.60
        : MediaQuery.of(context).size.height * 0.30;
    final double dialogWidth = isLandscape
        ? (MediaQuery.of(Get.context!).size.width)* 0.50
        : MediaQuery.of(Get.context!).size.width;
    return SizedBox(
      width:dialogWidth,
      height: dialogHeight,
      child: Column(
        children: [
          SizedBox(height: 1.h),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Align(
              alignment: Alignment.topRight,
              child: CommonViews().customText(
                textContent: 'التفاعل اليومي',
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.right,
                textColor: Theme.of(context).textTheme.displayLarge!.color,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Divider(
            color: Theme.of(context).textTheme.bodySmall!.color,
            thickness: 1,
          ),
          SizedBox(height: 1.h),
          _dailyLoginView(context),
        ],
      ),
    );
  }

  Widget _dailyLoginView(context) {
    return Obx(() {
      if (controllerCheckUser.isLoading) {
        return _getLoadingView();
      } else if (controllerCheckUser.isSuccess) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: controllerCheckUser.streakImage.value,
                width: 70.w,
                height: 6.h,
                fit: BoxFit.fill,
                placeholder: (context, url) => _getLoadingView(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              SizedBox(height: 1.h),
              CommonViews().customText(
                  textContent: ' ${controllerCheckUser.numberOfLoginStreak} يوم ',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  withFontFamily: false,
                  textColor: Theme.of(context).textTheme.displayLarge!.color,),
              CommonViews().customText(
                  textContent: 'تفاعل',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.grey),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonViews().customText(
                  textContent: '${controllerCheckUser.streakText}',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.grey,),
              ),
            ],
          ),
        );
      }
      return const SizedBox();
    });
  }

  Widget _getLoadingView() {
    return const Center(
      child: SpinKitCircle(
        color: AppColors.backGroundColor,
        size: 50.0,
      ),
    );
  }
}
