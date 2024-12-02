// ignore_for_file: must_be_immutable

import 'package:jo_students/check_user/check_user_controller.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/lessons_controller/lessons_controller.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/selected_semester_controller.dart';
import 'package:jo_students/screens/end_drawer/subscription_end_drawer/subscription_card_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'specific_lessons_card/specific_lesson_card.dart';
import 'specific_subject_book/specific_books_controller.dart';
import 'specific_subject_test/specific_test_controller.dart';
import 'specific_subject_video/specific_video_controller.dart';
import 'specific_subject_workbooks/specific_workbooks_controller.dart';
import 'specific_subject_workbooks/workbook_details.dart';

class SpecificSubjectScreen extends StatefulWidget {
  int subjectID;
  RxInt? selectedIndexOut;

  SpecificSubjectScreen(
      {super.key, required this.subjectID, this.selectedIndexOut});

  @override
  State<SpecificSubjectScreen> createState() => _SpecificSubjectScreenState();
}

class _SpecificSubjectScreenState extends State<SpecificSubjectScreen> {
  final SubjectNameByIdController controller =
      Get.put(SubjectNameByIdController());

  @override
  void initState() {
    super.initState();
    controller.fetchSubjectNameById(subjectId: widget.subjectID);
  }

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
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Container(
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 10, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 22,
                                    backgroundImage: AssetImage(avatarImage),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonViews().customText(
                                        textContent: 'المعلم',
                                        fontSize: 10.sp,
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                      CommonViews().customText(
                                          textContent:
                                              controller.teacherName.value,
                                          fontSize: 10.sp,
                                          textColor: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color,
                                          fontWeight: FontWeight.w700),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CommonViews().customText(
                                    textContent: controller.subjectName.value,
                                    fontSize: 18.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                  ),
                                  SizedBox(width: 3.w),
                                  Container(
                                    width: 10.w,
                                    height: 5.h,
                                    color: parseColor(
                                        controller.subjectColor.value),
                                    child: Center(
                                      child: CachedNetworkImage(
                                        imageUrl: controller.icon.value,
                                        color: Colors.white,
                                        width: 8.w,
                                        height: 5.h,
                                        fit: BoxFit.fitWidth,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        CommonViews().customText(
                            textContent: 'اختر الفصل الدراسي         ',
                            textColor:
                                Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500),
                        SelectedSpecificWidget(
                          subjectId: widget.subjectID,
                          selectedIndexOut: widget.selectedIndexOut,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color parseColor(String colorString) {
    if (colorString.isEmpty ||
        (!colorString.startsWith('#') &&
            colorString.length != 7 &&
            colorString.length != 9)) {
      return Colors.black; // Default color for invalid input
    }
    colorString = colorString.replaceFirst('#', "0xff");
    try {
      return Color(int.parse(colorString));
    } catch (e) {
      return Colors.black;
    }
  }
}

class SelectedSpecificWidget extends StatefulWidget {
  final int subjectId;
  RxInt? selectedIndexOut;

  SelectedSpecificWidget(
      {super.key, required this.subjectId, this.selectedIndexOut});

  @override
  State<SelectedSpecificWidget> createState() => _SelectedSpecificWidgetState();
}

class _SelectedSpecificWidgetState extends State<SelectedSpecificWidget> {
  final BooksBySubjectIdController controllerBooks =
      Get.put(BooksBySubjectIdController());

  final SelectedSemesterController controller =
      Get.put(SelectedSemesterController());

  final BooksVideoController controllerVideo = Get.put(BooksVideoController());

  final WorkBooksController controllerWorkBooks =
      Get.put(WorkBooksController());

  final BooksTestController controllerBooksTest =
      Get.put(BooksTestController());
  final checkUser = Get.find<CheckUserController>();

  late SelectedSpecificController specificController;

  @override
  void initState() {
    super.initState();
    _loadData();
    if (Get.isRegistered<SelectedSpecificController>()) {
      Get.delete<SelectedSpecificController>();
    }

    if (widget.selectedIndexOut != null) {
      specificController = Get.put(SelectedSpecificController(
          selectedIndexOut: RxInt(widget.selectedIndexOut!.toInt())));
    } else {
      specificController = Get.put(SelectedSpecificController());
    }
  }

  void _loadData() async {
    String loginTrx = await General.getPrefString(ConstantValues.MSG, "");
    controllerBooks.checkUser(loginTrx: loginTrx, subjectID: widget.subjectId);
    controllerVideo.checkUser(loginTrx: loginTrx, subjectID: widget.subjectId);
    controllerBooksTest.checkUser(
        loginTrx: loginTrx, subjectID: widget.subjectId);
    await controllerWorkBooks.initController();
    controllerWorkBooks.fetchWorkBooksFromApi(subjectId: widget.subjectId);
  }

  @override
  void dispose() {
    Get.delete<BooksBySubjectIdController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Obx(
            () => Container(
              width: 85.w,
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
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_down,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        size: 22),
                    const Spacer(),
                    CommonViews().customText(
                      textContent: controller.selectedValue.value,
                      textColor: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Obx(
            () => controller.isExpanded.value
                ? Container(
                    width: 85.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),
                    child: Column(
                      children: SelectedSemesterController.semesterList
                          .map(
                            (e) => InkWell(
                              onTap: () {
                                controller.selectValue(
                                    value: e,
                                    allowPop:
                                        controller.selectedValue.value == e
                                            ? false
                                            : true);
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
                                        textColor:
                                            controller.selectedValue.value == e
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
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 8),
          Container(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIcon(
                      icon: Image.asset(
                        fourMenuImage,
                        width: 10.w,
                      ),
                      index: 0,
                    ),
                    _buildIcon(
                      icon: Image.asset(fiveMenuImage, width: 10.w),
                      index: 1,
                    ),
                    _buildIcon(
                      icon: const Icon(Icons.play_circle_outline),
                      index: 2,
                    ),
                    _buildIcon(
                      icon: Image.asset(towMenuImage, width: 10.w),
                      index: 3,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildContent(),
                const SizedBox(height: 8),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _booksView() {
    return Obx(() {
      if (controllerBooks.isLoading) {
        return _getLoadingView();
      }
      if (controllerBooks.isError) {
        return Center(
          child: CommonViews().customText(
            textContent: "An Error Occurred While Fetching Subject",
            withFontFamily: false,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: 13.sp,
          ),
        );
      }
      if (controllerBooks.isEmpty) {
        return Center(
          child: CommonViews().customText(
            textContent: "!! لا يوجد مواد ليتم عرضها",
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: 15.sp,
          ),
        );
      }
      if (controllerBooks.isSuccess) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color:
                  Theme.of(context).textTheme.bodySmall!.color ?? Colors.black,
            ),
          ),
          child: Column(
            children: controllerBooks.booksBySubjectIdResponse.map((item) {
              return GestureDetector(
                onTap: () {
                  final bool isSubscribed = checkUser.isSubscription.value == 0;
                  if (isSubscribed) {
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
                                        General.savePrefInt(
                                            ConstantValues.selectedIndexKey, 8);
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
                  } else {
                    AppNavigator.of(context).push(SpecificLessonDetailsCard(
                      subjectID: widget.subjectId,
                      bookID: int.parse(item.bookId),
                    ));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CommonViews().customText(
                                textContent: item.bookTitle,
                                fontSize: 11.sp,
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.normal,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          const CircleAvatar(
                            backgroundImage: AssetImage(bookIcon),
                            backgroundColor: Colors.transparent,
                            radius: 20,
                          ),
                          SizedBox(width: 4.w),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }
      return const SizedBox();
    });
  }

  Widget _booksVideo() {
    return Obx(() {
      if (controllerVideo.isLoading) {
        return _getLoadingView();
      }
      if (controllerVideo.isError) {
        return Center(
          child: CommonViews().customText(
            textContent: "An Error Occurred While Fetching Subject",
            withFontFamily: false,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: 13.sp,
          ),
        );
      }
      if (controllerVideo.isEmpty) {
        return Center(
          child: CommonViews().customText(
            textContent: "!! لا يوجد مواد ليتم عرضها",
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: 15.sp,
          ),
        );
      }
      if (controllerVideo.isSuccess) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color:
                  Theme.of(context).textTheme.bodySmall!.color ?? Colors.black,
            ),
          ),
          child: Column(
            children: controllerVideo.booksVideoResponse.map((item) {
              return GestureDetector(
                onTap: () {
                  final bool isSubscribed = checkUser.isSubscription.value == 0;
                  if (isSubscribed) {
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
                                        General.savePrefInt(
                                            ConstantValues.selectedIndexKey, 8);
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
                  } else {
                    AppNavigator.of(context).push(SpecificLessonDetailsCard(
                      subjectID: widget.subjectId,
                      bookID: int.parse(item.bookId),
                    ));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CommonViews().customText(
                                textContent: item.bookTitle,
                                fontSize: 11.sp,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.normal,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          const CircleAvatar(
                            backgroundImage: AssetImage(videoIcon),
                            backgroundColor: Colors.transparent,
                            radius: 20,
                          ),
                          SizedBox(width: 4.w),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }
      return const SizedBox();
    });
  }

  Widget _workBooks() {
    return Obx(() {
      if (controllerWorkBooks.isLoading) {
        return _getLoadingView();
      }
      if (controllerWorkBooks.isError) {
        return Center(
          child: CommonViews().customText(
            textContent:
            "An Error Occurred Make Sure You Are Connected To The Internet",
            withFontFamily: false,
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 11.sp,
          ),
        );
      }
      if (controllerWorkBooks.isEmpty) {
        return Center(
          child: CommonViews().customText(
            textContent: "!! لا يوجد مواد ليتم عرضها",
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: 15.sp,
          ),
        );
      }
      if (controllerWorkBooks.isSuccess) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color:
                  Theme.of(context).textTheme.bodySmall!.color ?? Colors.black,
            ),
          ),
          child: Column(
            children: controllerWorkBooks.workBooksResponse.map((item) {
              return GestureDetector(
                onTap: () {
                  final bool isSubscribed = checkUser.isSubscription.value == 0;
                  if (isSubscribed) {
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
                                        General.savePrefInt(
                                            ConstantValues.selectedIndexKey, 8);
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
                  } else {
                    AppNavigator.of(context).push(WorkbookDetails(
                      subjectID: widget.subjectId,
                      bookID: int.parse(item.bookId),
                    ));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CommonViews().customText(
                                textContent: item.bookTitle,
                                fontSize: 13.sp,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.normal,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          const CircleAvatar(
                            backgroundImage: AssetImage(examIcon),
                            backgroundColor: Colors.transparent,
                            radius: 20,
                          ),
                          SizedBox(width: 4.w),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }
      return const SizedBox();
    });
  }

  Widget _booksTest() {
    return Obx(() {
      if (controllerBooksTest.isLoading) {
        return _getLoadingView();
      }
      if (controllerBooksTest.isError) {
        return Center(
          child: CommonViews().customText(
            textContent:
                "An Error Occurred Make Sure You Are Connected To The Internet",
            withFontFamily: false,
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 11.sp,
          ),
        );
      }
      if (controllerBooksTest.isEmpty) {
        return Center(
          child: CommonViews().customText(
            textContent: "!! لا يوجد مواد ليتم عرضها",
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: 15.sp,
          ),
        );
      }
      if (controllerBooksTest.isSuccess) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color:
                  Theme.of(context).textTheme.bodySmall!.color ?? Colors.black,
            ),
          ),
          child: Column(
            children: controllerBooksTest.booksTestResponse.map((item) {
              return GestureDetector(
                onTap: () {
                  //todo Navigate to Test Details
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: CommonViews().customText(
                                    textContent: item.examTItle,
                                    fontSize: 13.sp,
                                    withFontFamily: false,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: CommonViews().customText(
                                    textContent: item.examDescription,
                                    fontSize: 12.sp,
                                    withFontFamily: false,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: CommonViews().customText(
                                    textContent:
                                        "مدة الأمتحان:${item.examPeriod} دقيقة-عدد الأسئلة:${item.numberOfQuestions}",
                                    fontSize: 11.sp,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 3.w),
                          const CircleAvatar(
                            backgroundImage: AssetImage(examIcon),
                            backgroundColor: Colors.transparent,
                            radius: 20,
                          ),
                          SizedBox(width: 4.w),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }
      return const SizedBox();
    });
  }

  Widget _getLoadingView() {
    return const Center(
      child: SpinKitCircle(
        color: AppColors.backGroundColor,
        size: 50.0,
      ),
    );
  }

  Widget _buildIcon({
    required Widget icon,
    required int index,
  }) {
    return Obx(
      () {
        bool isSelected = specificController.selectedIndex.value == index;
        return InkWell(
          onTap: () {
            specificController.updateSelectedIndex(index);
          },
          child: Column(
            children: [
              if (icon is Image)
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? const Color(0xff7367f0)
                        : Theme.of(context).textTheme.bodyLarge!.color ??
                            Colors.black,
                    BlendMode.srcIn,
                  ),
                  child: icon,
                )
              else
                IconTheme(
                  data: IconThemeData(
                    color: isSelected
                        ? const Color(0xff7367f0)
                        : Theme.of(context).textTheme.bodyLarge!.color ??
                            Colors.black,
                    size: 24,
                  ),
                  child: icon,
                ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 30,
                  height: 2,
                  color: const Color(0xff7367f0),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return Obx(() {
      switch (specificController.selectedIndex.value) {
        case 0:
          return _booksTest();
        case 1:
          return _workBooks();
        case 2:
          return _booksVideo();
        case 3:
          return _booksView();
        default:
          return Container();
      }
    });
  }
}

class SelectedSpecificController extends GetxController {
  RxInt? selectedIndexOut;
  late RxInt selectedIndex;

  SelectedSpecificController({this.selectedIndexOut});

  @override
  void onInit() {
    super.onInit();
    selectedIndex = (selectedIndexOut?.value ?? 3).obs;
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
