// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/curriculums/curriculums_controller.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import 'selected_semester_controller.dart';
import 'specific_subject/specific_subject_screen.dart';

class LessonsCard extends StatelessWidget {
  RxInt? selectedIndexOut;

  LessonsCard({super.key, this.selectedIndexOut});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        endDrawer: const EndDrawerView(),
        appBar: CustomProfileAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 80.h,
                  width: 100.w,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonViews().customText(
                              textContent: 'الدروس',
                              textColor:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                          Transform.scale(
                            scale: 0.5,
                            child: Image.asset(
                              towMenuImage,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                      CommonViews().customText(
                          textContent: 'اختر الفصل الدراسي         ',
                          textColor:
                              Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                      SelectedSemesterWidget(
                        selectedIndexOut: selectedIndexOut,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedSemesterWidget extends StatelessWidget {
  RxInt? selectedIndexOut;

  SelectedSemesterWidget({super.key, this.selectedIndexOut});

  final CurriculumsController controllerCurriculums =
      Get.find<CurriculumsController>();
  final SelectedSemesterController controller =
      Get.put(SelectedSemesterController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: 100.w,
          child: Stack(
            children: [
              SizedBox(
                width: 100.w,
                height: 60.h,
              ),
              Obx(() => Positioned(
                    top: 0,
                    child: Container(
                      width: 85.w,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: controller.isExpanded.value
                              ? const Color(0xff7367f0)
                              : Colors.grey,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          controller.toggleExpansion();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.keyboard_arrow_down,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                size: 22),
                            const Spacer(),
                            CommonViews().customText(
                              textContent: controller.selectedValue.value,
                              textColor:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Positioned(
                top: 10.h,
                child: Container(
                  width: 85.w,
                  padding: const EdgeInsets.all(8),
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
                  child: Column(
                    children: [
                      const Icon(
                        Icons.home_outlined,
                        color: Color(0xff7367f0),
                        size: 20,
                      ),
                      const Divider(color: Color(0xff7367f0), thickness: 2),
                      SizedBox(height: 2.h),
                      Obx(
                        () => controller.selectedValue.value == 'الفصل الاول'
                            ? _curriculumsView(
                                selectedIndexOut: selectedIndexOut)
                            : _buildListItem(
                                icon: Icons.calculate,
                                label: 'الرياضيات',
                                color: Colors.orange,
                                context: context,
                                link: Container(),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => controller.isExpanded.value
                  ? Positioned(
                      top: 5.h,
                      child: Container(
                        width: 85.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Colors.grey.shade300, width: 2),
                        ),
                        child: Column(
                          children: SelectedSemesterController.semesterList
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    controller.selectValue(
                                        value: e, allowPop: false);
                                  },
                                  child: Container(
                                    width: 85.w,
                                    decoration: BoxDecoration(
                                      color: controller.selectedValue.value == e
                                          ? Colors.blue.shade200
                                          : Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .color,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: CommonViews().customText(
                                            textContent: e,
                                            textColor: controller
                                                        .selectedValue.value ==
                                                    e
                                                ? Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .color,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _curriculumsView({RxInt? selectedIndexOut}) {
    if (controllerCurriculums.isLoading) {
      return _getShimmerView();
    }
    if (controllerCurriculums.isError) {
      return Center(
        child: CommonViews().customText(
          textContent: "An Error Occurred While Fetching Subject",
          withFontFamily: false,
          fontWeight: FontWeight.w600,
          textColor: Colors.black,
          fontSize: 13.sp,
        ),
      );
    }
    if (controllerCurriculums.isEmpty) {
      return Center(
        child: CommonViews().customText(
          textContent: "!! لا يوجد مواد ليتم عرضها",
          fontWeight: FontWeight.w600,
          textColor: Colors.black,
          fontSize: 15.sp,
        ),
      );
    }
    if (controllerCurriculums.isSuccess) {
      return Column(
          children: controllerCurriculums.curriculums.map((item) {
        return GestureDetector(
          onTap: () {
            AppNavigator.of(Get.context!).push(SpecificSubjectScreen(
              subjectID: item.subjectId,
              selectedIndexOut: selectedIndexOut,
            ));
          },
          child: Container(
            width: MediaQuery.of(Get.context!).size.width,
            height: 10.h,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
              color: parseColor(item.subjectColor),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: item.subjectIconHref.isNotEmpty
                      ? item.subjectIconHref
                      : '',
                  color: Colors.black,
                  width: 12.w,
                  height: 3.h,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                SizedBox(height: 1.h),
                CommonViews().customText(
                  textContent: item.subjectTitleAr,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        );
      }).toList());
    }
    return Container();
  }

  Color parseColor(String colorString) {
    colorString = colorString.replaceFirst('#', "0xff");
    return Color(int.parse(colorString));
  }

  Widget _getShimmerView() {
    return SizedBox(
      width: double.infinity,
      height: 13.h * 4,
      child: Column(
        children: List.generate(4, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300] ?? Colors.grey,
            highlightColor: Colors.grey[100] ?? Colors.white,
            child: Container(
              width: double.infinity,
              height: 10.h,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String label,
    required Color color,
    required BuildContext context,
    required Widget link,
  }) {
    return CommonViews().customClickableContainer(
      onTap: () {},
      color: color.withOpacity(0.7),
      height: 10.h,
      width: 100.w,
      radius: 5,
      margin: const EdgeInsets.all(8),
      colorBorder: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(height: 1.h),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
