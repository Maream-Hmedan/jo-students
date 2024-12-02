import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_controller.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/curriculums/curriculums_controller.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_classes_dialog/class_name/class_name_controller.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_notification_dialog/notification_controller.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_profile_dialog/user_profile_screen.dart';
import 'package:jo_students/screens/end_drawer/helper_end_drawer/helper_screen.dart';
import 'package:jo_students/screens/end_drawer/live_class_end_drawer/live_class_controller.dart';
import 'package:jo_students/screens/end_drawer/live_class_end_drawer/live_class_screen.dart';
import 'package:jo_students/screens/end_drawer/question_answer_end_drawer/add_questions/add_question_controller.dart';
import 'package:jo_students/screens/end_drawer/question_answer_end_drawer/my_question/my_question_controller.dart';
import 'package:jo_students/screens/end_drawer/reviews_end_drawer/my_reviews_list/my_reviews_controller.dart';
import 'package:jo_students/screens/end_drawer/settings_end_drawer/settings_screen.dart';
import 'package:jo_students/screens/end_drawer/subscription_end_drawer/subscription_screen.dart';
import 'package:jo_students/screens/end_drawer/subscription_end_drawer/subscription_table/subscription_controller.dart';
import 'package:jo_students/screens/login/login_screen.dart';
import 'package:jo_students/screens/theme/theme_controller.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';

class TopProfileDialog extends StatefulWidget {
  const TopProfileDialog({super.key});

  @override
  State<TopProfileDialog> createState() => _TopProfileDialogState();
}

class _TopProfileDialogState extends State<TopProfileDialog> {
  final ThemeToggleController controller = Get.find<ThemeToggleController>();

  Future<String> _fetchUserName() async {
    return await General.getPrefString(ConstantValues.NAME, "");
  }



  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final double dialogHeight = isLandscape
        ? (MediaQuery.of(context).size.height)
        : MediaQuery.of(context).size.height * 0.47;
    final double dialogWidth = isLandscape
        ? (MediaQuery.of(context).size.width)*0.55
        : MediaQuery.of(context).size.width;
    return SizedBox(
      height: dialogHeight,
      width: dialogWidth,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 6.h,
                    width: 30.w,
                    child: FutureBuilder<String>(
                      future: _fetchUserName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CommonViews().customText(
                                textContent: 'مرحبا بك',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color ??
                                    Colors.black,
                              ),
                              CommonViews().customText(
                                textContent: snapshot.data!,
                                fontSize: 11.sp,
                                withFontFamily: false,
                                fontWeight: FontWeight.w500,
                                textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color ??
                                    Colors.black,
                              ),
                            ],
                          );
                        } else {
                          return const Text('No Data');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        width: 10.w,
                        height: 5.h,
                      ),
                      const Center(
                        child: CircleAvatar(
                          radius: 22,
                          backgroundImage: AssetImage(
                              avatarImage,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 3,
                        bottom: 1,
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
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                      AppNavigator.of(context)
                          .pushReplacement(const UserProfileScreen());
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CommonViews().customText(
                          textContent: 'البروفايل',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w300,
                          textColor: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Icon(
                          Icons.person_outline,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                      AppNavigator.of(context).push(const SettingsScreen());
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CommonViews().customText(
                          textContent: 'اعدادات',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w300,
                          textColor: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Icon(
                          Icons.settings,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonViews().customClickableText(
                        textContent: 'اشتراكي',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                        textColor: Theme.of(context).textTheme.bodyLarge!.color,
                        onTap: () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown,
                          ]);
                          AppNavigator.of(context).push(const SubscriptionScreen());
                        },
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Icon(
                        Icons.attach_money,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: 1.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonViews().customClickableText(
                  textContent: 'مساعدة',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w300,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  onTap: () {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                    ]);
                    AppNavigator.of(context).push(const HelperScreen());
                  },
                ),
                SizedBox(
                  width: 3.w,
                ),
                Icon(
                  Icons.help_outline,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  size: 25,
                ),
                SizedBox(
                  width: 3.w,
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(() => GestureDetector(
                  onTap: () {
                    controller.toggleTheme();
                 AppNavigator.of(context).pop();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonViews().customText(
                        textContent: controller.isNightMode.value
                            ? "الوضع النهاري"
                            : "الوضع الليلي",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                        textColor: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Icon(
                        controller.isNightMode.value
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        size: 25,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 3.h,
            ),
            CommonViews().customClickableContainer(
              margin: const EdgeInsets.symmetric(horizontal: 16),
                onTap: () {
                  Get.delete<ClassNameController>();
                  Get.delete<CurriculumsController>();
                  Get.delete<CheckUserController>();
                  Get.delete<LiveClassController>();
                  Get.delete<AddQuestionController>();
                  Get.delete<MyQuestionController>();
                  Get.delete<SubscriptionController>();
                  Get.delete<NotificationController>();
                  Get.delete<MyReviewsController>();
                  Get.delete<SearchLiveController>();
                  Get.delete<SearchSubController>();
                  General.remove(ConstantValues.ID);
                  General.remove(ConstantValues.MSG);
                  General.remove(ConstantValues.showSubscriptionButton);
                  General.remove(ConstantValues.NAME);
                  General.remove(ConstantValues.EMAIL);
                  General.remove(ConstantValues.PHONE);
                  General.savePrefInt(ConstantValues.selectedIndexKey, 0);
                  AppNavigator.of(context).pushAndRemoveUntil(const LoginScreen());
                },
                color: const Color(0xffff4c51),
                colorBorder: Colors.transparent,
                width: 100.h,
                radius: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8.0),
                    CommonViews().customText(
                      textContent: 'تسجيل الخروج',
                      fontSize: 12.sp,
                    )
                  ],
                )),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}
