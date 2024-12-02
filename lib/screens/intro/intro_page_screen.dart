import 'package:flutter/material.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/login/login_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<IntroPageItem> _pages = [];
  PageController controller = PageController();

  @override
  void initState() {
    _fillPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        color: AppColors.backGroundColor,
        padding: const EdgeInsets.all(8),
        child: Column(children: [

          SizedBox(
            height: 12.h,
          ),
          SizedBox(
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonViews().customText(
                    textContent: "Jo-Students.com  ",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
                CommonViews().customText(
                    textContent: " أكاديمية طلاب الأردن  ",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700)
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          SizedBox(
            height: 60.h,
            child: PageView.builder(
              itemBuilder: (context, index) {
                return _pages[index].view;
              },
              itemCount: _pages.length, // 3  0 1 2
              controller: controller,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          SmoothPageIndicator(
            controller: controller, // PageController
            count: _pages.length,
            effect: ExpandingDotsEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.blueGrey.shade300,
                dotWidth: 10,
                dotHeight: 7,
                spacing: 10),
            onDotClicked: (index) {},
          ),
          SizedBox(
            height: 3.h,
          )
        ]),
      ),
    );
  }

  void _fillPages() {
    _pages.add(
      IntroPageItem(
        view: firstIntroView(),
      ),
    );
    _pages.add(IntroPageItem(
      view: secondIntroView(),
    ));

    _pages.add(
      IntroPageItem(
        view: thirdIntroView(),
      ),
    );
  }

  Stack firstIntroView() {
    return Stack(children: [
      SizedBox(
        height: 60.h,
      ),
      Container(
        height: 57.h,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.primaryColorLight,
            borderRadius: BorderRadius.circular(32)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              firstSlider,
              width: 100.w,
              height: 25.h,
            ),
            Container(
              width: 30.w,
              height: 4.h,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: CommonViews().customText(
                textContent: "من نحن",
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              )),
            ),
            CommonViews().customText(
                textContent: "بيئة تعليمية متكاملة",
                textColor: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600),
            SizedBox(
              height: 1.h,
            ),
            CommonViews().customText(
                textContent: '''
    تنوع خدماتنا من تعليم تفاعلي متكامل لطلاب
    والدولي والجامعات والعديد من الدورات التدريبية
           المنهاج الوطني
          ''',
                textColor: Colors.grey,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center),
          ],
        ),
      ),
      Positioned(left: 10, top: 0, child: Image.asset(topLeftFirstSlider)),
      Positioned(right: 10, top: 0, child: Image.asset(topRightFirstSlider)),
      Positioned(
        bottom: 4,
        left: 33.w,
        child: GestureDetector(
          onTap: registerImageMethod,
          child: Image.asset(
            registerImage,
            width: 35.w,
          ),
        ),
      ),
    ]);
  }

  Stack secondIntroView() {
    return Stack(
      children: [
        SizedBox(
          height: 60.h,
        ),
        Container(
          height: 57.h,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppColors.secondSliderBackGroundColor,
              borderRadius: BorderRadius.circular(32)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                secondSlider,
                width: 100.w,
                height: 25.h,
              ),
              Container(
                width: 30.w,
                height: 4.h,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(32)),
                child: Center(
                  child: CommonViews().customText(
                      textContent: "المدرسة",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              CommonViews().customText(
                  textContent: "ملفات واختبارات لكل مادة",
                  fontSize: 22.sp,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600),
              CommonViews().customText(
                  textContent: '''
    نموذج افتراضي من المدرسة
    حيث يضم جميع الصفوف بجميع المواد
              الحقيقية
            ''',
                  fontSize: 12.sp,
                  textColor: Colors.white,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
        Positioned(left: 7.w, top: 5.h, child: Image.asset(cloudImage)),
        Positioned(
            bottom: 4,
            left: 33.w,
            child: GestureDetector(
              onTap: registerImageMethod,
              child: Image.asset(
                registerImage,
                width: 35.w,
              ),
            )),
      ],
    );
  }

  Stack thirdIntroView() {
    return Stack(
      children: [
        SizedBox(
          height: 60.h,
        ),
        Container(
          height: 57.h,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppColors.primaryColorLight,
              borderRadius: BorderRadius.circular(32)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 4.h,
              ),
              CommonViews().customText(
                  textContent: "صفوف اكادمية طلاب الاردن  ",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.black),
              SizedBox(
                height: 2.h,
              ),
              Image.asset(
                thirdSlider,
                width: 90.w,
                height: 40.h,
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 4,
            left: 33.w,
            child: GestureDetector(
              onTap: registerImageMethod,
              child: Image.asset(
                registerImage,
                width: 35.w,
              ),
            )),
      ],
    );
  }

  void registerImageMethod() {
    AppNavigator.of(context).pushAndRemoveUntil(const LoginScreen());
  }
}

class IntroPageItem {
  final Widget view;

  IntroPageItem({
    required this.view,
  });
}
