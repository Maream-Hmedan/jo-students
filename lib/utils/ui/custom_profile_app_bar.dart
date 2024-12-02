// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_controller.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_classes_dialog/class_name/class_name_controller.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_classes_dialog/top_classes_dialog.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_daily_dialog/top_daily_dialog.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_notification_dialog/notification_controller.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_notification_dialog/top_notification_dialog.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_profile_dialog/top_profile_dialog.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';

class CustomProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  CustomProfileAppBar({super.key}) {
    checkUserController.checkUser();
  }

  ClassNameController controller = Get.put(ClassNameController());
  final CheckUserController checkUserController=Get.find<CheckUserController>();
  final NotificationController notificationController =
  Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
      height: 7.h,
      width: 100.w,
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 10.0,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leadingWidth: 75.w,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 3.w),
            Stack(
              children: [
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    topDialogProfile(context, child: const TopProfileDialog());
                  },
                  child: const Center(
                    child: CircleAvatar(
                      radius: 21,
                      backgroundImage: AssetImage(avatarImage),
                    ),
                  ),
                ),
                Positioned(
                  right: 3,
                  bottom: 6,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white)),
                    constraints: const BoxConstraints(
                      minWidth: 9,
                      minHeight: 9,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                SizedBox(width: 10.w),
                Center(
                  child: IconButton(
                    onPressed: () {
                      topDialog(context, child:  TopNotificationDialog());
                    },
                    icon: Icon(
                      Icons.notifications_outlined,
                      size: 33,
                      color: Theme.of(context).textTheme.bodyLarge!.color ??
                          Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 17,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white)),
                    constraints: const BoxConstraints(
                      minWidth: 9,
                      minHeight: 9,
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return CommonViews().customText(
                        textContent: controller.className.value,
                        textColor:Theme.of(context).textTheme.bodyLarge!.color ??
                        Colors.black,
                        fontSize: 10.sp,
                        overflow: TextOverflow.ellipsis);
                  }),
                  Center(
                    child: InkWell(
                      onTap: () {
                        topDialogClass(context, child: TopClassesDialog());
                      },
                      child: Image.asset(
                        classesImage,
                        width: 11.w,
                        color:Theme.of(context).textTheme.bodyLarge!.color ??
                          Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                topDialog(context, child:  DailyLoginDialog());
              },
              child:
              Obx(() {
                return Center(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor:Colors.transparent ,
                    child: CachedNetworkImage(
                      imageUrl: checkUserController.streakOuterImage.value,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),


      ),
    );
  }



  void topDialog(BuildContext context, {required Widget child}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return OrientationBuilder(
              builder: (context, orientation) {
                final screenHeight = MediaQuery.of(context).size.height;
                final isPortrait = orientation == Orientation.portrait;
                return Transform.translate(
                  offset: Offset(0, isPortrait ? -screenHeight * 0.2 : -screenHeight * 0.01),
                  child: Dialog(
                    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    insetPadding: EdgeInsets.symmetric(horizontal: 3.w), // Adjust padding
                    child: SingleChildScrollView(
                      child: child,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }


  void topDialogProfile(BuildContext context, {required Widget child}) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Transform.translate(
          offset:Offset(0, isPortrait ? -screenHeight * 0.1 : -screenHeight*0.001),
          child: Dialog(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            insetPadding: EdgeInsets.only(
              left: 3.w,  // Padding on the left side
              right: 3.w, // Padding on the right side
            ),
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        );
      },
    );
  }

  void topDialogClass(BuildContext context, {required Widget child}) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Transform.translate(
          offset:Offset(0, isPortrait ? -screenHeight * 0.01 : -screenHeight*0.001),
          child: Dialog(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            insetPadding: EdgeInsets.only(
              left: 3.w,  // Padding on the left side
              right: 3.w, // Padding on the right side
            ),
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(10.h + 5.h);
}
