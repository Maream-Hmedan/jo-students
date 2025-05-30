// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/dashboard_screen.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';

class BestStudentScreen extends StatelessWidget {
  const BestStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const EndDrawerView(),
        appBar:  CustomProfileAppBar(),
        body: SizedBox(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: 100.w,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(10),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.h),
                    CommonViews().customText(
                        textContent: "افضل 10 طلاب",
                        fontSize: 16.sp,
                        textColor: Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.bold),
                    SizedBox(height: 1.h),
                    Image.asset(
                      bestStudentImage,
                      width: 60.w,
                      height: 30.h,
                    ),
                    SizedBox(height: 2.h),
                    CommonViews().customText(
                        textContent: '!انتظرونا قريباً ',
                        fontSize: 16.sp,
                        textColor:Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.bold),
                    SizedBox(height: 2.h),
                    CommonViews().customText(
                        textContent: 'هذا القسم غير متاح حالياً',
                        fontSize: 13.sp,
                        textColor: Theme.of(context).textTheme.bodyMedium!.color,
                        fontWeight: FontWeight.w500),
                    SizedBox(height: 2.h),
                    CommonViews().customClickableContainer(
                      onTap: () {
                        General.savePrefInt(ConstantValues.selectedIndexKey, 0);
                        AppNavigator.of(context)
                            .pushAndRemoveUntil(const DashboardScreen());
                      },
                      radius: 5,
                      width: 40.w,
                      color: const Color(0xff7367f0),
                      colorBorder: const Color(0xff7367f0),
                      child: Center(
                        child: CommonViews().customText(
                            textContent: 'الرجوع للرئيسية',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
