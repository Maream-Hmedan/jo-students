import 'package:flutter/material.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Center(
       child: SizedBox(
          width: 65.w,
          height: 7.h,
          child: Image.asset(appLogo),
        ),
      ),
      centerTitle: true,
      toolbarHeight: 10.h,
      backgroundColor:AppColors.backGroundColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(5.h),
        child: Container(
          color:  AppColors.backGroundColor,
          height: 5.h,
        ),
      ),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(10.h + 5.h);
}
