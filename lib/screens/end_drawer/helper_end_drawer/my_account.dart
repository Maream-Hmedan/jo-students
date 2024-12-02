// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/screens/login/login_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/help_app_bar.dart';
import 'package:sizer/sizer.dart';

import 'help_footer.dart';
import 'helper_screen.dart';
import 'main_sections.dart';

class MyAccount extends StatelessWidget {
  final String title;
  Widget? body;

  final controller = Get.find<MainSectionsController>();
  final List<String> itemsEmail = [
    'ادخل عنوان بريدك الإلكتروني الذي تم إنشاؤه لأول مرة',
    'أدخل كلمة المرور الخاصة بك في الخانة المناسبة \nمباشرة، وتأكد من أنها باللغة الإنجليزية',
    'بعد ذلك، اضغط على زر متابعة للوصول إلى حسابك',
  ];

  final List<String> itemsPhone = [
    'ادخل رقم الهاتف الذي تم تفعيل الاشتراك عليه\n لأول مرة',
    'أدخل كلمة المرور الخاصة بك في الخانة المناسبة \nمباشرة، وتأكد من أنها باللغة الإنجليزية',
    'بعد ذلك، اضغط على زر متابعة للوصول إلى حسابك',
  ];

  MyAccount({super.key,
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
                            textContent: "  \\        إدارة حسابي ",
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
                              children:controller.filterMyAccount2.map((item) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectedMyAccount.value = item;
                                    controller.updateFilteredMyAccount();
                                    Widget? bodyContent;
                                    if (item == "طريقة الدخول الى حسابك عبر البريد الإلكتروني")
                                    {
                                      bodyContent =
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CommonViews().customText(
                                                        textContent:
                                                        "ادخل عن طريق الرابط التالي: ",
                                                        fontSize: 13.sp,
                                                        textColor: const Color(0xff444050)),
                                                    CommonViews().customClickableText(
                                                        textContent: "اضغط هنا",
                                                        fontSize: 13.sp,
                                                        onTap: () {
                                                          AppNavigator.of(context).pushAndRemoveUntil(const LoginScreen());
                                                        },
                                                        textColor: const Color(0xff7367f0)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                ListView.builder(
                                                  itemCount: itemsEmail.length,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.only(bottom: 8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '● ',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14.sp,
                                                                color: Colors.black),
                                                          ),
                                                          CommonViews().customText(
                                                              textContent:
                                                              '${index + 1}. ${itemsEmail[index]}',
                                                              fontSize: 12.sp,
                                                              withFontFamily: false,
                                                              textColor: const Color(0xff444050)),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                    } else if (item == "طريقة الدخول الى حسابك عبر رقم الهاتف") {
                                      bodyContent =   Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CommonViews().customText(
                                                    textContent:
                                                    "ادخل عن طريق الرابط التالي: ",
                                                    fontSize: 13.sp,
                                                    textColor: const Color(0xff444050)),
                                                CommonViews().customClickableText(
                                                    textContent: "اضغط هنا",
                                                    fontSize: 13.sp,
                                                    onTap: () {
                                                      AppNavigator.of(context).pushAndRemoveUntil(const LoginScreen());
                                                    },
                                                    textColor: const Color(0xff7367f0)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            ListView.builder(
                                              itemCount: itemsPhone.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '● ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14.sp,
                                                            color: Colors.black),
                                                      ),
                                                      CommonViews().customText(
                                                          textContent:
                                                          '${index + 1}. ${itemsPhone[index]}',
                                                          fontSize: 12.sp,
                                                          withFontFamily: false,
                                                          textColor: const Color(0xff444050)),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );

                                    } else {
                                      bodyContent = null;
                                    }
                                    AppNavigator.of(context).pushReplacement(MyAccount(
                                      title: item,
                                      body: bodyContent,
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
