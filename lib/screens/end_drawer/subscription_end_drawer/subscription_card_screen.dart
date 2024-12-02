import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';

import 'basic_subscription/basic_card_subscription.dart';
import 'comprehensive_subscription/comprehensive_card_screen.dart';

class SubscriptionCard extends StatelessWidget {
  SubscriptionCard({super.key});

  final TextEditingController keyController = TextEditingController();
  final FocusNode keyFocusNode = FocusNode();
  final GlobalKey<FormState> _key = GlobalKey();

  final List<String> _first = [
    'شاهد جميع الدروس لجميع مواد منهاجك',
    'جاوب أسئلة و إختبارات جميع المواد',
    'العاب تعليمية',
    'اسأل المعلمين عن حل اسئلة في جميع المواد',
    'حصص مباشرة'
  ];
  final List<String> _second = [
    'شاهد دروس المادة المختارة فقط',
    'جاوب أسئلة و إختبارات جميع المواد',
    'العاب تعليمية',
    'اسأل المعلمين عن حل اسئلة في جميع المواد',
    'حصص مباشرة'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const EndDrawerView(),
        appBar:CustomProfileAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  subscriptionCardContent(context),
                  subscriptionKey(
                      controller: keyController,
                      focusNode: keyFocusNode,
                      key: _key, context: context),
                  chooseSubscription(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container subscriptionCardContent(BuildContext context) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: const EdgeInsets.only(top: 16, right: 16),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CommonViews().customText(
            textContent: 'اشترك بخطوتك الأولى للنجاح',
            textColor:Theme.of(context).textTheme.titleLarge!.color,
            fontSize: 16.sp,
          ),
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              text: 'ارفع معدلك... حسن أدائك ...',
              style: TextStyle(
                color: const Color(0xff7367f0),
                fontSize: 16.sp,
                fontFamily: 'GE Dinar One',
              ),
              children: [
                TextSpan(
                  text: ' و وفّر \nفي مصاريفك التعليمية',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge!.color,
                    fontSize: 16.sp,
                    fontFamily: 'GE Dinar One',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonViews().customText(
            textContent: 'كل باقة لها عدة مزايا تلبي احتياجاتك',
            textColor:Theme.of(context).textTheme.bodyMedium!.color,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          SizedBox(
            height: 6.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              pencilRocketImage,
              height: 20.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Container subscriptionKey(
      {required controller, required focusNode, required key
        ,required BuildContext context}) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CommonViews().customText(
            textContent: 'هل لديك مفتاح اشتراك؟',
            textColor:Theme.of(context).textTheme.titleLarge!.color,
            fontSize: 16.sp,
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonViews().customText(
            textContent: 'ادخل مفتاح الاشتراك',
            textColor: Theme.of(context).textTheme.bodyMedium!.color,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          CommonViews().customText(
            textContent: 'المفتاح يتكون من أحرف وأرقام إنجليزية فقط',
            textColor:Theme.of(context).textTheme.bodyMedium!.color,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonViews().customClickableContainer(
                  onTap: () {
                    if (key.currentState!.validate()) {
                      AppNavigator.of(context).pop();
                    }
                  },
                  color: const Color(0xff7367f0),
                  width: 13.w,
                  colorBorder: Colors.transparent,
                  radius: 5,
                  height: 5.h,
                  child: const Icon(
                    Icons.search_sharp,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 65.w,
                child: CommonViews().createTextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  hint: "XXXX-XXXX-XXXX",
                  errorHeight: 0.001,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "يرجى ادخال المفتاح ";
                    }
                    return null;
                  },
                  onSubmitted: (v) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  keyboardType: TextInputType.multiline,
                  inputAction: TextInputAction.go,
                  borderColor: Theme.of(context).textTheme.titleMedium!.color,
                  fillColor:Theme.of(context).appBarTheme.backgroundColor,
                 // fillColor: Theme.of(context).textTheme.titleSmall!.color,
                  radius: 5,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              pricingStandardImage,
              height: 23.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Container chooseSubscription(BuildContext context) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: const EdgeInsets.all(16),
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
        children: [
          CommonViews().customText(
            textContent: 'اختر باقتك',
            textColor: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: 16.sp,
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonViews().customText(
            textContent: 'كل باقة لها عدة مزايا تلبي احتياجاتك',
            textColor:  Theme.of(context).textTheme.bodyMedium!.color,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          SizedBox(
            height: 3.h,
          ),
          subscriptionChoices(
            list: _first,
            show: true,
            price: "30",
            colorButton:  const Color(0xff7367f0).withOpacity(0.2),
            borderColor: const Color(0xff7367f0),
            onTap: () {
              AppNavigator.of(Get.context!).push(ComprehensiveCardScreen(
                list: _first,
              ));
            },
            name: "الشاملة", context: context,
          ),
          SizedBox(
            height: 1.h,
          ),
          subscriptionChoices(
            list: _second,
            show: false,
            price: "25",
            colorButton: const Color(0xff28c76f).withOpacity(0.2),
            borderColor: const Color(0xff28c76f),
            onTap: () {
              showAddQuestionPopup(Get.context!);
            },
            name: "الاساسية", context: context,
          ),
          SizedBox(
            height: 1.h,
          ),
        ],
      ),
    );
  }

  Container subscriptionChoices(
      {required List list,
      required bool show,
      required VoidCallback onTap,
      required price,
      required name,
        required context,
      required colorButton,
      required borderColor}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          show
              ? Align(
                  alignment: Alignment.topLeft,
                  child:
                  CommonViews().customClickableContainer(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    colorBorder: Colors.transparent,
                    radius: 4,
                    color: const Color(0xff7367f0).withOpacity(0.2),
                    width: 30.w,
                    child: Center(
                      child: CommonViews().customText(
                          textContent: 'أفضل خيار',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                          textColor: const Color(0xff7367f0)),
                    ),
                  ),
                )
              : const SizedBox(),
          SizedBox(height: 2.h),
          CommonViews().customText(
            textContent: 'الباقة $name',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            textColor: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          SizedBox(height: 1.h),
          CommonViews().customText(
            textContent: 'ابتداءً من',
            fontSize: 12.sp,
            textColor:Theme.of(context).textTheme.bodyLarge!.color,
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 9.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: CommonViews().customText(
                    textContent: 'دينار اردني',
                    fontSize: 12.sp,
                    textColor: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                SizedBox(width: 1.w),
                CommonViews().customText(
                  textContent: price,
                  fontSize: 30.sp,
                  withFontFamily: false,
                  textColor: const Color(0xff7367f0),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var item in list)
                Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: item,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'GE Dinar One',
                            ),
                          ),
                          TextSpan(
                            text: '•',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 5.h),
          CommonViews().customClickableContainer(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            colorBorder: Colors.transparent,
            radius: 8,
            color: colorButton,
            width: 100.w,
            onTap: onTap,
            child: Center(
              child: CommonViews().customText(
                  textContent: 'اختر',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  textColor: borderColor),
            ),
          ),
        ],
      ),
    );
  }

  void showAddQuestionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            SizedBox(
              height: 20.h,
              width: 100.w,
            ),
            Positioned(
                top: 1.h,
                right: 1,
                left: 1,
                child: const BasicCardSubscription()),
            Positioned(
              top: 3.h,
              left: 4.h,
              child: GestureDetector(
                onTap: () {
                  AppNavigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  height: 4.h,
                  width: 7.w,
                  child: Center(
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color:Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
