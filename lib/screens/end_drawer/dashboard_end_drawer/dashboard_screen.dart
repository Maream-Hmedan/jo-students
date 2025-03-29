// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_controller.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/curriculums/curriculums_controller.dart';
import 'package:jo_students/screens/curriculums/curriculums_view.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/lessons_screen.dart';
import 'package:jo_students/screens/end_drawer/live_class_end_drawer/live_class_screen.dart';
import 'package:jo_students/screens/end_drawer/question_answer_end_drawer/question_answer_screen.dart';
import 'package:jo_students/screens/end_drawer/subscription_end_drawer/subscription_card_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {
  final CurriculumsController curriculumsController=Get.put(CurriculumsController());
  final CheckUserController checkUserController=Get.put(CheckUserController());


  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]) ;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        endDrawer: const EndDrawerView(),
        appBar: CustomProfileAppBar(),
        body: SingleChildScrollView(
          child: Container(
            width: 100.w,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                beReadyWidget(),
                SizedBox(
                  height: 1.h,
                ),
                liveClassesWidget(),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 100.w,
                  height: 35.h,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      CommonViews().customText(
                          textContent: 'مراجعات',
                          fontSize: 18.sp,
                          textColor:
                              Theme.of(context).textTheme.bodyLarge!.color,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 1.h,
                      ),
                      CommonViews().customText(
                          textContent:
                              'كن مستعداً للاختبارات مع أقوى المراجعات والامتحانات',
                          fontSize: 11.sp,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.right,
                          textColor:
                              Theme.of(context).textTheme.bodyMedium!.color,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        height: 2.h,
                      ),
                      reviewsWidget(),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                questionAnswerWidget(),
                SizedBox(
                  height: 2.h,
                ),
                CurriculumsView(),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveSelectedItem(int index) async {
    General.savePrefInt(ConstantValues.selectedIndexKey, index);
  }
  Container reviewsWidget() {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(0),
        ),
        border: Border.all(
            color:
                Theme.of(context).textTheme.bodySmall!.color ?? Colors.black),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          buildListItem(
            title: 'الإمتحانات',
            image: examIcon, onTap: () {
              AppNavigator.of(context).push( LessonsCard(selectedIndexOut: 0.obs,));
              _saveSelectedItem(1);
          },
          ),
          SizedBox(
            height: 1.h,
          ),
          Divider(
            color: Theme.of(context).textTheme.bodySmall!.color,
            thickness: 1,
          ),
          SizedBox(
            height: 1.h,
          ),
          buildListItem(
            image: bulbLightImage,
            title: 'اوراق العمل', onTap: () {
            AppNavigator.of(context).push( LessonsCard(selectedIndexOut: 1.obs,));
            _saveSelectedItem(1);
          },
          ),
          SizedBox(
            height: 1.h,
          ),
        ],
      ),
    );
  }

  Container liveClassesWidget() {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: SizedBox(
        height: 21.h,
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CommonViews().customText(
                        textContent: 'حصص مباشرة ',
                        fontSize: 18.sp,
                        textColor: Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    CommonViews().customText(
                      textContent: 'مع أفضل المعلمين بإنتظارك  ',
                      fontSize: 12.sp,
                      textColor: Theme.of(context).textTheme.bodyMedium!.color,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 1.h),
                    TextButton(
                      onPressed: () {
                        AppNavigator.of(context)
                            .push( LiveClassScreen());
                        _saveSelectedItem(3);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xff7367f0),
                            width: 1,
                          ),
                        ), // Padding
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all<Color>(
                            const Color(0xff7367f0)
                                .withOpacity(0.2)), // Splash color
                      ),
                      child: Center(
                        child: CommonViews().customText(
                            textColor: const Color(0xff7367f0),
                            textContent: 'عرض جدول الحصص',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                top: 15,
                child: Image.asset(
                  liveClassesImage,
                  width: 20.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container questionAnswerWidget() {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: SizedBox(
        height: 21.h,
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    CommonViews().customText(
                      textContent: 'هل لديك سؤال بمادة معينة',
                      fontSize: 16.sp,
                      textColor: Theme.of(context).textTheme.bodyLarge!.color,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 1.h),
                    CommonViews().customText(
                      textContent: 'اسئل معلمين جو ستيودنتس',
                      fontSize: 12.sp,
                      textColor: Theme.of(context).textTheme.bodyMedium!.color,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 1.h),
                    TextButton(
                      onPressed: () {
                        AppNavigator.of(context)
                            .push(const QuestionAnswerScreen());
                        _saveSelectedItem(2);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xff7367f0),
                            width: 1,
                          ),
                        ), // Padding
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all<Color>(
                            const Color(0xff7367f0)
                                .withOpacity(0.2)), // Splash color
                      ),
                      child: Center(
                        child: CommonViews().customText(
                            textColor: const Color(0xff7367f0),
                            textContent: 'اسأل',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,)
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                top: 15,
                child: Image.asset(
                  "assets/images/QA-colored.png",
                  width: 20.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget beReadyWidget() {
    return Obx(() {
      return checkUserController.isSubscription.value == 0
          ? Container(
        width: 100.w,
        height: 25.h,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(dashBoardBackGround),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  CommonViews().customText(
                    textContent: '!كُن مستعد للتفوق في دراستك',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(height: 2.h),
                  Align(
                    alignment: Alignment.topRight,
                    child: CommonViews().customText(
                      textContent:
                      'تعلم وارفع معدّلك من خلال فيديوهات تشرح موادك',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CommonViews().customText(
                    textContent: 'الدراسية واختبارات قوية مع أفضل المعلمين',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 2.h),
                  CommonViews().customClickableContainer(
                    radius: 5.0,
                    color: const Color(0xFFF4B826),
                    width: 30.w,
                    child: Center(
                      child: CommonViews().customText(
                        textContent: 'شراء اشتراك',
                        textColor: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                    onTap: () {
                      General.savePrefInt(
                          ConstantValues.selectedIndexKey, 8);
                      AppNavigator.of(context)
                          .push(SubscriptionCard());
                    },
                  )
                ],
              ),
            ),
            Positioned(
              left: 7,
              top: 10,
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  dashBoardImage,
                  width: 35.w,
                ),
              ),
            ),
          ],
        ),
      )
          : Container(
        width: 100.w,
        height: 18.h,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(dashBoardBackGround),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  CommonViews().customText(
                    textContent: '!كُن مستعد للتفوق في دراستك',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(height: 2.h),
                  Align(
                    alignment: Alignment.topRight,
                    child: CommonViews().customText(
                      textContent:
                      'تعلم وارفع معدّلك من خلال فيديوهات تشرح موادك',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CommonViews().customText(
                    textContent: 'الدراسية واختبارات قوية مع أفضل المعلمين',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
            Positioned(
              left: 7,
              top: 10,
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  dashBoardImage,
                  width: 35.w,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }


  Widget buildListItem({required String title, required image,required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonViews().customText(
              textContent: title,
              fontSize: 13.sp,
              fontWeight: FontWeight.normal,
              textColor: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            SizedBox(
              width: 3.w,
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(image),
              radius: 18,
            ),
            SizedBox(
              width: 4.w,
            ),
          ],
        ),
      ),
    );
  }
}
