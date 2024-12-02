import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/help_app_bar.dart';
import 'package:sizer/sizer.dart';

import 'help_footer.dart';
import 'helper_screen.dart';
import 'main_sections.dart';

class CommunicationHelper extends StatelessWidget {
  final String title;


  final controller = Get.find<MainSectionsController>();

  CommunicationHelper({super.key,
    required this.title,
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
                            textContent: "  \\       تواصل معنا  ",
                            fontSize: 12.sp,
                            textColor: const Color(0xff444050),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
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
                        textColor: const Color(0xff444050),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const Divider(
                        color: Color(0xffe6e6e8),
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CommonViews().customText(
                            textContent: 'قريباً',
                            fontSize: 11.sp,
                            textAlign: TextAlign.justify,
                            textColor: const Color(0xff444050),
                          ),
                          SizedBox(height: 1.h),
                          Container(
                            height: 6.h,
                            width: 100.w,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Color(0xffF3F2F3),
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: CommonViews().customText(
                                textContent: "  المواضيع اخرى  ",
                                fontSize: 13.sp,
                                textColor: const Color(0xff444050),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Obx(() {
                            return Column(
                              children:controller.filterCommunication2.map((item) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectedCommunication.value = item;
                                    controller.updateFilteredCommunication();
                                    AppNavigator.of(context).pushReplacement(CommunicationHelper(
                                      title: item,
                                    ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonViews().customText(
                                          textContent: item,
                                          fontSize: 13.sp,
                                          textColor:
                                          const Color(0xff595664),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 17,
                                          color: Color(0xffb1afb6),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                        ],
                      ),
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
