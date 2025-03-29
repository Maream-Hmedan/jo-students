// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import 'notification_controller.dart';


class TopNotificationDialog extends StatelessWidget {
  TopNotificationDialog({super.key});

  final DateFormat formatter = DateFormat('HH:mm:ss dd/MM/yyyy');
  final NotificationController notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Determine height based on the number of notifications
      double notificationHeight = 7.h; // Height per notification
      double minHeight = 20.h; // Minimum height when there are no notifications
      double maxHeight = 40.h; // Optional: Maximum height to prevent too tall dialogs
      if (notificationController.isLoading) {
        return SizedBox(
          height: minHeight,
          child: _getLoadingView(),
        );
      }

      if (notificationController.isError || notificationController.isEmpty) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 35.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xff7367f0).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CommonViews().customText(
                        textContent: '0 New',
                        withFontFamily: false,
                        fontSize: 13.sp,
                        textColor: const Color(0xff7367f0),
                      ),
                    ),
                    CommonViews().customText(
                      textContent: 'الاشعارات',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      textColor: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).textTheme.bodySmall!.color,
                thickness: 1,
              ),
              _buildContentForErrorOrEmptyStates(context: context),
            ],
          ),
        );
      }

      if (notificationController.isSuccess) {
        // Calculate height based on the number of notifications
        double contentHeight =
        (notificationController.notification.length * notificationHeight)
            .clamp(minHeight, maxHeight);
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: contentHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xff7367f0).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CommonViews().customText(
                        textContent: '${notificationController.notification.length}',
                        withFontFamily: false,
                        fontSize: 13.sp,
                        textColor: const Color(0xff7367f0),
                      ),
                    ),
                    CommonViews().customText(
                      textContent: 'الاشعارات',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      textColor: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).textTheme.bodySmall!.color,
                thickness: 1,
              ),
              Expanded(
                child: Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: notificationController.notification.length,
                    itemBuilder: (context, index) {
                      final item = notificationController.notification[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              SizedBox(width: 2.w),
                              SizedBox(
                                width: 10.w,
                                height: 5.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: CachedNetworkImage(
                                    imageUrl: "https://jo-students.com${item.notiIcon}",
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 1.h),
                                    CommonViews().customText(
                                      textContent: item.notificationText,
                                      overflow: TextOverflow.visible,
                                      maxLines: 3,
                                      textAlign: TextAlign.right,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      textColor: Theme.of(context).textTheme.bodyLarge!.color,
                                    ),
                                    SizedBox(height: 1.h),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: CommonViews().customText(
                                        textContent: formatter.format(
                                          DateTime.fromMillisecondsSinceEpoch(int.parse(item.notiDt)),
                                        ),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp,
                                        withFontFamily: false,
                                        textColor: Theme.of(context).textTheme.bodyMedium!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 2.w),
                            ],
                          ),
                          (index != notificationController.notification.length - 1)
                              ? Divider(
                            color: Theme.of(context).textTheme.bodySmall!.color,
                            thickness: 1,
                          )
                              : SizedBox(height: 1.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return Container();
    });
  }


  Widget _buildContentForErrorOrEmptyStates({required context}) {
    return ListTile(
      title: Center(
        child: Column(
          children: [
            Image.asset(
              notificationsImage,
              width: 70.w,
              height: 20.h,
            ),
            CommonViews().customText(
              textContent: 'لا توجد إشعارات حتى الآن',
              fontSize: 14.sp,
              textColor: Theme.of(context).textTheme.bodyMedium!.color,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
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





