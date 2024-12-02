// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/screens/end_drawer/helper_end_drawer/helper_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/help_app_bar.dart';
import 'package:sizer/sizer.dart';

import 'help_footer.dart';
import 'main_sections.dart';

class Services extends StatelessWidget {
  final String title;
  Widget? body;

  final controller = Get.find<MainSectionsController>();

  Services({
    super.key,
    required this.title,
    this.body,
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
                            textContent: "  \\       الخدمات ",
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

                      body != null
                          ? body!
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                CommonViews().customText(
                                  textContent: 'قريباً',
                                  fontSize: 11.sp,
                                  textAlign: TextAlign.justify,
                                  textColor: const Color(0xff444050),
                                ),
                              ],
                            ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 6.h,
                        width: 100.w,
                        decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
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
                          children:
                          controller.filterServices2.map((item) {
                            return GestureDetector(
                              onTap: () {
                                controller.selectedServices.value = item;
                                controller.updateFilteredServices();
                                Widget? bodyContent;
                                if (item == "خاصية سؤال وجواب") {
                                  bodyContent =
                                      Column(
                                        children: [
                                          SizedBox(height: 3.h),
                                          CommonViews().customText(
                                            textContent:
                                            'خاصية سؤال وجواب (Q&A) تتيح لك كتابة أي سؤال يواجهك في '
                                                'المنهاج، ويمكنك أيضًا إضافة لقطة شاشة للسؤال',
                                            fontSize: 11.sp,
                                            textAlign: TextAlign.justify,
                                            textColor: const Color(0xff444050),
                                          ),
                                          SizedBox(height: 1.h),
                                          CommonViews().customText(
                                            textContent:
                                            'وسيتم الإجابة على جميع أسئلتك من قِبل معلمين متخصصين.',
                                            fontSize: 11.sp,
                                            textAlign: TextAlign.justify,
                                            textColor: const Color(0xff444050),
                                          ),
                                          SizedBox(height: 1.h),
                                          CommonViews().customText(
                                            textContent:
                                            'يمكنك الوصول إلى خانة سؤال وجواب من خلال اتباع الخطوات التالية 🔽  ',
                                            fontSize: 11.sp,
                                            textAlign: TextAlign.justify,
                                            textColor: const Color(0xff444050),
                                          ),
                                          SizedBox(height: 1.h),
                                          CommonViews().customText(
                                            textContent:
                                            '▪إذا كنت تستخدم التطبيق: ستجدها متوفرة في الجزء السفلي من الصفحة الرئيسية',
                                            fontSize: 11.sp,
                                            textAlign: TextAlign.justify,
                                            textColor: const Color(0xff444050),
                                          ),
                                          SizedBox(height: 1.h),
                                          CommonViews().customText(
                                            textContent:"▪إذا كنت تستخدم الموقع: يمكنك الوصول إليها عن طريق الضغط"
                                                " على الخطوط الثلاث المتواجدة في أعلى يمين الصفحة الرئيسية،"
                                                " حيث ستجد الخاصية ضمن الخيارات المتاحة في القائمة",
                                            fontSize: 11.sp,
                                            textAlign: TextAlign.justify,
                                            textColor: const Color(0xff444050),
                                          ),
                                        ],
                                      );
                                } else if (item == "بنك الأسئلة") {
                                  bodyContent =   Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 3.h),
                                      CommonViews().customText(
                                        textContent:
                                        'بنك الأسئلة يحتوي على آلاف الأسئلة المتنوعة والتدريبات',
                                        fontSize: 11.sp,
                                        textAlign: TextAlign.justify,
                                        textColor: const Color(0xff444050),
                                      ),
                                      SizedBox(height: 1.h),
                                      CommonViews().customText(
                                        textContent:" بالإضافة إلى الأسئلة المتوقعة والوزارية حسب كل مرحلة دراسية، "
                                            "مما يساعد الطلاب في تنمية مهاراتهم واستعدادهم للامتحانات.",
                                        fontSize: 11.sp,
                                        textAlign: TextAlign.justify,
                                        textColor: const Color(0xff444050),
                                      ),
                                    ],);

                                } else {
                                  bodyContent = null;
                                }


                                AppNavigator.of(context).pushReplacement(
                                  Services(
                                    title: item,
                                    body: bodyContent,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
