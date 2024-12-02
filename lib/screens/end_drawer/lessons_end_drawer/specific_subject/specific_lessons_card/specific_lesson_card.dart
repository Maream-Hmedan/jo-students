// ignore_for_file: must_be_immutable
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/reviews_end_drawer/reviews_screen.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/specific_subject/specific_subject_book/specific_books_controller.dart';
import 'package:jo_students/screens/end_drawer/reviews_end_drawer/my_reviews_list/my_reviews_controller.dart';
import 'package:jo_students/screens/like_dislike/interactive_controller.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:ui' as ui;
import 'specific_lessons_card_controller.dart';

class SpecificLessonDetailsCard extends StatefulWidget {
  int bookID;
  int subjectID;

  SpecificLessonDetailsCard(
      {super.key, required this.subjectID, required this.bookID});

  @override
  State<SpecificLessonDetailsCard> createState() =>
      _SpecificLessonDetailsCardState();
}

class _SpecificLessonDetailsCardState extends State<SpecificLessonDetailsCard> {
  final SpecificCardDetailsController specificCardDetailsController =
      Get.put(SpecificCardDetailsController());

  final BooksBySubjectIdController booksBySubjectIdController =
      Get.put(BooksBySubjectIdController());

  final InterActiveController interactiveController =
      Get.put(InterActiveController());

  bool _isExpanded = true;

