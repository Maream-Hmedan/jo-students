import 'package:flutter/material.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/help_app_bar.dart';
import 'package:sizer/sizer.dart';

import 'help_footer.dart';
import 'helper_screen.dart';

class ReadMore extends StatelessWidget {
  final String title;
  final Widget itemBody;
  final String helpCenter;
  final String? additionalData;

  const ReadMore({
    super.key,
    required this.title,
    required this.helpCenter,
    required this.itemBody,
    this.additionalData,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const HelpAppBar(),
        body: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CommonViews().customClickableText(
                            onTap: (){
                              AppNavigator.of(context).push(const HelperScreen());
                            },
                              textContent: "مركز المساعدة   ",
                              fontSize: 12.sp,
                              textColor: const Color(0xff7367f0)),
                          CommonViews().customText(
                              textContent: "  \\     $helpCenter ",
                              fontSize: 12.sp,
                              textColor:const Color(0xff444050),),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      additionalData != null?
                        Row(
                          children: [
                            CommonViews().customText(
                              textContent: additionalData!,
                              fontSize: 15.sp,
                              textColor: const Color(0xff444050),
                              fontWeight: FontWeight.w500,
                            ),
                            CommonViews().customText(
                              textContent: title,
                              fontSize: 15.sp,
                              textColor: const Color(0xff444050),
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ):
                      CommonViews().customText(
                        textContent: title,
                        fontSize: 18.sp,
                        textColor: const Color(0xff444050),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CommonViews().customText(
                        textContent: " 08/21/2024",
                        withFontFamily: false,
                        fontSize: 12.sp,
                        textColor:const Color(0xff444050),),
                      SizedBox(
                        height: 2.h,
                      ),
                      const Divider(
                        color: Color(0xffe6e6e8),
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      itemBody,
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                HelpFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
