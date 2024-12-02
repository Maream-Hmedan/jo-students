import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/screens/end_drawer/subscription_end_drawer/subscription_card_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import 'subscription_table/subscription_controller.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final SubscriptionController subscriptionController =
  Get.put(SubscriptionController());

  final SearchSubController searchSubController = Get.put(SearchSubController());
  final FocusNode _searchFocusNode = FocusNode();
  @override
  void dispose() {
    // Clear the text when the widget is disposed
    searchSubController.clearSearch();
    super.dispose();
  }

  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const EndDrawerView(),
        appBar: CustomProfileAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 1.h),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonViews().customText(
                            textContent: 'اشتراكاتي',
                            fontSize: 16.sp,
                            textColor: Theme.of(context).textTheme.bodyLarge!.color,
                            fontWeight: FontWeight.bold,
                          ),
                          Transform.scale(
                            scale: 0.6,
                            child: Image.asset(
                              eightMenuImage,
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      CommonViews().customText(
                        textContent: 'جميع خطط الاشتراكات التي قمت بالاشتراك بها',
                        fontSize: 13.sp,
                        textColor: Theme.of(context).textTheme.bodyMedium!.color,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 2.h),
                      CommonViews().customClickableContainer(
                        onTap: () {
                          AppNavigator.of(context).push(SubscriptionCard());
                        },
                        radius: 5,
                        width: 30.w,
                        color: const Color(0xff7367f0),
                        colorBorder: const Color(0xff7367f0),
                        child: Center(
                          child: CommonViews().customText(
                            textContent: 'أشترك الان',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        width: 100.w,
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
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(() => Container(
                                  width: 50.w,
                                  height: 4.h,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color ??
                                          Colors.black,
                                    ),
                                  ),
                                  child: TextFormField(
                                    maxLines: 2,
                                    controller:
                                    searchSubController.searchController,
                                    focusNode: _searchFocusNode,
                                    textDirection: ui.TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    onChanged: (value) {
                                     subscriptionController
                                          .filterLiveClasses(value);
                                    },
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    cursorColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    cursorHeight: 22,
                                    decoration: InputDecoration(
                                      prefixIcon: searchSubController.showClearIcon.value
                                          ? GestureDetector(
                                        onTap: () {
                                          searchSubController.clearSearch();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 2),
                                          child: Icon(
                                            Icons.clear,
                                            color: Theme.of(context).textTheme.labelSmall!.color,
                                          ),
                                        ),
                                      )
                                          : null,
                                      isDense: true,
                                      contentPadding: const EdgeInsets.only(
                                        right: 4,

                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.color ??
                                              Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                                SizedBox(width: 2.w),
                                CommonViews().customText(
                                  textContent: ' : بحث',
                                  fontSize: 10.sp,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(width: 4.w),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Obx(() {
                              if (subscriptionController.isLoading) {
                                return _buildLoadingTable();
                              } else if (subscriptionController.isEmpty) {
                                return _buildEmptyTable();
                              } else if (subscriptionController.isError) {
                                return _buildErrorTable();
                              } else {
                                return Directionality(
                                    textDirection: ui.TextDirection.rtl,
                                    child: _buildDataTable(context));
                              }
                            }),
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

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonViews().customText(
        textContent: text,
        fontSize: 10.sp,
        withFontFamily: false,
        textAlign: TextAlign.center,
        textColor: Theme.of(Get.context!).textTheme.bodyLarge!.color,
      ),
    );
  }

  Widget _buildHorizontalDivider() {
    return Container(
      height: 1,
      color: Theme.of(Get.context!).textTheme.bodySmall!.color ?? Colors.black,
    );
  }

  Widget _buildLoadingTable() {
    return const Center(
      child: SpinKitCircle(
        color: AppColors.backGroundColor,
        size: 50.0,
      ),
    );
  }

  Widget _buildEmptyTable() {
    List<TableRow> rows = [
      TableRow(
        children: [
          _buildTableCell('الرقم'),
          _buildTableCell('تاريخ الاشتراك'),
          _buildTableCell('الفصل'),
          _buildTableCell('الصف'),
          _buildTableCell('المادة'),
          _buildTableCell('رقم البطاقة'),
        ],
      ),
      _buildHorizontalDividerRow(),

    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(80),
                1: FixedColumnWidth(100),
                2: FixedColumnWidth(100),
                3: FixedColumnWidth(80),
                4: FixedColumnWidth(80),
                5: FixedColumnWidth(80),
                6: FixedColumnWidth(80),
                7: FixedColumnWidth(80),
              },
              border: TableBorder(
                verticalInside: BorderSide(
                  color: Theme.of(context).textTheme.bodySmall!.color ??
                      Colors.black,
                  width: 1,
                ),
              ),
              children: rows,
            ),
          ),
        ),
        Center(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CommonViews().customText(
                    textContent: 'No data available in table',
                    fontSize: 12.sp,
                    textColor:
                    Theme.of(Get.context!).textTheme.bodyLarge!.color,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorTable() {
    List<TableRow> rows = [
      TableRow(
        children: [
          _buildTableCell('الرقم'),
          _buildTableCell('تاريخ الاشتراك'),
          _buildTableCell('الفصل'),
          _buildTableCell('الصف'),
          _buildTableCell('المادة'),
          _buildTableCell('رقم البطاقة'),
        ],
      ),
      _buildHorizontalDividerRow(),

    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(80),
                1: FixedColumnWidth(100),
                2: FixedColumnWidth(100),
                3: FixedColumnWidth(80),
                4: FixedColumnWidth(80),
                5: FixedColumnWidth(80),
                6: FixedColumnWidth(80),
                7: FixedColumnWidth(80),
              },
              border: TableBorder(
                verticalInside: BorderSide(
                  color: Theme.of(context).textTheme.bodySmall!.color ??
                      Colors.black,
                  width: 1,
                ),
              ),
              children: rows,
            ),
          ),
        ),
        Center(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CommonViews().customText(
                    textContent: 'Error loading live classes',
                    fontSize: 12.sp,
                    textColor:
                    Theme.of(Get.context!).textTheme.bodyLarge!.color,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );

  }

  Widget _buildDataTable(BuildContext context) {
    List<TableRow> rows = [
      TableRow(
        children: [
          _buildTableCell('الرقم'),
          _buildTableCell('تاريخ الاشتراك'),
          _buildTableCell('الفصل'),
          _buildTableCell('الصف'),
          _buildTableCell('المادة'),
          _buildTableCell('رقم البطاقة'),
        ],
      ),
      _buildHorizontalDividerRow(),

    ];
    if (subscriptionController.filteredSubscriptions.isNotEmpty) {
      rows.addAll(
        subscriptionController.filteredSubscriptions
            .map((s) {
          return TableRow(
            children: [
              _buildTableCell(s.studentSubId.toString()),
              _buildTableCell(
                formatter.format(
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(s.subDt),
                  ),
                ),
              ),
              _buildTableCell(s.systemSemesterTitleAr),
              _buildTableCell(s.classTitleAr),
              _buildTableCell(s.subjectTitleAr),
              _buildTableCell(s.cardCode),
            ],
          );
        })
            .expand((row) => [row, _buildHorizontalDividerRow()])
            .toList(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(80),
                1: FixedColumnWidth(100),
                2: FixedColumnWidth(80),
                3: FixedColumnWidth(80),
                4: FixedColumnWidth(100),
                5: FixedColumnWidth(80),
              },
              border: TableBorder(
                verticalInside: BorderSide(
                  color: Theme.of(context).textTheme.bodySmall!.color ?? Colors.black,
                  width: 1,
                ),
              ),
              children: rows,
            ),
          ),
        ),
        if (subscriptionController.filteredSubscriptions.isEmpty)
          Center(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommonViews().customText(
                      textContent: 'No matching records found',
                      fontSize: 12.sp,
                      textColor:
                      Theme.of(Get.context!).textTheme.bodyLarge!.color,
                      fontWeight: FontWeight.w700)),
            ),
          ),
      ],
    );
  }

  TableRow _buildHorizontalDividerRow() {
    return TableRow(
      children: List.generate(6, (_) => _buildHorizontalDivider()),
    );
  }
}


class SearchSubController extends GetxController {
  var showClearIcon = false.obs;
  TextEditingController searchController = TextEditingController();
  final SubscriptionController subscriptionController=
  Get.find<SubscriptionController>();

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_updateClearIconVisibility);
  }

  void _updateClearIconVisibility() {
    showClearIcon.value = searchController.text.isNotEmpty;
  }

  void clearSearch() {
    searchController.clear();
    showClearIcon.value = false;
    subscriptionController.resetFilter();
  }

  @override
  void onClose() {
    searchController.removeListener(_updateClearIconVisibility);
    searchController.dispose();
    super.onClose();
  }
}