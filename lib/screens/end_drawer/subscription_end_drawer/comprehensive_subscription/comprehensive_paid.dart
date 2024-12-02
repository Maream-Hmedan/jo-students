// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/screens/end_drawer/subscription_end_drawer/successful_paid.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';

class ComprehensivePaidCard extends StatefulWidget {
  List<String> list;

  ComprehensivePaidCard({super.key, required this.list});

  @override
  State<ComprehensivePaidCard> createState() => _ComprehensivePaidCardState();
}

class _ComprehensivePaidCardState extends State<ComprehensivePaidCard> {
  bool isExpanded = false;
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const EndDrawerView(),
        appBar: CustomProfileAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: 100.w,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(10),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonViews().customText(
                              textContent: 'اختر طريقة الدفع',
                              fontSize: 16.sp,
                              textColor:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontWeight: FontWeight.bold),
                          Transform.scale(
                            scale: 0.6,
                            child: Image.asset(
                              eightMenuImage,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                      CommonViews().customText(
                        textContent:
                            'يرجى التأكد من تفاصيل الإشتراك قبل الدفع       ',
                        textColor: Theme.of(context).textTheme.bodyMedium!.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          paymentsImage,
                          height: 5.h,
                          width: 55.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(color: const Color(0xff7367f0)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 2.h),
                            CommonViews().customText(
                              textContent: 'الباقة الشاملة •',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              textColor:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                            SizedBox(height: 3.h),
                            CommonViews().customText(
                              textContent: 'جميع المواد',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              textColor:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                            SizedBox(height: 2.h),
                            CommonViews().customText(
                              textContent: 'الصف السادس',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              textColor:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                            SizedBox(height: 2.h),
                            CommonViews().customText(
                              textContent: 'الفصل الدراسي الاول-2025',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              textColor:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                            SizedBox(height: 3.h),
                            CommonViews().customText(
                              textContent: 'صالح لغاية:31-01-2025 •',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              textColor:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                            SizedBox(height: 1.h),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(color: const Color(0xff7367f0)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            paidWidget(
                                name: 'بطاقة ائتمانية',
                                image: visaImage,
                                paymentMethod: 'visa'),
                            paidWidget(
                              name: 'إي فواتيركم',
                              image: ePaidImage,
                              paymentMethod: 'epaid',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(color:   Theme.of(context).textTheme.bodySmall!.color ?? Colors.black),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        margin: const EdgeInsets.all(8),
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 2.h),
                            CommonViews().customText(
                              textContent: 'مزايا الباقة',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              textColor:  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                            SizedBox(height: 2.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                for (var item in widget.list)
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
                                              text: ' •',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 1.h),
                              ],
                            ),
                            SizedBox(height: 1.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector paidWidget({
    required String name,
    required String image,
    required String paymentMethod,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod =
              selectedPaymentMethod == paymentMethod ? null : paymentMethod;
        });
      },
      child: Container(
        width: 100.w,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                selectedPaymentMethod == paymentMethod
                    ? Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      )
                    : Icon(
                        Icons.arrow_back_ios_sharp,
                        size: 15,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                CommonViews().customText(
                  textContent: name,
                  fontSize: 13.sp,
                  textColor: Theme.of(context).textTheme.titleLarge!.color,
                ),
                Image.asset(
                  image,
                  height: 5.h,
                  width: 20.w,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            if (selectedPaymentMethod == paymentMethod) ...[
              SizedBox(
                height: 1.h,
              ),
              paymentButton(),
              SizedBox(
                height: 1.h,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget paymentButton() {
    return CommonViews().customClickableContainer(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      colorBorder: Colors.transparent,
      radius: 8,
      color:const Color(0xff7367f0).withOpacity(0.2),
      width: 100.w,
      height: 5.h,
      onTap: () {
        AppNavigator.of(context).push(const SuccessfulPaid());
      },
      child: Center(
        child: CommonViews().customText(
            textContent: 'ادفع',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            textColor: const Color(0xff7367f0)),
      ),
    );
  }
}
