// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jo_students/check_user/check_user_controller.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_classes_dialog/top_classes_list/classes_controller.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:sizer/sizer.dart';

import 'class_name/class_name_controller.dart';
import 'update_class/update_class_controller.dart';

class TopClassesDialog extends StatelessWidget {
  TopClassesDialog({super.key});

  void getUseId() async {
    await General.getPrefInt(ConstantValues.ID);
  }

  final ClassesController controller = Get.put(ClassesController());

  final UpdateClassController updateClassController =
  Get.put(UpdateClassController());

  ClassNameController classNameController = Get.put(ClassNameController());

  final CheckUserController checkUserController =
  Get.put(CheckUserController());

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final double dialogHeight = isLandscape
        ? (MediaQuery.of(context).size.height)
        : MediaQuery.of(context).size.height * 0.64;
    final double dialogWidth = isLandscape
        ? (MediaQuery.of(context).size.width)* 0.5
        :MediaQuery.of(context).size.width ;
    return Container(
      width: dialogWidth ,
      height: dialogHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonViews().customText(
                  textContent: 'الصف',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.grey)),
          Divider(
            color: Theme.of(context).textTheme.bodySmall!.color ?? Colors.black,
            height: 1,
          ),
          Expanded(
            child: _classesView(),
          ),
        ],
      ),
    );
  }

  Widget _classesView() {
    return Obx(() {
      if (controller.isLoading) {
        return _getLoadingView();
      }
      if (controller.isError) {
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
      if (controller.isEmpty) {
        return Center(
          child: CommonViews().customText(
            textContent: "!! لا يوجد صفوف ليتم عرضها",
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 15.sp,
          ),
        );
      }
      if (controller.isSuccess) {
        final bool isLandscape = MediaQuery.of(Get.context!).orientation == Orientation.landscape;
        final double aspectRatio = isLandscape
            ? 0.99
            :0.9;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            child: GestureDetector(
              child: GridView.builder(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio:  aspectRatio,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      int userId = await General.getPrefInt(ConstantValues.ID) ?? -1;
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]) ;
                    await  updateClassController.updateClass(
                        classID: controller.classes[index].classId,
                        userid: userId,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        border: Border.all(
                            color: Theme.of(context).textTheme.bodySmall!.color ??
                                Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 15.w,
                            height: 5.h,
                            decoration: const BoxDecoration(
                                color: AppColors.backGroundColor,
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                controller.classes[index].classNumber,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0, // Adjust size as needed
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CommonViews().customText(
                              textContent: controller.classes[index].classTitleAr,
                              fontSize: 9.sp,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w900,
                              textColor: Colors.grey,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: controller.classes.length,
              ),
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
        color: AppColors.backGroundColor,
        size: 50.0,
      ),
    );
  }
}
