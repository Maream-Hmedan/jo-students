import 'package:flutter/material.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/dashboard_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';

class HelpAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HelpAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: 100.w,
        height:10.h,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10),),
        border: Border.all(color: Colors.white,width: 2),
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 2.w,),
            Image.asset(logoIcon,height: 5.h,width: 20.w,),
            CommonViews().customText(
                textContent: "اكاديمية طلاب الاردن",
                textColor: AppColors.backGroundColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700),
            SizedBox(width: 1.w,),
            CommonViews().customClickableContainer(
                color: const Color(0xff7367f0),
                margin: const EdgeInsets.all(8),
                width: 12.w,
                height: 5.h,
                onTap: () {
                  General.savePrefInt(ConstantValues.selectedIndexKey, 0);
                  AppNavigator.of(context)
                      .pushAndRemoveUntil(const DashboardScreen());
                },
                colorBorder: const Color(0xff7367f0),
                radius: 5,
                child: const Center(
                  child: Icon(
                    Icons.logout,
                    size: 22,
                    color: Colors.white,
                  ),
                )),
            SizedBox(width: 2.w,),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(10.h + 5.h);
}
