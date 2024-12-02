// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import 'library_book/library_controller.dart';
import 'library_book_id/library_book_id_controller.dart';
import 'read_more_pdf.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}



class _LibraryScreenState extends State<LibraryScreen> {

  final Map<int, ScrollController> _scrollControllers = {};

  final LibraryGetDetailsController controllerDetails= Get.put(LibraryGetDetailsController());
  final LibraryGetController libraryController = Get.put(LibraryGetController());

  @override
  void dispose() {
    _scrollControllers.forEach((_, controller) => controller.dispose());
    Get.delete<LibraryGetDetailsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const EndDrawerView(),
        appBar: CustomProfileAppBar(),
        body: Obx(
              () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 1.h),
                Container(
                  width: 100.w,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.white, Color(0xFFF0EEE2)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.5, 0.5],
                    ),
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
                    children:[
                      controllerDetails.showBookDetails.value
                          ? clickableContainer(
                          context: context,
                          title:controllerDetails.bookTitle.value,
                          numberOfPage: controllerDetails.bookPage.value,
                          image:  controllerDetails.bookImage.value,
                          des:  controllerDetails.bookDesc.value,
                          pdf:  controllerDetails.bookPdf.value,
                          date:  controllerDetails.bookDate.value,
                        author:controllerDetails.bookWriter.value,)
                          :
                      nonClickableContainer(),
                      Column(
                          children: libraryController.library.map((item) {
                            // Retrieve or create a ScrollController for the current libraryCatId
                            ScrollController scrollController =
                            _scrollControllers[item.libraryCatId] ??= ScrollController();
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        scrollController.animateTo(
                                          scrollController.offset + 200,
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                        width: 10.w,
                                        height: 10.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: const Color(0xff8D8A94)),
                                        ),
                                        child: Center(
                                          child: Icon(Icons.arrow_back_ios_sharp,
                                              color: Theme.of(context).textTheme.displaySmall!.color,
                                              size: 15.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    GestureDetector(
                                      onTap: () {
                                        scrollController.animateTo(
                                          scrollController.offset - 200,
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                        width: 10.w,
                                        height: 10.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: const Color(0xff8D8A94)),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15.0,
                                            color: Theme.of(context).textTheme.displaySmall!.color,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    CommonViews().customText(
                                      textContent: '(${item.booksNumber})',
                                      textColor: Colors.black,
                                      withFontFamily: false,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(width: 1.w),
                                    CommonViews().customText(
                                      textContent: item.libraryCatTitle,
                                      textColor: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Directionality(
                                  textDirection:ui.TextDirection.rtl,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: SizedBox(
                                      height: 35.h,
                                      child: ListView(
                                        controller: scrollController,
                                        physics: const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        children: item.books.map((book) {
                                          return Column(
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: GestureDetector(
                                                  onTap: (){
                                                    controllerDetails.fetchLibraryBooksDetailsFromApi(
                                                        libraryBookID: book.libraryBookId
                                                    );
                                                  },
                                                  child: Card(
                                                    color: Colors.transparent,
                                                    elevation: 0,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl: book.libraryBookThumpnailMobile,
                                                          width: 40.w,
                                                          fit: BoxFit.cover,
                                                          placeholder: (context, url) =>
                                                          const CircularProgressIndicator(),
                                                          errorWidget: (context, url, error) =>
                                                          const Icon(Icons.error),
                                                        ),
                                                        SizedBox(height: 1.h),
                                                        CommonViews().customText(
                                                          textContent: book.libraryBookTitle,
                                                          textColor: Colors.black,
                                                          textAlign: TextAlign.center,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
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

  Widget clickableContainer({
   required BuildContext context,
   required String title,
   required String author,
    required String numberOfPage,
    required String image,
    required String des,
    required String pdf,
    required String date,
  }) {
    return
      Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Container(
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
              CommonViews().customText(
                  textContent: title,
                  fontSize: 14.sp,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  fontWeight: FontWeight.bold),
              SizedBox(height: 1.h),
              CommonViews().customText(
                  textContent: des,
                  fontSize: 12.sp,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.visible,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  fontWeight: FontWeight.w500),
              SizedBox(height: 1.h),
              CommonViews().customText(
                  textContent: ' الكتاب : $author',
                  fontSize: 12.sp,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  fontWeight: FontWeight.w500),
              SizedBox(height: 1.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonViews().customText(
                      textContent: 'عدد الصفحات : ',
                      fontSize: 12.sp,
                      textColor: Theme.of(context).textTheme.bodyLarge!.color,
                      fontWeight: FontWeight.w500),
                  CommonViews().customText(
                      textContent: '$numberOfPage ',
                      fontSize: 12.sp,
                      withFontFamily: false,
                      textColor: Theme.of(context).textTheme.bodyLarge!.color,
                      fontWeight: FontWeight.w500),
                ],
              ),
              SizedBox(height: 1.h),
              CommonViews().customText(
                  textContent:formatTimestamp(date),
                  fontSize: 12.sp,
                  withFontFamily: false,
                  textColor: Theme.of(context).textTheme.titleMedium!.color,
                  fontWeight: FontWeight.w500),
              SizedBox(height: 2.h),
              CommonViews().customClickableContainer(
                onTap: (){
                  AppNavigator.of(context).push(PdfViewerScreen(url: pdf,));
                },
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  width: 30.w,
                  colorBorder: Theme.of(context).textTheme.bodyLarge!.color,
                  child: Center(
                    child: CommonViews().customText(
                        textContent: "ابدأ القراءة",
                        textAlign: TextAlign.center,
                        textColor: Theme.of(context).textTheme.bodySmall!.color,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400),
                  )),
              SizedBox(height: 2.h),
              CachedNetworkImage(
                imageUrl:image,
                width: 40.w,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),

            ],
          ),
        ),
      );
  }

  Column nonClickableContainer() {
    return Column(
      children: [
        Image.asset(
          libraryBackGround,
          width: 60.w,
          height: 15.h,
          fit: BoxFit.fill,
        ),
        SizedBox(height: 2.h),
        CommonViews().customText(
          textContent: 'ابقي القصة مستمرة',
          textColor: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 1.h),
        CommonViews().customText(
          textContent: 'لا تدع القصة تنتهي بعد. واصل قراءة كتابك',
          textColor: Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        CommonViews().customText(
          textContent: '.الأخير وانغمس في عالم الأدب',
          textColor: Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 3.h),
      ],
    );
  }

  String formatTimestamp(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) {
      return "Invalid timestamp";
    }
    try {
      int timestampInt = int.parse(timestamp);
      DateTime date = DateTime.fromMillisecondsSinceEpoch(timestampInt);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return "Invalid timestamp ";
    }
  }

}




