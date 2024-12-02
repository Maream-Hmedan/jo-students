import 'package:flutter/material.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';

class HelpFooter extends StatelessWidget {
  HelpFooter({super.key});

  final FocusNode subscriptionFocusNode = FocusNode();
  final TextEditingController subscriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
          topLeft: Radius.circular(60),
        ),
        color: Color(0xff2f3349),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 3.w,
              ),
              Image.asset(
                logoIcon,
                height: 5.h,
                width: 20.w,
                color: Colors.white,
              ),
              CommonViews().customText(
                  textContent: "اكاديمية طلاب الاردن",
                  textColor: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w700),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          CommonViews().customText(
            textContent: '''
  منصة أردنية للتعلّم عن بُعد، توفر لطلبة المدارس من الصف الأول 
           وحتى الصف الثاني الثانوي دروسًا تعليمية
                      ''',
            fontSize: 11.sp,
            textColor: Colors.white,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CommonViews().customText(
              textContent: "اشترك في النشرة الإخبارية ",
              fontSize: 11.sp,
              textColor: Colors.white,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                width: 60.w,
                child: CommonViews().createTextFormField(
                    controller: subscriptionController,
                    focusNode: subscriptionFocusNode,
                    textColor: Colors.white,
                    hint: "البريد الإلكتروني",
                    errorHeight: 0.001,
                    onSubmitted: (v) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    keyboardType: TextInputType.emailAddress,
                    inputAction: TextInputAction.go,
                    borderColor: const Color(0xff6d6b77),
                    fillColor: const Color(0xff2f3349),
                    radius: 0),
              ),
              CommonViews().customClickableContainer(
                onTap: () {},
                color: const Color(0xff7367f0),
                width: 20.w,
                colorBorder: Colors.transparent,
                radius: 0,
                height: 5.h,
                child: Center(
                  child: CommonViews().customText(
                      textContent: "اشتراك",
                      fontWeight: FontWeight.w800,
                      fontSize: 13.sp),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonViews().customText(
                  textContent: "القائمة",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CommonViews().customText(
                  textContent: "من نحن",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CommonViews().customText(
                  textContent: "الخدمات ",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CommonViews().customText(
                  textContent: "اّلية التعلم ",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CommonViews().customText(
                  textContent: "الأسئلة الشائعة ",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CommonViews().customText(
                  textContent: "تواصل معنا ",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CommonViews().customText(
                  textContent: "الاحكام",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CommonViews().customText(
                  textContent: "شروط الاستخدام",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CommonViews().customText(
                  textContent: "اتفاقية الخصوصية ",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CommonViews().customText(
                  textContent: "سياسة ملفات التعريف الارتباط",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CommonViews().customText(
                  textContent: "قم بتنزيل تطبيقنا",
                  fontSize: 11.sp,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Image.asset(appleStore,width: 55.w,),
                SizedBox(
                  height: 1.h,
                ),
                Image.asset(googlePlay,width: 55.w,),
                SizedBox(
                  height: 6.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
