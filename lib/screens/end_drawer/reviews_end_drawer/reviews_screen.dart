// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';

import 'add_review/add_review_controller.dart';
import 'delete_review/delete_review_controller.dart';
import 'my_reviews_list/my_reviews_controller.dart';
import 'dart:ui' as ui;

import 'review_details/review_details_controller.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final DateFormat formatter = DateFormat('HH:mm:ss dd/MM/yyyy');
  final MyReviewsController myReviewsController =
      Get.put(MyReviewsController());

  final ReviewDetailsController myReviewDetailsController =
      Get.put(ReviewDetailsController());

  final DeleteReviewController myDeleteReviewsController =
      Get.put(DeleteReviewController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const EndDrawerView(),
        appBar: CustomProfileAppBar(),
        body: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: SingleChildScrollView(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonViews().customText(
                                textContent: 'المراجعات',
                                fontSize: 16.sp,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                fontWeight: FontWeight.bold),
                            Transform.scale(
                              scale: 0.6,
                              child: Image.asset(
                                threeMenuImage,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        CommonViews().customText(
                            textContent: 'احفظ درس باستخدام أيقونة المراجعات',
                            fontSize: 13.sp,
                            textColor:
                                Theme.of(context).textTheme.bodyMedium!.color,
                            fontWeight: FontWeight.w400),
                        SizedBox(height: 2.h),
                        CommonViews().customText(
                            textContent:
                                'اختر القائمة أو قم بإنشاء قائمة جديدة',
                            fontSize: 13.sp,
                            textColor:
                                Theme.of(context).textTheme.bodyMedium!.color,
                            fontWeight: FontWeight.w400),
                        SizedBox(height: 2.h),
                        CommonViews().customClickableContainer(
                          onTap: () {
                            addMenuPopup(context);
                          },
                          radius: 5,
                          width: 30.w,
                          color: const Color(0xff7367f0),
                          colorBorder: const Color(0xff7367f0),
                          child: Center(
                            child: CommonViews().customText(
                                textContent: 'أضف قائمة',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Container(
                          width: 100.w,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
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
                              const Divider(
                                  color: Color(0xff7367f0), thickness: 2),
                              _myReviewsView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
            textContent: "An Error Occurred While Fetching Subject",
            withFontFamily: false,
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 13.sp,
          ),
        );
      }
      if (myReviewsController.isEmpty) {
        return const SizedBox.shrink();
      }
      if (myReviewsController.isSuccess) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color:
                  Theme.of(context).textTheme.bodySmall!.color ?? Colors.black,
            ),
          ),
          margin: const EdgeInsets.all(16),
          child: Column(
            children: List.generate(
              myReviewsController.myReviews.length,
              (index) {
                final item = myReviewsController.myReviews[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (int.parse(item.booksCount) > 0) {
                          myReviewDetailsController.fetchReviewDetailsFromApi(
                              listID: item.listHId);
                          deleteReviewInfoPopup(
                            context: context,
                            reviewID: item.listHId,
                            booksCount: item.booksCount,
                            title: item.listHTitle,
                          );
                        } else {
                          deleteReviewPopup(
                            context: context,
                            reviewID: item.listHId,
                            booksCount: item.booksCount,
                          );
                        }
                      },
                      child: Container(
                        width: 100.w,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(addMenuReviewsImage),
                              backgroundColor: Colors.transparent,
                              radius: 24,
                            ),
                            SizedBox(
                              width: 4.w,
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
                                CommonViews().customText(
                                  textContent: item.listHDescription,
                                  fontSize: 11.sp,
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
        );
      }

      return Container();
    });
  }

  Widget _getLoadingView() {
    return const Center(
      child: SpinKitCircle(
        color: Color(0xff7367f0),
        size: 50.0,
      ),
    );
  }

  void deleteReviewInfoPopup({
    required BuildContext context,
    required int reviewID,
    required String booksCount,
    required String title,
  }) {
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
                child: Dialog(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Theme.of(context).appBarTheme.backgroundColor,
                    ),
                    width: 90.w,
                    child:
                        _myReviewDetailsView(reviewID: reviewID, title: title),
                  ),
                )),
            Positioned(
              top: 3.h,
              left: 4.h,
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

  Widget _myReviewDetailsView({required int reviewID, required String title}) {
    return Obx(() {
      if (myReviewDetailsController.isLoading) {
        return _getLoadingView();
      }
      if (myReviewDetailsController.isError) {
        return Center(
          child: CommonViews().customText(
            textContent: "An Error Occurred While Fetching Details",
            withFontFamily: false,
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 13.sp,
          ),
        );
      }
      if (myReviewDetailsController.isEmpty) {
        return const SizedBox.shrink();
      }
      if (myReviewDetailsController.isSuccess) {
        return
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(right: 5.w),
                alignment: Alignment.topRight,
                child: CommonViews().customText(
                  textContent: title,
                  fontSize: 14.sp,
                  textColor: Theme.of(context).textTheme.displayLarge!.color,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: Theme.of(context).textTheme.bodySmall!.color ??
                        Colors.black,
                  ),
                ),
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: List.generate(
                    myReviewDetailsController.myReviewDetails.length,
                    (index) {
                      final item =
                          myReviewDetailsController.myReviewDetails[index];
                      return Column(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CommonViews().customText(
                                    textContent: item.bookTitle,
                                    fontSize: 12.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                  ),
                                  SizedBox(width: 2.w),
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(bookIcon),
                                    backgroundColor: Colors.transparent,
                                    radius: 15,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon:
                                        const Icon(Icons.delete_outline),
                                  ),
                                  SizedBox(width: 2.w),
                                ],
                              ),
                            ],
                          ),
                          if (index <
                              myReviewDetailsController.myReviewDetails.length -
                                  1)
                            Divider(
                              color: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .color ??
                                  Colors.black,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                        textColor:
                            Theme.of(context).textTheme.titleMedium!.color,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  CommonViews().customClickableContainer(
                    onTap: () {
                      AppNavigator.of(context).pop();
                      confirmDeletionReviewPopup(
                          context: context, reviewID: reviewID);
                    },
                    radius: 5,
                    width: 30.w,
                    colorBorder: Colors.transparent,
                    color: const Color(0xffff4c51),
                    child: Center(
                      child: CommonViews().customText(
                        textContent: 'حذف القائمة',
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                ],
              ),
            ],

        );
      }

      return Container();
    });
  }

  void deleteReviewPopup({
    required BuildContext context,
    required int reviewID,
    required String booksCount,
  }) {
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
                child: Dialog(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                      width: 90.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CommonViews().customText(
                            textContent: "لا توجد دروس في هذه القائمة",
                            fontSize: 16.sp,
                            textColor:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CommonViews().customClickableContainer(
                                onTap: () {
                                  AppNavigator.of(context).pop();
                                },
                                radius: 5,
                                width: 20.w,
                                colorBorder: Colors.transparent,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color,
                                child: Center(
                                  child: CommonViews().customText(
                                    textContent: 'اغلاق',
                                    fontSize: 12.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              CommonViews().customClickableContainer(
                                onTap: () {
                                  AppNavigator.of(context).pop();
                                  confirmDeletionReviewPopup(
                                      context: context, reviewID: reviewID);
                                },
                                radius: 5,
                                width: 30.w,
                                colorBorder: Colors.transparent,
                                color: const Color(0xffff4c51),
                                child: Center(
                                  child: CommonViews().customText(
                                    textContent: 'حذف القائمة',
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                            ],
                          ),
                          SizedBox(height: 2.h),
                        ],
                      )),
                )),
            Positioned(
              top: 3.h,
              left: 4.h,
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

  void confirmDeletionReviewPopup({
    required BuildContext context,
    required int reviewID,
  }) {
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
                child: Dialog(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
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
                        CommonViews().customText(
                          textContent: "هل انت متأكد؟",
                          fontSize: 16.sp,
                          textColor:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonViews().customClickableContainer(
                              onTap: () {
                                AppNavigator.of(context).pop();
                              },
                              radius: 5,
                              width: 15.w,
                              colorBorder: Colors.transparent,
                              color:
                                  Theme.of(context).textTheme.titleSmall!.color,
                              child: Center(
                                child: CommonViews().customText(
                                  textContent: 'لا',
                                  fontSize: 12.sp,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                ),
                              ),
                            ),
                            SizedBox(width: 3.w),
                            CommonViews().customClickableContainer(
                              onTap: () async {
                                await myDeleteReviewsController.deleteReview(
                                    txtID: reviewID);
                              },
                              radius: 5,
                              width: 15.w,
                              colorBorder: Colors.transparent,
                              color: const Color(0xffff4c51),
                              child: Center(
                                child: CommonViews().customText(
                                  textContent: 'نعم',
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 3.w),
                          ],
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                )),
            Positioned(
              top: 3.h,
              left: 4.h,
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

class AddMenuPopup extends StatefulWidget {
  const AddMenuPopup({super.key});

  @override
  State<AddMenuPopup> createState() => _AddMenuPopupState();
}

class _AddMenuPopupState extends State<AddMenuPopup> {
  final TextEditingController menuNameController = TextEditingController();

  final TextEditingController menuDescController = TextEditingController();
  final AddReviewController addReviewController =
      Get.put(AddReviewController());
  FocusNode menuNameFocusNode = FocusNode();

  FocusNode menuDescFocusNode = FocusNode();

  final GlobalKey<FormState> _key = GlobalKey();

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
        width: 93.w,
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 2.h),
              CommonViews().customText(
                  textContent: 'إضافة قائمة جديدة',
                  fontSize: 16.sp,
                  textColor: Theme.of(context).textTheme.displayLarge!.color,
                  textAlign: TextAlign.right),
              SizedBox(height: 2.h),
              CommonViews().customText(
                  textContent: 'اسم القائمة',
                  fontSize: 11.sp,
                  textColor: Theme.of(context).textTheme.displayLarge!.color,
                  textAlign: TextAlign.right),
              CommonViews().createTextFormField(
                  controller: menuNameController,
                  focusNode: menuNameFocusNode,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  onSubmitted: (v) {
                    menuDescFocusNode.requestFocus();
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "يرجى ملء هذا الحقل";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  borderColor: Theme.of(context).textTheme.titleMedium!.color,
                  fillColor: Theme.of(context).appBarTheme.backgroundColor,
                  radius: 5,
                  hint: 'أسم القائمة'),
              SizedBox(height: 1.h),
              CommonViews().customText(
                  textContent: 'تفاصيل القائمة',
                  fontSize: 11.sp,
                  textColor: Theme.of(context).textTheme.displayLarge!.color,
                  textAlign: TextAlign.right),
              CommonViews().createTextFormField(
                  controller: menuDescController,
                  focusNode: menuDescFocusNode,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  onSubmitted: (v) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "يرجى ملء هذا الحقل";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  borderColor: Theme.of(context).textTheme.titleMedium!.color,
                  fillColor: Theme.of(context).appBarTheme.backgroundColor,
                  radius: 5,
                  height: 10.h,
                  maxLines: 5,
                  hint: 'تفاصيل القائمة',
                  inputAction: TextInputAction.done),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 3.w,
                  ),
                  CommonViews().customClickableContainer(
                      onTap: () {
                        if (_key.currentState!.validate()) {
                          addReviewController.addReview(
                              txtName: menuNameController.text,
                              txtDescription: menuDescController.text);
                        }
                      },
                      radius: 5,
                      width: 30.w,
                      colorBorder: Colors.transparent,
                      color: const Color(0xff7367f0),
                      child: Center(
                        child: CommonViews().customText(
                          textContent: 'حفظ القائمة',
                          fontSize: 12.sp,
                        ),
                      )),
                  SizedBox(
                    width: 3.w,
                  ),
                  CommonViews().customClickableContainer(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
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
                          textColor:
                              Theme.of(context).textTheme.titleMedium!.color,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void addMenuPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          SizedBox(
            height: 20.h,
            width: 100.w,
          ),
          Positioned(top: 1.h, right: 1, left: 1, child: const AddMenuPopup()),
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
