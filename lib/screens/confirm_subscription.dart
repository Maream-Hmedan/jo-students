import 'package:flutter/material.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';

import 'end_drawer/subscription_end_drawer/subscription_card_screen.dart';

class ConfirmSubscription extends StatelessWidget {
  const ConfirmSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      gradient: const LinearGradient(
                        colors: [Color(0xff796ef1), Color(0xffb6aff7)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          rocketImage,
                          width: 40.w,
                          height: 15.h,
                        ),
                        SizedBox(height: 2.h),
                        CommonViews().customText(
                            textContent: 'اشترك الآن',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                  text: 'اضمن ارتفاع معدلك إلى ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'GE Dinar One',
                                    fontSize: 14.sp,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '90%',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'sans-serif',
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' مع الاشتراك المدفوع',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'GE Dinar One',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonViews().customClickableContainer(
                              onTap: () {
                                AppNavigator.of(context)
                                    .push(SubscriptionCard());
                              },
                              colorBorder: Colors.transparent,
                              color: const Color(0xffffffff),
                              width: 20.w,
                              radius: 5,
                              child: Center(
                                child: CommonViews().customText(
                                  textContent: 'اشترك الاّن',
                                  textColor: const Color(0xff7367f0),
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 1.w),
                            CommonViews().customClickableContainer(
                              onTap: () {
                                AppNavigator.of(context).pop();
                              },
                              colorBorder: Colors.transparent,
                              radius: 5,
                              color: const Color(0xffebebed),
                              width: 20.w,
                              child: Center(
                                child: CommonViews().customText(
                                  textContent: 'لا، شكراً',
                                  textColor: const Color(0xff808390),
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Show Subscription Modal'),
        ),
      ),
    );
  }
}
