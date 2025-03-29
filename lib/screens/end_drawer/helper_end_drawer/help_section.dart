// ignore_for_file: use_full_hex_values_for_flutter_colors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';



class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonViews().customText(
          textContent: 'هل لا تزال بحاجة إلى المساعدة؟',
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          textColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.h),
        CommonViews().customText(
          textContent: 'يسعد المتخصصون لدينا دائمًا بمساعدتك.',
          fontSize: 11.sp,
          textColor: const Color(0xff6d6b77),
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
        ),
        CommonViews().customText(
          textContent: '''
   اتصل بنا خلال ساعات العمل القياسية أو راسلنا عبر البريد
           الإلكتروني على مدار الساعة طوال أيام الأسبوع وسنرد عليك.
          ''',
          fontSize: 11.sp,
          textColor: const Color(0xff6d6b77),
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 1.h),
        const ContactInfo(
            icon: Icons.email_outlined,
            label: 'البريد الالكتروني',
            contact: 'support@jo-students.com',
            color: Color(0xff7367f0)),
        SizedBox(
          height: 1.h,
        ),
        const ContactInfo(
          icon: Icons.phone_in_talk_sharp,
          label: 'رقم الهاتف',
          contact: '+1234 568 963',
          color: Colors.green,
        ),
      ],
    );
  }
}

class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String contact;
  final Color color;

  const ContactInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.contact,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 12.w,
              height: 5.h,
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Column(
              children: [
                CommonViews().customText(
                  textContent: label,
                  fontSize: 12.sp,
                  textColor: const Color(0xff4444050),
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                ),
                CommonViews().customText(
                  textContent: contact,
                  fontSize: 12.sp,
                  withFontFamily: false,
                  textColor: const Color(0xff4444050),
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}