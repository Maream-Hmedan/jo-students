// ignore_for_file: use_full_hex_values_for_flutter_colors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/end_drawer/helper_end_drawer/help_footer.dart';
import 'package:jo_students/screens/login/login_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';

import 'active_key.dart';
import 'available_pay.dart';
import 'communicatin_helper.dart';
import 'general_question.dart';
import 'help_section.dart';
import 'my_account.dart';
import 'services.dart';

class MainSections extends StatefulWidget {
  const MainSections({super.key});

  @override
  State<MainSections> createState() => _MainSectionsState();
}

class _MainSectionsState extends State<MainSections> {
  final MainSectionsController controller = Get.put(MainSectionsController());
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


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      color: const Color(0xfff6f5f8),
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          CommonViews().customText(
            textContent: 'الأقسام الرئيسية',
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            textColor: Colors.black,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 2.h,
          ),
          availablePaymentMethod(context),

        services(context),
        activeKeyWidget(context),
          generalQuestion(context),
          manageMyAccount(context),
          contactUs(context),
          SizedBox(
            height: 5.h,
          ),
          const HelpSection(),
          SizedBox(
            height: 5.h,
          ),
          HelpFooter(),
        ],
      ),
    );
  }

  Container services(BuildContext context) {
    return Container(
      width: 100.w,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 12.w,
                child: Center(
                    child: Image.asset(helpCenterIcon2)
                ),
              ),
              SizedBox(width: 2.w),
              CommonViews().customText(
                textContent: 'الخدمات',
                fontSize: 15.sp,
                textColor: const Color(0xff4444050),
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Obx((){
            return Column(
              children:
              controller.services.asMap().entries.map((entry) {
                final e = entry.value;
                return GestureDetector(
                  onTap: () {
                    controller.selectedServices.value = e;
                    controller.updateFilteredServices();
                    Widget? bodyContent;
                    if (e == "خاصية سؤال وجواب") {
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
                    } else if (e == "بنك الأسئلة") {
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

                    AppNavigator.of(context).push(
                      Services(
                        title: e,
                        body: bodyContent,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonViews().customText(
                          textContent: e,
                          fontSize: 13.sp,
                          textColor:
                          e== controller.selectedServices.value
                              ? const Color(0xff7367f0)
                              : const Color(0xff595664),
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
          })
        ,
          SizedBox(height: 6.h),
        ],
      ),
    );
  }

  Container contactUs(BuildContext context) {
    return Container(
          width: 100.w,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 12.w,
                    child: Center(
                        child: Image.asset(helpCenterIcon6)
                    ),
                  ),
                  SizedBox(width: 2.w),
                  CommonViews().customText(
                    textContent: 'تواصل معنا',
                    fontSize: 15.sp,
                    textColor: const Color(0xff4444050),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Obx((){
                return Column(
                  children:
                  controller.communication.asMap().entries.map((entry) {
                    final e = entry.value;
                    return GestureDetector(
                      onTap: () {
                        controller.selectedCommunication.value = e;
                        controller.updateFilteredCommunication();
                        AppNavigator.of(context).push(CommunicationHelper(
                          title: e,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonViews().customText(
                              textContent: e,
                              fontSize: 13.sp,
                              textColor:
                              e== controller.selectedCommunication.value
                                  ? const Color(0xff7367f0)
                                  : const Color(0xff595664),
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
              })
              ,
              SizedBox(height: 6.h),
            ],
          ),
        );
  }

  Container manageMyAccount(BuildContext context) {
    return Container(
          width: 100.w,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 12.w,
                    child: Center(
                        child: Image.asset(helpCenterIcon5)
                    ),
                  ),
                  SizedBox(width: 2.w),
                  CommonViews().customText(
                    textContent: 'إدارة حسابي',
                    fontSize: 15.sp,
                    textColor: const Color(0xff4444050),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Obx((){
                return Column(
                  children:
                  controller.myAccount.asMap().entries.map((entry) {
                    final e = entry.value;
                    Widget? bodyContent;
                    if (e == "طريقة الدخول الى حسابك عبر البريد الإلكتروني")
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
                    } else if (e == "طريقة الدخول الى حسابك عبر رقم الهاتف") {
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
                    return GestureDetector(
                      onTap: () {
                        controller.selectedMyAccount.value = e;
                        controller.updateFilteredMyAccount();
                        AppNavigator.of(context).push(MyAccount(
                          title: e,
                          body: bodyContent,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonViews().customText(
                              textContent: e,
                              fontSize: 13.sp,
                              textColor:
                              e== controller.selectedMyAccount.value
                                  ? const Color(0xff7367f0)
                                  : const Color(0xff595664),
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
                ) ;
              })
             ,
              SizedBox(height: 6.h),
            ],
          ),
        );
  }

  Container generalQuestion(BuildContext context) {
    return Container(
          width: 100.w,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                  width: 12.w,
                  child: Center(
                      child: Image.asset(helpCenterIcon4)
                  ),
                ),
                  SizedBox(width: 2.w),
                  CommonViews().customText(
                    textContent: 'اسئلة عامة',
                    fontSize: 15.sp,
                    textColor: const Color(0xff4444050),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Obx(() {
                return   Column(
                  children:
                  controller.generalQuestion.asMap().entries.map((entry) {
                    final e = entry.value;
                    return GestureDetector(
                      onTap: () {
                        controller.selectedGeneralQuestion.value = e;
                        controller.updateFilteredGeneralQuestion();
                        Widget? bodyContent;
                        if (e == "من هي منصة اكاديمية طلاب الأردن") {
                          bodyContent =
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 3.h),
                                  CommonViews().customText(
                                      textContent: "منصة اكاديمية طلاب الأردن ",
                                      fontSize: 18.sp,
                                      textColor: const Color(0xff7367f0)),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  CommonViews().customText(
                                    textContent:
                                    'منصة أردنية للتعلّم عن بُعد، توفر لطلبة المدارس من الصف الأول '
                                        'وحتى الصف الثاني الثانوي دروسًا تعليمية عن طريق مقاطع فيديو '
                                        'مصوَّرة مُنظّمة ومُجدولة.',
                                    fontSize: 11.sp,
                                    textAlign: TextAlign.justify,
                                    textColor: const Color(0xff444050),
                                  ),
                                  CommonViews().customText(
                                    textContent:
                                    ' وفقًا لمنهاج التعليم الأردنيّ، يُقدّمها نخبة متميزة من المعلمين'
                                        ' والمعلمات لتسهّل على الطلبة مواصلة تعلّمهم، ومتابعة موادهم الدراسية.',
                                    fontSize: 11.sp,
                                    textAlign: TextAlign.justify,
                                    textColor: const Color(0xff444050),
                                  ),
                                ],
                              );
                        }
                        else {
                          bodyContent = null;
                        }
                        AppNavigator.of(context).push(GeneralQuestion(
                          title: e,
                          body:bodyContent,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonViews().customText(
                              textContent: e,
                              fontSize: 13.sp,
                              textColor:
                              e== controller.selectedGeneralQuestion.value
                                  ? const Color(0xff7367f0)
                                  : const Color(0xff595664),
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
              SizedBox(height: 6.h),
            ],
          ),
        );
  }

  Container activeKeyWidget(BuildContext context) {
    return Container(
      width: 100.w,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 12.w,
                child: Center(
                    child: Image.asset(helpCenterIcon3)
                ),
              ),
              SizedBox(width: 2.w),
              CommonViews().customText(
                textContent: 'كيفية تفعيل المفتاح',
                fontSize: 15.sp,
                textColor: const Color(0xff4444050),
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Obx((){
            return Column(
              children:
              controller.activeKey.asMap().entries.map((entry) {
                final e = entry.value;
                return GestureDetector(
                  onTap: () {
                    controller.selectedActiveKey.value = e;
                    controller.updateFilteredActiveKey();
                    AppNavigator.of(context).push(ActiveKey(
                      title: e,
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonViews().customText(
                          textContent: e,
                          fontSize: 13.sp,
                          textColor:
                          e== controller.selectedActiveKey.value
                              ? const Color(0xff7367f0)
                              : const Color(0xff595664),
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
          SizedBox(height: 6.h),
        ],
      ),
    );
  }

  Container availablePaymentMethod(BuildContext context) {
    return
      Container(
          width: 100.w,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 12.w,
                    child: Center(
                      child: Image.asset(helpCenterIcon1)
                    ),
                  ),
                  SizedBox(width: 2.w),
                  CommonViews().customText(
                    textContent: 'طرق الدفع المتاحة',
                    fontSize: 15.sp,
                    textColor: const Color(0xff4444050),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Obx((){
                return  Column(
                  children:
                  controller.paymentMethod.asMap().entries.map((entry) {
                    final e = entry.value;
                    return GestureDetector(
                      onTap: () {
                        controller.selectedPaymentMethod.value = e;
                        controller.updateFilteredPaymentMethods();
                        AppNavigator.of(context).push(AvailablePay(
                          title: e,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonViews().customText(
                              textContent: e,
                              fontSize: 13.sp,
                              textColor:
                              controller.selectedPaymentMethod.value == e
                                  ? const Color(0xff7367f0)
                                  : const Color(0xff595664),
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

              SizedBox(height: 6.h),
            ],
          ),
        );
  }

}

class MainSectionsController extends GetxController {


  var paymentMethod = [
    'من خلال تطبيق البنك عن طريق CliQ',
    'الدفع من خلال Google pay',
    'من خلال أبل باي',
    'عن طريق الفيزا او الماستركارد',
  ];

  var services = ['خاصية سؤال وجواب', 'بنك الأسئلة', 'المكتبة'];

  var activeKey = ['ما هو مفتاح التفعيل', 'كيف اقوم بتفعيل المفتاح'];

  final List<String> generalQuestion = [
    'هل الاشتراك مدفوع ام مجاني',
    'من هي منصة اكاديمية طلاب الأردن',
  ];

  final List<String> communication = [
    'عن طريق الهاتف',
    'عن طريق البريد الإلكتروني',
    'مواقع التواصل الاجتماعي',
  ];

  final List<String> myAccount = [
    'طريقة تغيير كلمة السر من خلال البريد الإلكتروني',
    'طريقة تغيير كلمة السر من خلال رقم الهاتف',
    'طريقة إنشاء حساب جديد عبر رقم الهاتف',
    'طريقة إنشاء حساب جديد عبر البريد الإلكتروني',
    'طريقة الدخول الى حسابك عبر البريد الإلكتروني',
    'طريقة الدخول الى حسابك عبر رقم الهاتف',
  ];

  var filterPaymentMethod2 = <String>[].obs;
  var filterServices2 = <String>[].obs;
  var filterActiveKey2 = <String>[].obs;
  var filterGeneralQuestion2 = <String>[].obs;
  var filterMyAccount2 = <String>[].obs;
  var filterCommunication2 = <String>[].obs;

  var selectedPaymentMethod = ''.obs;
  var selectedActiveKey = ''.obs;
  var selectedGeneralQuestion = ''.obs;
  var selectedMyAccount = ''.obs;
  var selectedCommunication = ''.obs;

  var selectedServices = ''.obs;

  void updateFilteredPaymentMethods() {
    filterPaymentMethod2.value = paymentMethod
        .where((item) => item != selectedPaymentMethod.value)
        .toList();
    selectedActiveKey.value = '';
    selectedGeneralQuestion.value = '';
    selectedMyAccount.value = '';
    selectedCommunication.value = '';
    selectedServices.value = '';

  }
  void updateFilteredCommunication() {
    filterCommunication2.value = communication
        .where((item) => item != selectedCommunication.value)
        .toList();
    selectedActiveKey.value = '';
    selectedGeneralQuestion.value = '';
    selectedMyAccount.value = '';
    selectedPaymentMethod.value = '';
    selectedServices.value = '';
  }

  void updateFilteredMyAccount() {
    filterMyAccount2.value = myAccount
        .where((item) => item != selectedMyAccount.value)
        .toList();
    selectedActiveKey.value = '';
    selectedGeneralQuestion.value = '';
    selectedCommunication .value = '';
    selectedPaymentMethod.value = '';
    selectedServices.value = '';
  }

  void updateFilteredServices() {
    filterServices2.value =  services
        .where((item) => item != selectedServices.value)
        .toList();
    selectedActiveKey.value = '';
    selectedGeneralQuestion.value = '';
    selectedMyAccount.value = '';
    selectedCommunication.value = '';
    selectedPaymentMethod.value = '';
  }

  void updateFilteredGeneralQuestion() {
    filterGeneralQuestion2.value =  generalQuestion
        .where((item) => item != selectedGeneralQuestion.value)
        .toList();
    selectedActiveKey.value = '';
    selectedMyAccount.value = '';
    selectedServices.value = '';
    selectedCommunication.value = '';
    selectedPaymentMethod.value = '';
  }

  void updateFilteredActiveKey() {
    filterActiveKey2.value =  activeKey
        .where((item) => item != selectedActiveKey.value)
        .toList();
    selectedGeneralQuestion.value = '';
    selectedMyAccount.value = '';
    selectedServices.value = '';
    selectedCommunication.value = '';
    selectedPaymentMethod.value = '';
  }


}
