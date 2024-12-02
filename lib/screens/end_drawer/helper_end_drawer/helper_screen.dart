// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/login/login_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/help_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'general_question.dart';
import 'main_sections.dart';
import 'my_account.dart';
import 'read_more.dart';

class HelperScreen extends StatefulWidget {
  const HelperScreen({super.key});

  @override
  State<HelperScreen> createState() => _HelperScreenState();
}

class _HelperScreenState extends State<HelperScreen> {
  final TextEditingController searchController = TextEditingController();

  final FocusNode searchFocusNode = FocusNode();

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

  final List<String> myAccount = [
    'طريقة تغيير كلمة السر من خلال البريد الإلكتروني',
    'طريقة تغيير كلمة السر من خلال رقم الهاتف',
    'طريقة إنشاء حساب جديد عبر رقم الهاتف',
    'طريقة إنشاء حساب جديد عبر البريد الإلكتروني',
    'طريقة الدخول الى حسابك عبر رقم الهاتف',
  ];

  final MainSectionsController controller = Get.put(MainSectionsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData.light(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Stack(
                children: [
                  Image.asset(
                    helpBackGround,
                    height: 40.h,
                    width: 100.w,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    children: [
                      const HelpAppBar(),
                      SizedBox(
                        height: 5.h,
                      ),
                      CommonViews().customText(
                        textContent: 'مرحباً، كيف يمكننا المساعدة؟',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        textColor: const Color(0xff7367f0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: 90.w,
                        child: CommonViews().createTextFormField(
                          controller: searchController,
                          focusNode: searchFocusNode,
                          hint: 'ابحث في مركز المساعدة',
                          prefixIcon:  const Icon(Icons.search),
                          keyboardType: TextInputType.multiline,
                          inputAction: TextInputAction.go,
                          borderColor: const Color(0xffacaab1),
                          fillColor:Colors.white,
                          radius: 5,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: CommonViews().customText(
                          textContent:
                              'ابحث عن إجابات لأسئلتك بالأقسام الرئيسية أو ادخل كلمات مفتاحية في صندوق البحث للمساعدة',
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                          textColor: Colors.grey.shade400,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      CommonViews().customText(
                        textContent: 'المقالات الأكثر شعبية',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        textColor: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                      customCardWidget(
                        image: helpCenterImageOne,
                        title: "من هي منصة اكاديمية طلاب الاردن",
                        subTitle: '''
           منصة أردنية للتعلّم عن بُعد، توفر لطلبة المدارس من    
                 الصف الأول وحتى الصف الثاني الثانوي ...  ''',
                        helpCenter: "اسئلة عامة",
                        itemBody: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonViews().customText(
                                textContent: "منصة اكاديمية طلاب الأردن ",
                                fontSize: 13.sp,
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
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 6.h,
                              width: 100.w,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Color(0xffF3F2F3)),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CommonViews().customText(
                                    textContent: "  المواضيع اخرى  ",
                                    fontSize: 13.sp,
                                    textColor: const Color(0xff444050),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            GestureDetector(
                              onTap: () {
                              const  e="هل الاشتراك مدفوع ام مجاني";
                                controller.selectedGeneralQuestion.value =e;
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonViews().customText(
                                      textContent: "هل الاشتراك مدفوع ام مجاني ",
                                      fontSize: 12.sp,
                                      textColor: const Color(0xff595664),
                                      fontWeight: FontWeight.w500),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 17,
                                    color: Color(0xffb1afb6),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      customCardWidget(
                        image: helpCenterImageTow,
                        title: "الدخول الى حسابك عبر البريد الألكتروني",
                        subTitle:
                            "ادخل عنوان بريدك الألكتروني الذي تم إنشاؤه لأول مرة ...",
                        additionalData: "طريقة",
                        helpCenter: "إدارة حسابي",
                        itemBody: Padding(
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
                                      textColor: const Color(0xff7367f0),
                                      onTap: () {
                                        AppNavigator.of(context).pushAndRemoveUntil(const LoginScreen());
                                      }),
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
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                height: 6.h,
                                width: 100.w,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Color(0xffF3F2F3)),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CommonViews().customText(
                                      textContent: "   المواضيع اخرى  ",
                                      fontSize: 13.sp,
                                      textColor: const Color(0xff444050),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              ...myAccount.map((e) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.selectedMyAccount.value = e;
                                        controller.updateFilteredMyAccount();
                                        AppNavigator.of(context).push(MyAccount(
                                          title: e,
                                        ));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CommonViews().customText(
                                            textContent: e,
                                            fontSize: 13.sp,
                                            textColor: const Color(0xff595664),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 17,
                                            color: Color(0xffb1afb6),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      customCardWidget(
                        image: helpCenterImageThree,
                        title: "الدخول الى حسابك عبر الهاتف",
                        subTitle: '''
              دخل رقم الهاتف الذي تم تفعيل الاشتراك عليه لأول
            مرة ...      ''',
                        additionalData: "طريقة",
                        helpCenter: "إدارة حسابي",
                        itemBody: Padding(
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
                                      onTap: () {
                                        AppNavigator.of(context).pushAndRemoveUntil(const LoginScreen());
                                      },
                                      fontSize: 13.sp,
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
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                height: 6.h,
                                width: 100.w,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Color(0xffF3F2F3)),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CommonViews().customText(
                                      textContent: "   المواضيع اخرى  ",
                                      fontSize: 13.sp,
                                      textColor: const Color(0xff444050),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              ...myAccount.map((e) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.selectedMyAccount.value = e;
                                        controller.updateFilteredMyAccount();
                                        AppNavigator.of(context).push(MyAccount(
                                          title: e,
                                        ));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CommonViews().customText(
                                            textContent: e,
                                            fontSize: 13.sp,
                                            textColor: const Color(0xff595664),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 17,
                                            color: Color(0xffb1afb6),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const MainSections(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customCardWidget(
      {required image,
      required title,
      required subTitle,
      required itemBody,
      required helpCenter,
      String? additionalData}) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black12)),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(right: 10, bottom: 10, top: 16, left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.h),
          Image.asset(
            image,
            height: 10.h,
            width: 20.w,
          ),
          SizedBox(height: 1.h),
          CommonViews().customText(
              textContent: title,
              fontSize: 15.sp,
              textColor: const Color(0xff4444050),
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500),
          SizedBox(height: 1.h),
          CommonViews().customText(
            textContent: subTitle,
            fontSize: 11.sp,
            textColor: const Color(0xff6d6b77),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 2.h),
          CommonViews().customClickableContainer(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            colorBorder: Colors.transparent,
            radius: 4,
            color: const Color(0xff7367f0).withOpacity(0.2),
            width: 25.w,
            child: Center(
              child: CommonViews().customClickableText(
                  textContent: 'اقرأ المزيد',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  textColor: const Color(0xff7367f0),
                  onTap: () {
                    AppNavigator.of(Get.context!).push(ReadMore(
                      title: title,
                      additionalData: additionalData,
                      helpCenter: helpCenter,
                      itemBody: itemBody,
                    ));
                  }),
            ),
          ),
        ],
      ),
    );
  }

}




