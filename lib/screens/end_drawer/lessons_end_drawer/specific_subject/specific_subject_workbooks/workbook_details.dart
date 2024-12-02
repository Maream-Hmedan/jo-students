// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/specific_subject/specific_lessons_card/specific_lesson_card.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/specific_subject/specific_subject_book/specific_books_controller.dart';
import 'package:jo_students/screens/like_dislike/interactive_controller.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'specific_workbooks_controller.dart';

class WorkbookDetails extends StatefulWidget {
  int subjectID;
  int bookID;

  WorkbookDetails({super.key, required this.subjectID, required this.bookID});

  @override
  State<WorkbookDetails> createState() => _WorkbookDetailsState();
}

final WorkBooksController workBooksDetailsController =
    Get.put(WorkBooksController());

final BooksBySubjectIdController booksBySubjectIdController =
Get.find<BooksBySubjectIdController>();

final InterActiveController interactiveController =
    Get.put(InterActiveController());
bool _isExpanded = true;
bool _isExpanded2 = false;

class _WorkbookDetailsState extends State<WorkbookDetails> {
  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    workBooksDetailsController.fetchWorkBooksDetailsFromApi(
        bookID: widget.bookID, subjectID: widget.subjectID);
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  }
  void refreshPage(int newBookID, int newSubjectID) {
    widget.bookID = newBookID;
    workBooksDetailsController.fetchWorkBooksDetailsFromApi(
      bookID: newBookID,
      subjectID: newSubjectID,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        endDrawer: const EndDrawerView(),
        appBar: CustomProfileAppBar(),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                SizedBox(height: 1.h),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
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
                          textContent:
                              '${workBooksDetailsController.bookSubTitle.value} : ورقة العمل',
                          fontSize: 13.sp,
                          textColor:
                              Theme.of(context).textTheme.bodyLarge!.color,
                          fontWeight: FontWeight.w700),
                      CommonViews().customText(
                        textContent:
                            ' ${workBooksDetailsController.bookName.value} - ${workBooksDetailsController.semester.value}',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                        textColor: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xff7367f0).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: CommonViews().customText(
                              textContent:
                                  ' إعداد : ${workBooksDetailsController.teacherName}',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.normal,
                              textColor: const Color(0xff7367f0))),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          iconWidget(
                            icon: const Icon(Icons.arrow_back),
                            label: 'رجوع',
                            onPressed: () {
                              AppNavigator.of(context).pop();
                            },
                          ),
                          SizedBox(width: 1.w),
                          iconWidget(
                            icon: interactiveController.isDisliked(
                                    widget.bookID, widget.subjectID)
                                ? const Icon(Icons.thumb_down_alt_sharp)
                                : const Icon(Icons.thumb_down_alt_outlined),
                            label: 'لم يعجبني',
                            onPressed: () {
                              interactiveController.addDisLike(
                                  bookId: widget.bookID);
                            },
                          ),
                          SizedBox(width: 1.w),
                          iconWidget(
                            icon: interactiveController.isLiked(widget.bookID)
                                ? const Icon(Icons.thumb_up_alt_sharp)
                                : const Icon(Icons.thumb_up_alt_outlined),
                            label: 'أعجبني',
                            onPressed: () {
                              interactiveController.addLike(
                                  bookId: widget.bookID);
                            },
                          ),
                          SizedBox(width: 1.w),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CommonViews().customText(
                                  textContent:
                                      '${workBooksDetailsController.grade}',
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.normal,
                                  textColor: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  height: 30.h,
                  decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.black26)),
                  child: Obx(() {
                    if (workBooksDetailsController.isLoading) {
                      return const Center(
                        child: SpinKitCircle(
                          color: AppColors.backGroundColor,
                          size: 50.0,
                        ),
                      );
                    }
                    if (workBooksDetailsController.isError) {
                      return Center(
                        child: CommonViews().customText(
                          textContent:
                          "An Error Occurred While Fetching Subject",
                          withFontFamily: false,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black,
                          fontSize: 13.sp,
                        ),
                      );
                    }
                    if (workBooksDetailsController.isSuccess) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: WebViewWidget(
                            controller:  workBooksDetailsController.webViewController.value!,
                            gestureRecognizers: {
                              Factory<VerticalDragGestureRecognizer>(
                                    () => VerticalDragGestureRecognizer(),
                              ),
                              Factory<HorizontalDragGestureRecognizer>(
                                    () => HorizontalDragGestureRecognizer(),
                              ),
                            }, // Enable vertical scrolling
                          ),
                        ),
                      );

                    }
                    return Container();
                  }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      right: 8, left: 8, top: 8, bottom: 8),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                icon: _isExpanded
                                    ? const Icon(Icons.minimize)
                                    : const Icon(Icons.add)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CommonViews().customText(
                                    textContent: 'اوراق العمل',
                                    fontSize: 14.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontWeight: FontWeight.normal),
                                CommonViews().customText(
                                    textContent: workBooksDetailsController.workBooksResponse.length.toString(),
                                    fontSize: 11.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    withFontFamily: false,
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (_isExpanded)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Divider(),
                            ...workBooksDetailsController.workBooksResponse
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              var item = entry.value;
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      refreshPage(int.parse(item.bookId),
                                          widget.subjectID);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          item.bookTitle,
                                          style: TextStyle(
                                            color: widget.bookID.toString() ==
                                                    item.bookId
                                                ? const Color(0xFF7367F0)
                                                : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          ' - ${index + 1}',
                                          style: TextStyle(
                                            color: const Color(0xFF7367F0),
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              );
                            }),
                          ],
                        )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      right: 8, left: 8, top: 0, bottom: 8),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isExpanded2 = !_isExpanded2;
                                  });
                                },
                                icon: _isExpanded2
                                    ? const Icon(Icons.minimize)
                                    : const Icon(Icons.add)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CommonViews().customText(
                                    textContent: 'الدروس ',
                                    fontSize: 14.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontWeight: FontWeight.normal),
                                CommonViews().customText(
                                  textContent: booksBySubjectIdController
                                      .booksBySubjectIdResponse.length
                                      .toString(),
                                  fontSize: 11.sp,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  withFontFamily: false,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (_isExpanded2)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Divider(),
                            ...booksBySubjectIdController
                                .booksBySubjectIdResponse
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              var item = entry.value;
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppNavigator.of(context).push(SpecificLessonDetailsCard(
                                        subjectID: widget.subjectID,
                                        bookID: int.parse(item.bookId),
                                      ));
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          item.bookTitle,
                                          style: TextStyle(
                                            color: widget.bookID.toString() ==
                                                    item.bookId
                                                ? const Color(0xFF7367F0)
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .color,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          ' - ${index + 1}',
                                          style: TextStyle(
                                            color: const Color(0xFF7367F0),
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              );
                            }),
                          ],
                        )
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

  Column iconWidget(
      {required Icon icon,
      required String label,
      Color? color,
      required VoidCallback onPressed}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: icon,
          color: color ?? const Color(0xff7367f0),
          iconSize: 24,
          onPressed: onPressed,
        ),
        CommonViews().customText(
          textContent: label,
          fontSize: 10.sp,
          textColor: color ?? const Color(0xff7367f0),
        ),
      ],
    );
  }
}
