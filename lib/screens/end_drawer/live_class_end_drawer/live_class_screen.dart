// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'dart:io';
import 'dart:ui' as ui;

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jo_students/check_user/check_user_controller.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/screens/end_drawer/live_class_end_drawer/live_class_controller.dart';
import 'package:jo_students/screens/end_drawer/subscription_end_drawer/subscription_card_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class LiveClassScreen extends StatefulWidget {
  LiveClassScreen({super.key});

  @override
  State<LiveClassScreen> createState() => _LiveClassScreenState();
}

class _LiveClassScreenState extends State<LiveClassScreen> {
  final LiveClassController liveClassController =
      Get.put(LiveClassController());

  final FocusNode _searchFocusNode = FocusNode();

  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');

  String url = 'https://jo-students.com/site_videos/1_3_RecordedLive.mp4';
  final SearchLiveController searchController = Get.put(SearchLiveController());

  @override
  void dispose() {
    // Clear the text when the widget is disposed
    searchController.clearSearch();
    super.dispose();
  }
  final checkUser=Get.find<CheckUserController>();

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
                            textContent: "حصص مباشرة",
                            fontSize: 16.sp,
                            textColor:
                                Theme.of(context).textTheme.bodyLarge!.color,
                            fontWeight: FontWeight.bold,
                          ),
                          Transform.scale(
                            scale: 0.6,
                            child: Image.asset(
                              fourMenuImage,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: CommonViews().customText(
                          textContent: ' جدول الحصص المباشرة',
                          fontSize: 13.sp,
                          textColor:
                              Theme.of(context).textTheme.bodyMedium!.color,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        width: 100.w,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).appBarTheme.backgroundColor,
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
                                            searchController.searchController,
                                        focusNode: _searchFocusNode,
                                        textDirection: ui.TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        onChanged: (value) {
                                          liveClassController
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
                                          prefixIcon: searchController.showClearIcon.value
                                              ? GestureDetector(
                                            onTap: () {
                                              searchController.clearSearch();
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
                              if (liveClassController.isLoading) {
                                return _buildLoadingTable();
                              } else if (liveClassController.isEmpty) {
                                return _buildEmptyTable();
                              } else if (liveClassController.isError) {
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

  Widget _buildTableCell(String text,
      {String? cellType, String? liveSubjectTitle,String? video}) {
    if (cellType == 'status') {
      if (text == "2") {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CommonViews().customText(
                textContent: "انتهى البث",
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                textColor: Theme.of(Get.context!).textTheme.bodyLarge!.color,
              ),
              CommonViews().customClickableContainer(
                color: Theme.of(Get.context!).appBarTheme.backgroundColor,
                colorBorder: const Color(0xff7367f0),
                radius: 8,
                height: 7.h,
                onTap: () async {
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
                                    fontWeight: FontWeight.w700
                                ),
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
                                        General.savePrefInt(ConstantValues.selectedIndexKey, 8);
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
                  }else{
                    recordVideoPopup(
                      context: Get.context!,
                      title: liveSubjectTitle ?? '',
                      video: video??"",
                    );
                  }
                },
                child: Center(
                  child: CommonViews().customText(
                    textContent: "مشاهدة التسجيل",
                    fontSize: 11.sp,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    textColor: const Color(0xff7367f0),
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (text == "0") {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommonViews().customText(
            textContent: "لم تبدأ بعد",
            fontSize: 11.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(Get.context!).textTheme.bodyLarge!.color,
          ),
        );
      }
    }

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
          _buildTableCell('الحالة'),
          _buildTableCell('تاريخ البث'),
          _buildTableCell('العنوان '),
          _buildTableCell('الفصل'),
          _buildTableCell('الصف'),
          _buildTableCell('المادة'),
          _buildTableCell('المدرس'),
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
          _buildTableCell('الحالة'),
          _buildTableCell('تاريخ البث'),
          _buildTableCell('العنوان '),
          _buildTableCell('الفصل'),
          _buildTableCell('الصف'),
          _buildTableCell('المادة'),
          _buildTableCell('المدرس'),
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
          _buildTableCell('الحالة'),
          _buildTableCell('تاريخ البث'),
          _buildTableCell('العنوان '),
          _buildTableCell('الفصل'),
          _buildTableCell('الصف'),
          _buildTableCell('المادة'),
          _buildTableCell('المدرس'),
        ],
      ),
      _buildHorizontalDividerRow(),
    ];

    if (liveClassController.filteredLiveClasses.isNotEmpty) {
      rows.addAll(
        liveClassController.filteredLiveClasses
            .map((live) {
              return TableRow(
                children: [
                  _buildTableCell(live.liveSessionId.toString()),
                  _buildTableCell(
                    live.isLive,
                    cellType: 'status',
                    liveSubjectTitle: live.liveSubjectTitle,
                    video:live.recordedLiveFileNameMp4,
                  ),
                  _buildTableCell(
                    formatter.format(
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(live.timeOfLiveDt),
                      ),
                    ),
                  ),
                  _buildTableCell(live.liveSubjectTitle),
                  _buildTableCell(live.semesterTitleAr),
                  _buildTableCell(live.classTitleAr),
                  _buildTableCell(live.subjectTitleAr),
                  _buildTableCell(live.tFullName),
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
        if (liveClassController.filteredLiveClasses.isEmpty)
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
      children: List.generate(8, (_) => _buildHorizontalDivider()),
    );
  }

  void recordVideoPopup({
    required BuildContext context,
    required String title,
    required String video,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Callback to stop video and close dialog
        void stopVideoAndClose() {
          Navigator.of(context).pop();
          // Access the VideoPlayerScreen widget to stop the video
          final videoPlayerScreenState = context.findAncestorStateOfType<_VideoPlayerScreenState>();
          videoPlayerScreenState?.stopVideo();
        }
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
                child: VideoPlayerScreen(
                  title: title,
                  video:video,
                  onClose: stopVideoAndClose,
                )),
            Positioned(
              top: 2.h,
              left: 3.h,
              child: GestureDetector(
                onTap: stopVideoAndClose,
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

class SearchLiveController extends GetxController {
  var showClearIcon = false.obs;
  TextEditingController searchController = TextEditingController();
  final LiveClassController liveClassController =
      Get.find<LiveClassController>();

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
    liveClassController.resetFilter();
  }

  @override
  void onClose() {
    searchController.removeListener(_updateClearIconVisibility);
    searchController.dispose();
    super.onClose();
  }
}




class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String video;
  final VoidCallback? onClose;

  VideoPlayerScreen({super.key, required this.title,
    this.onClose, required this.video,});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  final LiveClassController liveClassController =
  Get.find<LiveClassController>();

  ChewieController? _chewieController;
  VideoPlayerController? _videoPlayerController;

  bool _isVideoLoaded = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? url;

  @override
  void initState() {
    super.initState();
    _retrieveSavedMsg();
  }

  void _retrieveSavedMsg() async {
    // Retrieve the saved MSG from SharedPreferences
    String savedMsg = await General.getPrefString(ConstantValues.MSG,"");
        url = "https://jo-students.com/site_videos/${widget.video}?logintrx=$savedMsg";
      _initialize(url!);
    }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).appBarTheme.backgroundColor,
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CommonViews().customText(textContent:   "مشاهدة حصة مباشرة مسجلة",
                textColor:Theme.of(context).textTheme.displayLarge?.color,
              fontSize:13.sp,textAlign: TextAlign.right,  ),

            const SizedBox(height: 16),
            CommonViews().customText(textContent: '${widget.title} : العنوان',
              textColor:Theme.of(context).textTheme.displayLarge?.color,
              fontSize:12.sp,textAlign: TextAlign.right,  ),

            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator()),
            if (_isVideoLoaded && _chewieController != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AspectRatio(
                  aspectRatio: _videoPlayerController?.value.aspectRatio ?? 1.0,
                  child: Chewie(controller: _chewieController!),
                ),
              ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomLeft,
              child: CommonViews().customClickableContainer(
                onTap: () {
                  stopVideo();
                  widget.onClose?.call();
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initialize(String url) async {
    setState(() {
      _isLoading = true;
    });
    final file = await downloadVideo(
      url: url,
      fileName: 'RecordedLive.mp4',
    );
    setState(() {
      _isLoading = false;
    });
    if (file != null) {
      await _initializeVideoPlayer(file);
    }
  }

  Future<void> _initializeVideoPlayer(File file) async {
    try {
      
      _videoPlayerController = VideoPlayerController.file(file);
      await _videoPlayerController!.initialize();

      if (_videoPlayerController!.value.isInitialized) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController!,
            autoPlay: true,
            looping: false,
          );
          _isVideoLoaded = true;
          _errorMessage = null;
        });
      } else {
        setState(() {
          _errorMessage = "Video player failed to initialize.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to initialize video player: $e";
      });
    }
  }

  Future<File?> downloadVideo({required String url, required String fileName}) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$fileName');

    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          maxRedirects: 5,
        ),
      );

      if (response.statusCode == 200) {
        await file.writeAsBytes(response.data);
        if (await file.exists()) {

          return file;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void stopVideo() {
    _chewieController?.pause();
    _videoPlayerController?.dispose();
  }

  @override
  void dispose() {
    stopVideo();
    super.dispose();
  }
}


