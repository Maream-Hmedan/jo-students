// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';

import 'library_controller.dart';

class LibraryTestScreen extends StatefulWidget {
  const LibraryTestScreen({super.key});

  @override
  State<LibraryTestScreen> createState() => _LibraryTestScreenState();
}

List<BookCardWidget> variousBooks = [];
List<BookCardWidget> selectedBooks = [];

class _LibraryTestScreenState extends State<LibraryTestScreen> {
  final ScrollController _scrollControllerVariousBooks = ScrollController();
  final ScrollController _scrollControllerSelectedBook = ScrollController();

  var showBookDetails=false.obs ;
  var currentTitle = ''.obs;
  var bookImage = ''.obs;
  var numberOfPage = ''.obs;

  final LibraryController controller = Get.put(LibraryController());


  final LibraryGetController libraryController = Get.put(LibraryGetController());


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.showBookDetails.value = false;
    });

  }

  @override
  void dispose() {
    _scrollControllerVariousBooks.dispose();
    _scrollControllerSelectedBook.dispose();
    controller.showBookDetails.value = false;
    Get.delete<LibraryController>();
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
                SizedBox(
                  height: 1.h,
                ),
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
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            controller.showBookDetails.value
                                ? clickableContainer(
                                context,
                                controller.currentTitle.value,
                                controller.numberOfPage.value,
                                controller.bookImage.value)
                                : nonClickableContainer(),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _scrollControllerVariousBooks.animateTo(
                                      _scrollControllerVariousBooks.offset +
                                          200,
                                      duration:
                                      const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xff8D8A94),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.arrow_back_ios_sharp,
                                          color: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .color,
                                          size: 15.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _scrollControllerVariousBooks.animateTo(
                                      _scrollControllerVariousBooks.offset -
                                          200,
                                      duration:
                                      const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xff8D8A94),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15.0,
                                        color: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .color,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                CommonViews().customText(
                                  textContent: '(8)',
                                  textColor: Colors.black,
                                  withFontFamily: false,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(width: 1.w),
                                CommonViews().customText(
                                  textContent: 'كتب منوعة',
                                  textColor: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                                child: SizedBox(
                                  height: 35.h,
                                  child: ListView(
                                    controller: _scrollControllerVariousBooks,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: controller.variousBooks
                                        .map((book) => GestureDetector(
                                        onTap: () {
                                          controller.toggleBookDetails(
                                              title: book.title,
                                              image: book.imageUrl,
                                              number: book.numberOfPage);
                                        },
                                        child: book.build(context)))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _scrollControllerSelectedBook.animateTo(
                                      _scrollControllerSelectedBook.offset +
                                          200,
                                      duration:
                                      const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xff8D8A94),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back_ios_sharp,
                                        size: 15.0,
                                        color: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .color,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _scrollControllerSelectedBook.animateTo(
                                      _scrollControllerSelectedBook.offset -
                                          200,
                                      duration:
                                      const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xff8D8A94),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15.0,
                                        color: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .color,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                CommonViews().customText(
                                  textContent: '(6)',
                                  textColor: Colors.black,
                                  withFontFamily: false,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(width: 1.w),
                                CommonViews().customText(
                                  textContent: 'كتب مختارة',
                                  textColor: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                                child: SizedBox(
                                  height: 35.h,
                                  child: ListView(
                                    controller: _scrollControllerSelectedBook,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: controller.selectedBooks
                                        .map((book) => GestureDetector(
                                        onTap: () {
                                          controller.toggleBookDetails(
                                              title: book.title,
                                              image: book.imageUrl,
                                              number: book.numberOfPage);
                                        },
                                        child: book.build(context)))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
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
    );
  }

  Container clickableContainer(
      BuildContext context,
      String? centerTitle,
      String? numberOfPage,
      String? image,
      ) {
    return Container(
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
          CommonViews().customText(
              textContent: centerTitle!,
              fontSize: 14.sp,
              textColor: Theme.of(context).textTheme.bodyLarge!.color,
              fontWeight: FontWeight.bold),
          SizedBox(height: 1.h),
          CommonViews().customText(
              textContent: 'وصف الكتاب',
              fontSize: 12.sp,
              textColor: Theme.of(context).textTheme.bodyLarge!.color,
              fontWeight: FontWeight.w500),
          SizedBox(height: 1.h),
          CommonViews().customText(
              textContent: 'الكتاب: كاتب الكتاب',
              fontSize: 12.sp,
              textColor: Theme.of(context).textTheme.bodyLarge!.color,
              fontWeight: FontWeight.w500),
          SizedBox(height: 1.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonViews().customText(
                  textContent: '$numberOfPage ',
                  fontSize: 12.sp,
                  withFontFamily: false,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  fontWeight: FontWeight.w500),
              CommonViews().customText(
                  textContent: ': عدد الصفحات',
                  fontSize: 12.sp,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  fontWeight: FontWeight.w500),
            ],
          ),
          SizedBox(height: 1.h),
          CommonViews().customText(
              textContent: '08/23/2024',
              fontSize: 12.sp,
              withFontFamily: false,
              textColor: Theme.of(context).textTheme.titleMedium!.color,
              fontWeight: FontWeight.w500),
          SizedBox(height: 2.h),
          CommonViews().customClickableContainer(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              width: 30.w,
              colorBorder: Theme.of(context).textTheme.bodyLarge!.color,
              child: Center(
                child: CommonViews().customText(
                    textContent: "ابدأ القراءة",
                    textAlign: TextAlign.center,
                    textColor: Theme.of(context).textTheme.bodySmall!.color,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700),
              )),
          SizedBox(height: 2.h),
          Image.asset(
            image!,
            width: 40.w,
            fit: BoxFit.cover,
          ),
        ],
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
}

class BookCardWidget {
  final String imageUrl;
  final String title;
  final String numberOfPage;
  final VoidCallback onTap;

  BookCardWidget({
    required this.imageUrl,
    required this.title,
    required this.numberOfPage,
    required this.onTap,
  });

  Widget build(BuildContext context) {
    return
      SizedBox(
      width: 200,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imageUrl,
                width: 40.w,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 1.h),
              CommonViews().customText(
                textContent: title,
                textColor: Colors.black,
                textAlign: TextAlign.center,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryController extends GetxController {
  var variousBooks = <BookCardWidget>[].obs;
  var selectedBooks = <BookCardWidget>[].obs;
  var showBookDetails = false.obs;
  var currentTitle = ''.obs;
  var bookImage = ''.obs;
  var numberOfPage = ''.obs;

  void fillVariousBooks() {
    return variousBooks.addAll([
      BookCardWidget(
        imageUrl: bookCover1,
        title: 'الغشاش',
        onTap: () {
          toggleBookDetails(
            title: 'الغشاش',
            image: bookCover1,
            number: "55",
          );
        },
        numberOfPage: '55',
      ),
      BookCardWidget(
        imageUrl: bookCover2,
        title: 'افضل 100 اختراع',
        onTap: () {
          toggleBookDetails(
            title: 'افضل 100 اختراع',
            image: bookCover2,
            number: "101",
          );
        },
        numberOfPage: '101',
      ),
      BookCardWidget(
        imageUrl: bookCover3,
        title: 'البقرة الذهبية',
        onTap: () {
          toggleBookDetails(
            title: 'البقرة الذهبية',
            image: bookCover3,
            number: "33",
          );
        },
        numberOfPage: '33',
      ),
      BookCardWidget(
          imageUrl: bookCover4,
          title: 'تجربة عملية مع الكهرباء',
          numberOfPage: '29',
          onTap: () {
            toggleBookDetails(
              title: 'تجربة عملية مع الكهرباء',
              image: bookCover4,
              number: "29",
            );
          }
      ),
      BookCardWidget(
          imageUrl: bookCover5,
          title: 'دروس من النباتات',
          numberOfPage: '22',
          onTap: () {
            toggleBookDetails(
              title:'دروس من النباتات',
              image: bookCover5,
              number: "22",
            );
          }
      ),
      BookCardWidget(
        imageUrl: bookCover6,
        title: 'القدرة الشمسية',
        onTap: () {
          toggleBookDetails(
            title: 'القدرة الشمسية',
            image: bookCover6,
            number: "23",
          );
        },
        numberOfPage: '23',
      ),
      BookCardWidget(
        imageUrl: bookCover7,
        title: 'ما الذي تحكيه لنا الأحافير؟',
        onTap: () {
          toggleBookDetails(
            title:   'ما الذي تحكيه لنا الأحافير؟',
            image: bookCover7,
            number: "123",
          );
        },
        numberOfPage: '123',
      ),
      BookCardWidget(
        imageUrl: bookCover8,
        title: 'موسم صيد في بيروت',
        onTap: () {
          toggleBookDetails(
            title:  'موسم صيد في بيروت',
            image: bookCover8,
            number: "123",
          );
        },
        numberOfPage: '123',
      ),
    ]);
  }

  void fillSelectedBooks() {
    return selectedBooks.addAll([
      BookCardWidget(
        imageUrl: bookCover9,
        title: 'اخلاق الرسول',
        onTap: () {
          toggleBookDetails(
            title: 'اخلاق الرسول',
            image: bookCover9,
            number: "222",
          );
        },
        numberOfPage: '222',
      ),
      BookCardWidget(
        imageUrl: bookCover10,
        title: 'الانسان والطاقة عبر الزمن',
        onTap: () {
          toggleBookDetails(
            title:'الانسان والطاقة عبر الزمن',
            image: bookCover10,
            number: "222",
          );
        },
        numberOfPage: '222',
      ),
      BookCardWidget(
        imageUrl: bookCover11,
        title: 'التغذية والنشاط الرياضي',
        onTap: () {
          toggleBookDetails(
            title:'التغذية والنشاط الرياضي',
            image: bookCover11,
            number: "222",
          );
        },
        numberOfPage: '222',
      ),
      BookCardWidget(
        imageUrl: bookCover12,
        title: 'الرسم بالألوان المائية',
        onTap: () {
          toggleBookDetails(
            title:'الرسم بالألوان المائية',
            image: bookCover12,
            number: "222",
          );
        },
        numberOfPage: '222',
      ),
      BookCardWidget(
        imageUrl: bookCover13,
        title: 'فسيولوجيا النباتات',
        onTap: () {
          toggleBookDetails(
            title: 'فسيولوجيا النباتات',
            image: bookCover13,
            number: "222",
          );
        },
        numberOfPage: '222',
      ),
      BookCardWidget(
        imageUrl: bookCover14,
        title: 'قصص من العالم',
        onTap: () {
          toggleBookDetails(
            title:  'قصص من العالم',
            image: bookCover14,
            number: "2222",
          );
        },
        numberOfPage: '2222',
      ),
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    fillVariousBooks();
    fillSelectedBooks();
  }

  void toggleBookDetails(
      {required String title, required String image, required number}) {
    if(showBookDetails.value==false){
      showBookDetails.value = !showBookDetails.value;
      currentTitle.value = title;
      numberOfPage.value = number;
      bookImage.value = image;
    }
    currentTitle.value = title;
    numberOfPage.value = number;
    bookImage.value = image;
  }


}
