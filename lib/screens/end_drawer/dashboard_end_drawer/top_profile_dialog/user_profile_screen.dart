import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/screens/end_drawer/lessons_end_drawer/selected_semester_controller.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';

import 'user_profile/user_profile_controller.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  XFile? xFile;
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  final TextEditingController _nameProfileController = TextEditingController();
  final FocusNode _nameProfileFocusNode = FocusNode();

  final TextEditingController _schoolController = TextEditingController();
  final FocusNode _schoolFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  final UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());

  final SelectedGenderController controllerGender =
      Get.put(SelectedGenderController());

  final FocusNode _focusNodeGender = FocusNode();
  Color borderColorGender = Colors.grey;

  Color borderColorCountry = Colors.grey;
  final FocusNode _focusNodeCountry = FocusNode();
  final SelectedCountryController controllerCountry =
      Get.put(SelectedCountryController());

  final TextEditingController mineController = TextEditingController();

  final FocusNode mineFocusNode = FocusNode();

  static final GlobalKey<FormState> _keyProfile = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    updateProfileController.loadInitialProfile();

    _focusNodeGender.addListener(() {
      setState(() {
        borderColorGender = _focusNodeGender.hasFocus
            ? const Color(0xff7367f0) // Change to desired color on focus
            : Colors.grey; // Revert to default color
      });
    });
    _focusNodeCountry.addListener(() {
      setState(() {
        borderColorCountry = _focusNodeCountry.hasFocus
            ? const Color(0xff7367f0) // Change to desired color on focus
            : Colors.grey; // Revert to default color
      });
    });
  }

  final errorNameMessage = RxString('');
  final errorPhoneMessage = RxString('');
  final errorEmailMessage = RxString('');
  final errorPassMessage = RxString('');
  final errorConPassMessage = RxString('');

  void _cancelChanges() {
    _emailController.text = updateProfileController.email.value;
    _phoneController.text = updateProfileController.phoneNumber.value;
    _nameProfileController.text = updateProfileController.fullName.value;
    errorNameMessage.value = "";
    errorPhoneMessage.value = "";
    errorEmailMessage.value = "";
    errorPassMessage.value = "";
    errorConPassMessage.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const EndDrawerView(),
        appBar: CustomProfileAppBar(),
        body: Obx(() {
          _emailController.text = updateProfileController.email.value;
          _phoneController.text = updateProfileController.phoneNumber.value;
          _nameProfileController.text = updateProfileController.fullName.value;
          _schoolController.text=updateProfileController.schoolName.value;
          mineController.text=updateProfileController.aboutMe.value;
          // controllerGender.selectedGender.value=updateProfileController.gender.value;
          return SingleChildScrollView(
            child: Form(
              key: _keyProfile,
              child: SizedBox(
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      width: 100.w,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
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
                                  textContent: 'الملف الشخصي',
                                  fontSize: 14.sp,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                width: 5.w,
                              ),
                              Icon(
                                Icons.person_outline,
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: 100.w,
                            padding: const EdgeInsets.all(16),
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 35.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: CommonViews()
                                                .customClickableContainer(
                                                    onTap: () {
                                                      _getProfileImageView();
                                                    },
                                                    color:
                                                        const Color(0xff7367f0),
                                                    width: 13.w,
                                                    colorBorder:
                                                        Colors.transparent,
                                                    radius: 5,
                                                    height: 4.h,
                                                    child: const Icon(
                                                      Icons
                                                          .file_upload_outlined,
                                                      color: Colors.white,
                                                    )),
                                          ),
                                          CommonViews().customText(
                                              textColor: Colors.grey,
                                              textAlign: TextAlign.left,
                                              withFontFamily: false,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              textContent:
                                                  '، PNG أو JPG يُسمح'),
                                          CommonViews().customText(
                                              textColor: Colors.grey,
                                              textAlign: TextAlign.left,
                                              withFontFamily: false,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              textContent:
                                                  '   والحجم الأقصى هو'),
                                          CommonViews().customText(
                                              textColor: Colors.grey,
                                              textAlign: TextAlign.left,
                                              withFontFamily: false,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              textContent:
                                                  '         800 كيلوبايت'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    xFile == null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              avatarImage,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              height: 15.h,
                                              File(xFile!.path),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                CommonViews().customText(
                                    textContent: 'الاسم الكامل',
                                    fontSize: 11.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                CommonViews().createTextFormField(
                                    controller: _nameProfileController,
                                    focusNode: _nameProfileFocusNode,
                                    keyboardType: TextInputType.multiline,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    onSubmitted: (v) {
                                      _emailFocusNode.requestFocus();
                                    },
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        errorNameMessage.value =
                                            "يرجى ادخال الاسم الثلاثي";
                                        return "";
                                      }
                                      return null;
                                    },
                                    errorBorderColor: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    borderColor: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    fillColor: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    radius: 5),
                                SizedBox(height: 2.h),
                                CommonViews().customText(
                                    textContent: 'البريد الإلكتروني',
                                    fontSize: 11.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                CommonViews().createTextFormField(
                                    controller: _emailController,
                                    focusNode: _emailFocusNode,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    keyboardType: TextInputType.emailAddress,
                                    onSubmitted: (v) {
                                      _phoneFocusNode.requestFocus();
                                    },
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        errorEmailMessage.value =
                                            "يرجى التحقق من البريد الإلكتروني";
                                        return "";
                                      }
                                      if (v.length < 5) {
                                        errorEmailMessage.value =
                                            "يرجى التحقق من البريد الإلكتروني";
                                        return "";
                                      }
                                      if (v.contains(" ")) {
                                        errorEmailMessage.value =
                                            "يرجى التحقق من البريد الإلكتروني";
                                        return "";
                                      }
                                      if (!isValidEmail(v)) {
                                        errorEmailMessage.value =
                                            "يرجى التحقق من البريد الإلكتروني";
                                        return "";
                                      }
                                      return null;
                                    },
                                    errorBorderColor: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    borderColor: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    fillColor: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    radius: 5),
                                SizedBox(height: 2.h),
                                CommonViews().customText(
                                    textContent: 'رقم الهاتف',
                                    fontSize: 11.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                CommonViews().createTextFormField(
                                  controller: _phoneController,
                                  focusNode: _phoneFocusNode,
                                  keyboardType: TextInputType.phone,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  onSubmitted: (v) {
                                    _schoolFocusNode.requestFocus();
                                  },
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      errorPhoneMessage.value =
                                          "يرجى التحقق من رقم الهاتف";
                                      return "";
                                    }
                                    if (v.length < 10) {
                                      errorPhoneMessage.value =
                                          "يرجى التحقق من رقم الهاتف";
                                      return "";
                                    }
                                    if (v.length > 10) {
                                      errorPhoneMessage.value =
                                          "يرجى التحقق من رقم الهاتف";
                                      return "";
                                    }
                                    if (v.contains(" ")) {
                                      errorPhoneMessage.value =
                                          "يرجى التحقق من رقم الهاتف";
                                      return "";
                                    }
                                    if (!v.startsWith("07")) {
                                      errorPhoneMessage.value =
                                          "يرجى التحقق من رقم الهاتف";
                                      return "";
                                    }
                                    return null;
                                  },
                                  errorBorderColor: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                  borderColor: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                  fillColor: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  radius: 5,
                                ),
                                SizedBox(height: 2.h),
                                CommonViews().customText(
                                    textContent: 'اسم المدرسة',
                                    fontSize: 11.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                CommonViews().createTextFormField(
                                    controller: _schoolController,
                                    focusNode: _schoolFocusNode,
                                    hint: 'اسم المدرسة',
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    keyboardType: TextInputType.multiline,
                                    onSubmitted: (v) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    borderColor: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    fillColor: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    radius: 5),
                                SizedBox(height: 1.h),
                                CommonViews().customText(
                                    textContent:
                                        'الجنس (هذه المعلومة لن تظهر في ملفك الشخصي)',
                                    fontSize: 11.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                SizedBox(height: 1.h),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      focusNode: _focusNodeGender,
                                      // Attach FocusNode to detect interaction
                                      isExpanded: true,
                                      hint: CommonViews().customText(
                                        textContent: controllerGender
                                            .selectedGender.value,
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .displayLarge
                                            ?.color,
                                        fontSize: 14.sp,
                                      ),
                                      items: controllerGender
                                          .getGenderList()
                                          .map((item) {
                                        final isSelected = item ==
                                            controllerGender
                                                .selectedGender.value;

                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Container(
                                            width: double.infinity,
                                            // Ensure full horizontal width
                                            height: 40,
                                            // Item height
                                            color: isSelected
                                                ? Colors.blue.shade200
                                                : Colors.transparent,
                                            // Color based on selection
                                            alignment: Alignment.topRight,
                                            child: CommonViews().customText(
                                              textContent: item,
                                              textAlign: TextAlign.right,
                                              textColor: isSelected
                                                  ? Theme.of(context)
                                                      .scaffoldBackgroundColor
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color,
                                              fontSize: 14.sp,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      value:
                                          controllerGender.selectedGender.value,
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          controllerGender.selectValue(value);
                                        }
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 5.h,
                                        width: 100.w,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: borderColorGender,
                                            // Use the state variable for border color
                                            width: 2,
                                          ),
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor,
                                        ),
                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Theme.of(context)
                                              .textTheme
                                              .displayLarge
                                              ?.color,
                                          size: 22,
                                        ),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 16.h,
                                        width: 100.w - 58,
                                        padding: EdgeInsets.zero,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 2),
                                        ),
                                        offset: const Offset(0, 1),
                                      ),
                                      selectedItemBuilder: (context) {
                                        return controllerGender
                                            .getGenderList()
                                            .map((item) {
                                          return CommonViews().customText(
                                            textContent: item,
                                            textColor: Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .color,
                                            fontSize: 14.sp,
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                CommonViews().customText(
                                    textContent: 'البلد',
                                    fontSize: 11.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      focusNode: _focusNodeCountry,
                                      // Attach FocusNode to detect interaction
                                      isExpanded: true,
                                      hint: CommonViews().customText(
                                        textContent: controllerCountry
                                            .selectedValue.value,
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .displayLarge
                                            ?.color,
                                        fontSize: 14.sp,
                                      ),
                                      items: controllerCountry
                                          .getCountryList()
                                          .map((item) {
                                        final isSelected = item ==
                                            controllerCountry
                                                .selectedValue.value;

                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Container(
                                            width: double.infinity,
                                            // Ensure full horizontal width
                                            height: 40,
                                            // Item height
                                            color: isSelected
                                                ? Colors.blue.shade200
                                                : Colors.transparent,
                                            // Color based on selection
                                            alignment: Alignment.topRight,
                                            child: CommonViews().customText(
                                              textContent: item,
                                              textAlign: TextAlign.right,
                                              textColor: isSelected
                                                  ? Theme.of(context)
                                                      .scaffoldBackgroundColor
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color,
                                              fontSize: 14.sp,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      value:
                                          controllerCountry.selectedValue.value,
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          controllerCountry.selectCountry(value);
                                        }
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 5.h,
                                        width: 100.w,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: borderColorCountry,
                                            // Use the state variable for border color
                                            width: 2,
                                          ),
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor,
                                        ),
                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Theme.of(context)
                                              .textTheme
                                              .displayLarge
                                              ?.color,
                                          size: 22,
                                        ),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 23.h,
                                        width: 100.w - 58,
                                        padding: EdgeInsets.zero,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor,
                                          border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 2),
                                        ),
                                        offset: const Offset(0, 1),
                                      ),
                                      selectedItemBuilder: (context) {
                                        return controllerCountry
                                            .getCountryList()
                                            .map((item) {
                                          return CommonViews().customText(
                                            textContent: item,
                                            textColor: Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .color,
                                            fontSize: 14.sp,
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                CommonViews().customText(
                                    textContent: 'عرفنا عن نفسك',
                                    fontSize: 11.sp,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                    textAlign: TextAlign.right),
                                SizedBox(height: 1.h),
                                CommonViews().createTextFormField(
                                  controller: mineController,
                                  focusNode: mineFocusNode,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  onSubmitted: (v) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  hint:
                                      'أكتب عن نفسك ما تحب ان يراه طلاب جو ستيودنتس',
                                  keyboardType: TextInputType.multiline,
                                  borderColor: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                  fillColor: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  radius: 5,
                                  height: 10.h,
                                  maxLines: 10,
                                ),
                                SizedBox(height: 4.h),
                                Obx(() {
                                  if (errorNameMessage.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        errorNameMessage.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                      ),
                                    );
                                  }
                                  if (errorPhoneMessage.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        errorPhoneMessage.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                      ),
                                    );
                                  }
                                  if (errorEmailMessage.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        errorEmailMessage.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                      ),
                                    );
                                  }
                                  if (errorPassMessage.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        errorPassMessage.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                      ),
                                    );
                                  }
                                  if (errorConPassMessage.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        errorConPassMessage.value,
                                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                                SizedBox(height: 1.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(width: 3.w),

                                    // Cancel button
                                    CommonViews().customClickableContainer(
                                      onTap: () {
                                        _cancelChanges();
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
                                          textContent: 'الغاء',
                                          fontSize: 12.sp,
                                          textColor: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .color,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 3.w),

                                    // Save button
                                    CommonViews().customClickableContainer(
                                      onTap: () async {
                                        final int? userID =
                                            await General.getPrefInt(
                                                ConstantValues.ID);
                                        if (_keyProfile.currentState!
                                            .validate()) {
                                          await updateProfileController
                                              .updateProfile(
                                                  email: _emailController.text,
                                                  gender: controllerGender
                                                      .gender.value,
                                                  country: controllerCountry
                                                      .selectedValue.value,
                                                  phone: _phoneController.text,
                                                  name: _nameProfileController
                                                      .text,
                                                  pic: xFile?.path,
                                                  mine: mineController.text,
                                                  school:
                                                      _schoolController.text,
                                                  userID: userID.toString());
                                        }
                                      },
                                      radius: 5,
                                      width: 30.w,
                                      colorBorder: Colors.transparent,
                                      color: const Color(0xff7367f0),
                                      child: Center(
                                        child: CommonViews().customText(
                                          textContent: 'حفظ المعلومات',
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  bool isValidEmail(String value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  _getProfileImageView() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          child: Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonViews().customText(
                    textContent: "Chose Option",
                    fontSize: 16.sp,
                    textColor: Theme.of(context).textTheme.displayLarge!.color,
                    fontWeight: FontWeight.w600),
                SizedBox(height: 2.h),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                  title: CommonViews().customText(
                      textContent: "Camera",
                      fontSize: 11.sp,
                      textColor:
                          Theme.of(context).textTheme.displayLarge!.color,
                      fontWeight: FontWeight.w300),
                  onTap: () async {
                    await _pickImage(source: ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                  title: CommonViews().customText(
                      textContent: "Gallery",
                      fontSize: 11.sp,
                      textColor:
                          Theme.of(context).textTheme.displayLarge!.color,
                      fontWeight: FontWeight.w300),
                  onTap: () async {
                    await _pickImage(source: ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.cancel,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                  title: CommonViews().customText(
                      textContent: "Cancel",
                      fontSize: 11.sp,
                      textColor:
                          Theme.of(context).textTheme.displayLarge!.color,
                      fontWeight: FontWeight.w300),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _pickImage({required ImageSource source}) async {
    Navigator.of(context).pop();
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        xFile = pickedFile;
      });
    }
  }
}

//
// class ProfileForm extends StatefulWidget {
//   final String phone;
//   final String email;
//   final String school;
//   final String name;
//   final XFile? xFile;
//
//   ProfileForm({
//     super.key,
//     required this.phone,
//     required this.email,
//     required this.school,
//     required this.name,
//     this.xFile,
//   });
//
//   @override
//   State<ProfileForm> createState() => _ProfileFormState();
// }
//
// class _ProfileFormState extends State<ProfileForm> {
//   final SelectedGenderController controllerGender =
//       Get.put(SelectedGenderController());
//
//   final SelectedCountryController controllerCountry =
//       Get.put(SelectedCountryController());
//
//   final UpdateProfileController updateProfileController =
//       Get.find<UpdateProfileController>();
//
//   final TextEditingController mineController = TextEditingController();
//
//   final FocusNode mineFocusNode = FocusNode();
//
//
//   @override
//   Widget build(BuildContext context) {
//     updateProfileController.updateImage(widget.xFile);
//
//     return SizedBox(
//       width: 100.w,
//       child: Obx(() {
//         return Stack(
//           children: [
//             SizedBox(
//               width: 100.w,
//               height: MediaQuery.of(context).size.height * 0.60,
//             ),
//             Positioned(
//               top: 3,
//               right: 0,
//               left: 0,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 2,
//                     color: controllerGender.isExpanded.value
//                         ? const Color(0xff7367f0)
//                         : Colors.grey,
//                   ),
//                   borderRadius: const BorderRadius.all(Radius.circular(5)),
//                 ),
//                 child: InkWell(
//                   onTap: () {
//                     FocusScope.of(context).unfocus();
//                     controllerGender.toggleExpansion();
//                   },
//                   child: Row(
//                     children: [
//                       Icon(Icons.keyboard_arrow_down,
//                           color:
//                               Theme.of(context).textTheme.displayLarge!.color,
//                           size: 22),
//                       const Spacer(),
//                       CommonViews().customText(
//                         textContent: controllerGender.selectedGender.value,
//                         textColor:
//                             Theme.of(context).textTheme.displayLarge!.color,
//                         fontSize: 14.sp,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 8.h,
//               right: 3,
//               child: CommonViews().customText(
//                   textContent: 'البلد',
//                   fontSize: 11.sp,
//                   textColor: Theme.of(context).textTheme.displayLarge!.color,
//                   textAlign: TextAlign.right),
//             ),
//             Positioned(
//               top: 19.h,
//               right: 3,
//               child: CommonViews().customText(
//                   textContent: 'عرفنا عن نفسك',
//                   fontSize: 11.sp,
//                   textColor: Theme.of(context).textTheme.displayLarge!.color,
//                   textAlign: TextAlign.right),
//             ),
//             Positioned(
//               top: 22.h,
//               left: 0,
//               right: 0,
//               child: CommonViews().createTextFormField(
//                 controller: mineController,
//                 focusNode: mineFocusNode,
//                 hint: 'أكتب عن نفسك ما تحب ان يراه طلاب جو ستيودنتس',
//                 keyboardType: TextInputType.multiline,
//                 borderColor: Theme.of(context).textTheme.titleMedium!.color,
//                 fillColor: Theme.of(context).appBarTheme.backgroundColor,
//                 radius: 5,
//                 height: 10.h,
//                 maxLines: 10,
//               ),
//             ),
//             Positioned(
//               right: 0,
//               bottom: 20.h,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   SizedBox(width: 3.w),
//
//                   // Cancel button
//                   CommonViews().customClickableContainer(
//                     onTap: () {
//                       // Logic for 'Cancel' action
//                       Navigator.of(context).pop(); // Example: close the form
//                     },
//                     radius: 5,
//                     width: 20.w,
//                     colorBorder: Colors.transparent,
//                     color: Theme.of(context).textTheme.titleSmall!.color,
//                     child: Center(
//                       child: CommonViews().customText(
//                         textContent: 'الغاء',
//                         fontSize: 12.sp,
//                         textColor:
//                             Theme.of(context).textTheme.titleMedium!.color,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 3.w),
//
//                   // Save button
//                   CommonViews().customClickableContainer(
//                     onTap: () async {
//                       final int? userID =
//                           await General.getPrefInt(ConstantValues.ID);
//
//                       // Create an UpdateProfileRequest instance with the input data
//                       await updateProfileController.updateProfile(
//                           email: widget.email,
//                           gender: controllerGender.gender.value,
//                           country: controllerCountry.selectedValue.value,
//                           phone: widget.phone,
//                           name: widget.name,
//                           pic: widget.xFile?.path??'',
//                           mine: mineController.text,
//                           school: widget.school,
//                           userID: userID.toString());
//                     },
//                     radius: 5,
//                     width: 30.w,
//                     colorBorder: Colors.transparent,
//                     color: const Color(0xff7367f0),
//                     child: Center(
//                       child: CommonViews().customText(
//                         textContent: 'حفظ المعلومات',
//                         fontSize: 12.sp,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 11.h,
//               left: 0,
//               right: 2,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 2,
//                     color: controllerCountry.isExpanded.value
//                         ? const Color(0xff7367f0)
//                         : Colors.grey,
//                   ),
//                   borderRadius: const BorderRadius.all(Radius.circular(5)),
//                 ),
//                 child: InkWell(
//                   onTap: () {
//                     FocusScope.of(context).unfocus();
//                     controllerCountry.toggleExpansion();
//                   },
//                   child: Row(
//                     children: [
//                       Icon(Icons.keyboard_arrow_down,
//                           color:
//                               Theme.of(context).textTheme.displayLarge!.color,
//                           size: 22),
//                       const Spacer(),
//                       CommonViews().customText(
//                         textContent: controllerCountry.selectedValue.value,
//                         textColor:
//                             Theme.of(context).textTheme.displayLarge!.color,
//                         fontSize: 14.sp,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             controllerGender.isExpanded.value
//                 ? Positioned(
//                     top: 6.h,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border:
//                             Border.all(color: Colors.grey.shade300, width: 2),
//                       ),
//                       child: Column(
//                         children: SelectedGenderController.genderList
//                             .map(
//                               (e) => InkWell(
//                                 onTap: () {
//                                   controllerGender.selectValue(e);
//                                   print(controllerGender.selectedGender.value);
//                                   print(controllerGender.gender.value);
//                                 },
//                                 child: Container(
//                                   width: 100.w,
//                                   height: 6.h,
//                                   decoration: BoxDecoration(
//                                     color:
//                                         controllerGender.selectedGender.value ==
//                                                 e
//                                             ? Colors.blue.shade200
//                                             : Theme.of(context)
//                                                 .textTheme
//                                                 .displayMedium!
//                                                 .color,
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Align(
//                                       alignment: Alignment.topRight,
//                                       child: CommonViews().customText(
//                                           textContent: e,
//                                           textColor: controllerGender
//                                                       .selectedGender.value ==
//                                                   e
//                                               ? Theme.of(context)
//                                                   .scaffoldBackgroundColor
//                                               : Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge!
//                                                   .color,
//                                           fontSize: 14.sp),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//             controllerCountry.isExpanded.value
//                 ? Positioned(
//                     top: 17.h,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border:
//                             Border.all(color: Colors.grey.shade300, width: 2),
//                       ),
//                       child: Column(
//                         children: SelectedCountryController.countryList
//                             .map(
//                               (e) => InkWell(
//                                 onTap: () {
//                                   controllerCountry.selectValue(e);
//                                   print(controllerCountry.selectedValue.value);
//                                 },
//                                 child: Container(
//                                   width: 90.w,
//                                   decoration: BoxDecoration(
//                                     color:
//                                         controllerCountry.selectedValue.value ==
//                                                 e
//                                             ? Colors.blue.shade200
//                                             : Theme.of(context)
//                                                 .textTheme
//                                                 .displayMedium!
//                                                 .color,
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Align(
//                                       alignment: Alignment.topRight,
//                                       child: CommonViews().customText(
//                                           textContent: e,
//                                           textColor: controllerCountry
//                                                       .selectedValue.value ==
//                                                   e
//                                               ? Theme.of(context)
//                                                   .scaffoldBackgroundColor
//                                               : Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge!
//                                                   .color,
//                                           fontSize: 14.sp),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ],
//         );
//       }),
//     );
//   }
//
//   // Form validation method
//   bool _validateProfileForm(BuildContext context) {
//     if (widget.phone.length > 10 && widget.phone.length < 10) {
//       return false;
//     }
//     return true;
//   }
// }