  final MyReviewsController myReviewsController =
      Get.put(MyReviewsController());

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _initializeData();
  }

  Future<void> _initializeData() async {
    await specificCardDetailsController.initController();
    specificCardDetailsController.fetchDetailsCard(
      bookId: widget.bookID,
      subjectId: widget.subjectID,
    );
  }

  String _incrementNumber(String value) {
    int? parsedValue = int.tryParse(value);
    if (parsedValue != null) {
      return (parsedValue + 1).toString();
    } else {
      return "Invalid number";
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Get.delete<SpecificCardDetailsController>();
    super.dispose();
  }

  void refreshPage(int newBookID, int newSubjectID) {
    Get.delete<SpecificCardDetailsController>();
    widget.bookID = newBookID;
    specificCardDetailsController.fetchDetailsCard(
      bookId: newBookID,
      subjectId: newSubjectID,
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
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.9),
                        child: CommonViews().customText(
                          textContent:
                              '${specificCardDetailsController.subjectName.value}:الدرس',
                          fontSize: 12.sp,
                          overflow: TextOverflow.visible,
                          maxLines: 3,
                          textAlign: TextAlign.right,
                          textColor:
                              Theme.of(context).textTheme.bodyLarge!.color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CommonViews().customText(
                        textContent:
                            ' ${specificCardDetailsController.bookName.value} - ${specificCardDetailsController.semester.value}',
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
                                  ' إعداد : ${specificCardDetailsController.teacherName}',
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
                            context: context,
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
                            context: context,
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
                            context: context,
                          ),
                          SizedBox(width: 1.w),
                          iconWidget(
                              icon: const Icon(Icons.bookmarks_outlined),
                              color: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .color,
                              label: 'حفظ',
                              onPressed: () {
                                addReviewListPopup(
                                    context: context, bookId: widget.bookID);
                              },
                              context: context),
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
                                      '${specificCardDetailsController.grade}',
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
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.black26)),
                  child: Obx(() {
                    if (specificCardDetailsController.isLoading) {
                      return const Center(
                        child: SpinKitCircle(
                          color: AppColors.backGroundColor,
                          size: 50.0,
                        ),
                      );
                    }
                    if (specificCardDetailsController.isError) {
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
                    if (specificCardDetailsController.isSuccess) {
                      return Obx(() => SizedBox(
                            // Set the width and height dynamically based on the content
                            width: specificCardDetailsController
                                .contentWidth.value,
                            height: specificCardDetailsController
                                .contentHeight.value,
                            child: WebViewWidget(
                              controller: specificCardDetailsController
                                  .webViewController.value!,
                              gestureRecognizers: {
                                Factory<VerticalDragGestureRecognizer>(
                                  () => VerticalDragGestureRecognizer(),
                                ),
                                Factory<HorizontalDragGestureRecognizer>(
                                  () => HorizontalDragGestureRecognizer(),
                                ),
                              },
                            ),
                          ));
                    }

                    return Container();
                  }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(8),
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
                                  : const Icon(Icons.add),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CommonViews().customText(
                                    textContent: 'الدروس',
                                    fontSize: 14.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontWeight: FontWeight.normal),
                                CommonViews().customText(
                                    textContent: _incrementNumber(
                                        specificCardDetailsController
                                            .numberOfOther.value),
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
                            ...booksBySubjectIdController
                                .booksBySubjectIdResponse
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              var item = entry.value;
                              return Column(
                                children: [
                                  SizedBox(height: 1.h),
                                  GestureDetector(
                                    onTap: () {
                                      refreshPage(int.parse(item.bookId),
                                          widget.subjectID);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 5.w),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: CommonViews().customText(
                                              textContent: item.bookTitle,
                                              fontSize: 12.sp,
                                              maxLines: 2,
                                              overflow: TextOverflow.visible,
                                              fontWeight: FontWeight.normal,
                                              textColor:
                                                  widget.bookID.toString() ==
                                                          item.bookId
                                                      ? const Color(0xFF7367F0)
                                                      : Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .color,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          ' - ${index + 1}',
                                          style: TextStyle(
                                            color: const Color(0xFF7367F0),
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                ],
                              );
                            }),
                          ],
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

  Column iconWidget(
      {required Icon icon,
      required String label,
      required BuildContext context,
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

  void addReviewListPopup({required BuildContext context, required bookId}) {
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
                child: ReviewListViewPopup(
                  bookID: bookId,
                )),
            Positioned(
              top: 2.h,
              left: 3.h,
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
                      color: Theme.of(context).textTheme.titleMedium!.color,
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

class ReviewListViewPopup extends StatefulWidget {
  int bookID;

  ReviewListViewPopup({super.key, required this.bookID});

  @override
  State<ReviewListViewPopup> createState() => _ReviewListViewPopupState();
}

class _ReviewListViewPopupState extends State<ReviewListViewPopup> {
  final DateFormat formatter = DateFormat('HH:mm:ss dd/MM/yyyy');
  final myReviewsController = Get.find<MyReviewsController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).appBarTheme.backgroundColor,
        ),
        width: 100.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            _myReviewsView(),
            SizedBox(height: 4.h),
            CommonViews().customClickableContainer(
                onTap: () {
                  AppNavigator.of(context).pop();
                },
                radius: 5,
                width: 20.w,
                colorBorder: Colors.transparent,
                color: Theme.of(context).textTheme.titleSmall!.color,
                child: Center(
                  child: CommonViews().customText(
                    textContent: 'اغلاق',
                    fontSize: 12.sp,
                    textColor: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _myReviewsView() {
    return Obx(() {
      if (myReviewsController.isLoading) {
        return _getLoadingView();
      }
      if (myReviewsController.isError) {
        return Center(
          child: CommonViews().customText(
            textContent: "An Error Occurred While Fetching Reviews",
            withFontFamily: false,
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 13.sp,
          ),
        );
      }
      if (myReviewsController.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: CommonViews().customText(
                textContent: "اختر قائمة",
                fontWeight: FontWeight.w600,
                textColor: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .color,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 1.h,),
            Image.asset(
              emptyReview,
              height: 10.h,
              width: 40.w,
              fit: BoxFit.fill,
            ),
            CommonViews().customText(
              textContent: "لا توجد اي قوائم",
              fontWeight: FontWeight.w300,
              textColor:Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .color,
              fontSize: 10.sp,
            ),
            SizedBox(height: 3.h,),
            CommonViews().customClickableText(
              onTap: (){
                AppNavigator.of(context).pushAndRemoveUntil(const ReviewsScreen());
                _saveSelectedItem(4);
              },
              textContent: "إضافة قائمة جديدة",
              fontWeight: FontWeight.w300,
              textColor:  const Color(0xff7367f0),
              fontSize: 13.sp,
            ),
          ],
        );
      }
      if (myReviewsController.isSuccess) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Theme.of(context).textTheme.bodySmall!.color ??
                    Colors.black,
              ),
            ),
            child: Column(
              children: List.generate(
                myReviewsController.myReviews.length,
                (index) {
                  final item = myReviewsController.myReviews[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await myReviewsController.addBookToReviewFromApi(
                              bookID: widget.bookID, listID: item.listHId);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 1.w,
                              ),
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage(addMenuReviewsImage),
                                backgroundColor: Colors.transparent,
                                radius: 20,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonViews().customText(
                                    textContent: item.listHTitle,
                                    fontSize: 13.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .color,
                                  ),
                                  Row(
                                    children: [
                                      CommonViews().customText(
                                        textContent: "عدد الدروس:",
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .color,
                                      ),
                                      CommonViews().customText(
                                        textContent: item.booksCount,
                                        withFontFamily: false,
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .color,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CommonViews().customText(
                                        textContent: "تاريخ الإنشاء:",
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .color,
                                      ),
                                      CommonViews().customText(
                                        textContent: formatter.format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(item.createdDt))),
                                        withFontFamily: false,
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .color,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (index < myReviewsController.myReviews.length - 1)
                        Divider(
                          color: Theme.of(context).textTheme.bodySmall!.color ??
                              Colors.black,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      }
      // if (myReviewsController.isSuccess) {
      //   return Directionality(
      //     textDirection: ui.TextDirection.rtl,
      //     child: Column(
      //       children: myReviewsController.myReviews.map((item) {
      //         return GestureDetector(
      //           onTap: () async {
      //           await  myReviewsController.addBookToReviewFromApi(bookID: widget.bookID,
      //                 listID: item.listHId);
      //           },
      //           child: Container(
      //             width:100.w,
      //             height: 15.h,
      //             padding: const EdgeInsets.all(8),
      //             decoration: BoxDecoration(
      //               border: Border.all(
      //                 color: Theme.of(context).textTheme.bodySmall!.color ??
      //                     Colors.black,
      //               ),
      //             ),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 const CircleAvatar(
      //                   backgroundImage: AssetImage(addMenuReviewsImage),
      //                   backgroundColor: Colors.transparent,
      //                   radius: 18,
      //                 ),
      //                 SizedBox(
      //                   width: 2.w,
      //                 ),
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     CommonViews().customText(
      //                       textContent: item.listHTitle,
      //                       fontSize: 12.sp,
      //                       textColor:
      //                       Theme.of(context).textTheme.titleLarge!.color,
      //                     ),
      //                     Row(
      //                       children: [
      //                         CommonViews().customText(
      //                           textContent: "عدد الدروس:",
      //                           textColor:
      //                           Theme.of(context).textTheme.titleLarge!.color,
      //                         ),
      //                         CommonViews().customText(
      //                           textContent: item.booksCount,
      //                           withFontFamily: false,
      //                           overflow: TextOverflow.visible,
      //                           maxLines: 2,
      //                           textColor:
      //                           Theme.of(context).textTheme.titleLarge!.color,
      //                         ),
      //                       ],
      //                     ),
      //                     Row(
      //                       children: [
      //                         CommonViews().customText(
      //                           textContent: "تاريخ الإنشاء:",
      //                           textColor:
      //                           Theme.of(context).textTheme.titleLarge!.color,
      //                         ),
      //                         CommonViews().customText(
      //                           textContent: formatter.format(
      //                               DateTime.fromMillisecondsSinceEpoch(
      //                                   int.parse(item.createdDt))),
      //                           withFontFamily: false,
      //                           overflow: TextOverflow.visible,
      //                           maxLines: 2,
      //                           textColor:
      //                           Theme.of(context).textTheme.titleLarge!.color,
      //                         ),
      //                       ],
      //                     ),
      //
      //                   ],
      //                 ),
      //
      //               ],
      //             ),
      //           ),
      //         );
      //       }).toList(),
      //     ),
      //   );
      // }
      return Container();
    });
  }
  Future<void> _saveSelectedItem(int index) async {
    General.savePrefInt(ConstantValues.selectedIndexKey, index);
  }
  Widget _getLoadingView() {
    return const Center(
      child: SpinKitCircle(
        color: Color(0xff7367f0),
        size: 50.0,
      ),
    );
  }
}
