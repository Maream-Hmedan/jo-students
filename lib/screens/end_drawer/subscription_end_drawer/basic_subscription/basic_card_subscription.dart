import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/selected_semester_controller.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';


class BasicCardSubscription extends StatelessWidget {
  const BasicCardSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).appBarTheme.backgroundColor,
        ),
        width: 90.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CommonViews().customText(
                textContent: 'الباقة الاساسية',
                fontSize: 15.sp,
                textColor: Theme.of(context).textTheme.titleLarge!.color,
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CommonViews().customText(
                textContent: 'الصف الرابع-الفصل الدراسي الاول',
                fontSize: 11.sp,
                textColor: Theme.of(context).textTheme.bodyLarge!.color,
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CommonViews().customText(
                textContent: 'يرجى اختيار المادة',
                fontSize: 11.sp,
                textColor: Theme.of(context).textTheme.bodyMedium!.color,
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CommonViews().customText(
                textContent: 'المادة',
                fontSize: 11.sp,
                textColor: Theme.of(context).textTheme.bodyMedium!.color,
                textAlign: TextAlign.right,
              ),
            ),
            const SelectedSubjectWidget(),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}

class SelectedSubjectWidget extends StatelessWidget {
  const SelectedSubjectWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final SelectedSubjectController controller =
    Get.put(SelectedSubjectController());

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 100.w,
        child: Obx(
              () => Stack(
            children: [
              SizedBox(
                width: 100.w,
                height: controller.isExpanded.value ? 33.h : 16.h,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: controller.isExpanded.value
                          ? const Color(0xff7367f0)
                          : Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      controller.toggleExpansion();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CommonViews().customText(
                        textContent: controller.selectedValue.value,
                        textColor:
                        Theme.of(context).textTheme.titleLarge!.color,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 9.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 3.w),
                    CommonViews().customClickableContainer(
                      onTap: () {
                        controller.validateAndNavigate();
                      },
                      radius: 5,
                      width: 15.w,
                      colorBorder: Colors.transparent,
                      color: const Color(0xff7367f0),
                      child: Center(
                        child: CommonViews().customText(
                          textContent: 'اختر',
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    CommonViews().customClickableContainer(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        AppNavigator.of(context).pop();
                      },
                      radius: 5,
                      width: 15.w,
                      colorBorder: Colors.transparent,
                      color: Theme.of(context).textTheme.titleSmall!.color,
                      child: Center(
                        child: CommonViews().customText(
                          textContent: 'اغلاق',
                          fontSize: 12.sp,
                          textColor:
                          Theme.of(context).textTheme.titleMedium!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.errorMessage.value != null)
                Positioned(
                  bottom: 8.h,
                  right: 0,
                  child: CommonViews().customText(
                    textContent: controller.errorMessage.value!,
                    textColor: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ),
              if (controller.isExpanded.value)
                Positioned(
                  top: 5.h,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),
                    child: Column(
                      children: controller.subjectList.map(
                            (e) => InkWell(
                          onTap: () {
                            controller.selectValue(e);
                            controller.toggleExpansion();
                          },
                          child: Container(
                            width: 85.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: controller.selectedValue.value == e
                                  ? Colors.blue.shade200
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: CommonViews().customText(
                                  textContent: e,
                                  textColor: controller.selectedValue.value == e
                                      ? Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor
                                      : Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).toList(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

