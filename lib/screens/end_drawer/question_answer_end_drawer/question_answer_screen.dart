// ignore_for_file: must_be_immutable
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/curriculums/curriculums_controller.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_notification_dialog/notification_controller.dart';
import 'package:jo_students/screens/end_drawer/end_drawer_view.dart';
import 'package:jo_students/screens/end_drawer/question_answer_end_drawer/delete_question/delete_question_controller.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:jo_students/utils/ui/custom_profile_app_bar.dart';
import 'package:sizer/sizer.dart';

import 'add_questions/add_question_controller.dart';
import 'my_question/my_question_controller.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({super.key});

  @override
  State<QuestionAnswerScreen> createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  final DateFormat formatter = DateFormat('HH:mm:ss dd/MM/yyyy');
  final MyQuestionController myQuestionController =
      Get.put(MyQuestionController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result)  async {
        Get.delete<NotificationController>();
        Get.delete<MyQuestionController>();
      },
      child: SafeArea(
        child: Scaffold(
          endDrawer: const EndDrawerView(),
          appBar: CustomProfileAppBar(),
          body: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: SingleChildScrollView(
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
                                  textContent: 'س / ج',
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
                          SizedBox(height: 1.h),
                          Align(
                            alignment: Alignment.topRight,
                            child: CommonViews().customText(
                                textContent:
                                    'احصل على إجابة مضمونة لحل اسئلة موادك الدراسية',
                                fontSize: 13.sp,
                                textColor:
                                    Theme.of(context).textTheme.bodyMedium!.color,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 2.h),
                          CommonViews().customText(
                              textContent:
                                  'هل لديك سؤال بمادة معينة؟ شارك سؤالك حتى',
                              fontSize: 13.sp,
                              textColor:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                              fontWeight: FontWeight.w400),
                          CommonViews().customText(
                              textContent: 'يساعدك بحله أحد معلمين جو ستيودنتس',
                              fontSize: 13.sp,
                              textColor:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                              fontWeight: FontWeight.w400),
                          SizedBox(height: 2.h),
                          CommonViews().customClickableContainer(
                            onTap: () {
                              showAddQuestionPopup(context);
                            },
                            radius: 5,
                            width: 30.w,
                            color: const Color(0xff7367f0),
                            colorBorder: const Color(0xff7367f0),
                            child: Center(
                              child: CommonViews().customText(
                                  textContent: 'أضف سؤالك',
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
                                _myQuestionView(),
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
      ),
    );
  }

  Widget _myQuestionView() {
    return Obx(() {
      if (myQuestionController.isLoading) {
        return _getLoadingView();
      }
      if (myQuestionController.isError) {
        return Center(
          child: CommonViews().customText(
            textContent: "An Error Occurred Make Sure You Are Connected To The Internet",
            withFontFamily: false,
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 11.sp,
          ),
        );
      }
      if (myQuestionController.isEmpty) {
        return Center(
          child: CommonViews().customText(
            textContent: "!! لا يوجداسئلة ليتم عرضها",
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 15.sp,
          ),
        );
      }
      if (myQuestionController.isSuccess) {
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
            mainAxisSize: MainAxisSize.min,
            children:
                List.generate(myQuestionController.myQuestions.length, (index) {
              var item = myQuestionController.myQuestions[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      deleteQuestionPopup(
                        context: context,
                        userId: item.studentId,
                        questionId: item.studentQuestionId,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: item.isHasAnswer >0
                                ? Theme.of(context).textTheme.labelMedium!.color
                                : null,
                            border: Border.all(color: Colors.transparent)
                        ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          item.isHasAnswer>0
                              ? const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(bulbLightGreenImage),
                                  backgroundColor: Colors.transparent,
                                  radius: 24,
                                )
                              : const CircleAvatar(
                                  backgroundImage: AssetImage(bulbLightImage),
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
                                textContent: item.subjectTitleAr,
                                fontSize: 13.sp,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color,
                              ),
                              CommonViews().customText(
                                textContent:
                                    "${item.classTitleAr} - ${item.semesterTitleAr}",
                                fontSize: 12.sp,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color,
                              ),
                              CommonViews().customText(
                                textContent: item.messageText,
                                fontSize: 11.sp,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color,
                              ),
                              CommonViews().customText(
                                textContent: formatter.format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(item.messageDt))),
                                withFontFamily: false,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index != myQuestionController.myQuestions.length - 1)
                  Divider(
                    height: 1.0,
                    thickness: 1.0,
                  color: Theme.of(context).textTheme.bodySmall!.color ?? Colors.black,
                  ),
                ],
              );
            }),
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
}

//ADD QUESTION

class AddQuestionPopup extends StatefulWidget {
  const AddQuestionPopup({super.key});

  @override
  State<AddQuestionPopup> createState() => _AddQuestionPopupState();
}

class _AddQuestionPopupState extends State<AddQuestionPopup> {
  final TextEditingController questionController = TextEditingController();
  final FocusNode questionFocusNode = FocusNode();
  final GlobalKey<FormState> _key = GlobalKey();
  var selectedSubject = 1.obs;
  final CurriculumsController controllerCurriculums = Get.find();
  final AddQuestionController addQuestionController =
      Get.put(AddQuestionController());

  @override
  void initState() {
    super.initState();
    if (controllerCurriculums.curriculums.isNotEmpty) {
      selectedSubject.value = controllerCurriculums.curriculums.first.subjectId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).appBarTheme.backgroundColor,
        ),
        width: 90.w,
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 2.h),
              CommonViews().customText(
                textContent: 'احصل على إجابة مضمونة لحل اسئلة موادك الدراسية',
                fontSize: 15.sp,
                textColor: Theme.of(context).textTheme.displayLarge!.color,
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 2.h),
              CommonViews().customText(
                textContent: 'ماذا تريد ان تسأل',
                fontSize: 11.sp,
                textColor: Theme.of(context).textTheme.displayLarge!.color,
                textAlign: TextAlign.right,
              ),
              CommonViews().createTextFormField(
                controller: questionController,
                focusNode: questionFocusNode,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "يرجى ملء هذا الحقل";
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                borderColor: Theme.of(context).textTheme.titleMedium!.color,
                fillColor: Theme.of(context).appBarTheme.backgroundColor,
                textColor: Theme.of(context).textTheme.bodyLarge!.color,
                radius: 5,
                height: 10.h,
                maxLines: 10,
                inputAction: TextInputAction.done,
              ),
              CommonViews().customText(
                textContent: 'اختر المادة',
                fontSize: 11.sp,
                textColor: Theme.of(context).textTheme.displayLarge!.color,
                textAlign: TextAlign.right,
              ),
              Directionality(
                textDirection: ui.TextDirection.rtl,
                child: Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: controllerCurriculums.curriculums.map((item) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35.w,
                              child: RadioListTile<int>(
                                contentPadding: EdgeInsets.zero,
                                title: CommonViews().customText(
                                  textContent: item.subjectTitleAr,
                                  fontSize: 11.sp,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                ),
                                value: item.subjectId,
                                groupValue: selectedSubject.value,
                                onChanged: (value) {
                                  selectedSubject.value = value!;
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 3.w),
                    CommonViews().customClickableContainer(
                      onTap: () {
                        if (_key.currentState!.validate()) {
                          addQuestionController.addQuestion(
                              txtchkid: selectedSubject.value,
                              txtMessage: questionController.text);
                        }
                      },
                      radius: 5,
                      width: 30.w,
                      colorBorder: Colors.transparent,
                      color: const Color(0xff7367f0),
                      child: Center(
                        child: CommonViews().customText(
                          textContent: 'أضف سؤالك',
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showAddQuestionPopup(BuildContext context) {
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
              top: 1.h, right: 1, left: 1, child: const AddQuestionPopup()),
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

//DELETE QUESTION

void deleteQuestionPopup({
  required BuildContext context,
  required int userId,
  required int questionId,
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
              child: DeleteQuestionPopup(
                userId: userId,
                questionId: questionId,
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

class DeleteQuestionPopup extends StatefulWidget {
  int questionId;
  int userId;


  DeleteQuestionPopup(
      {super.key,
        required this.userId,
        required this.questionId
      });

  @override
  State<DeleteQuestionPopup> createState() => _DeleteQuestionPopupState();
}

class _DeleteQuestionPopupState extends State<DeleteQuestionPopup> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final FocusNode questionFocusNode = FocusNode();
  final FocusNode answerFocusNode = FocusNode();
  final DateFormat formatter = DateFormat('HH:mm:ss dd/MM/yyyy');
  final MyQuestionController myQuestionController =
      Get.put(MyQuestionController());

  final CurriculumsController controllerCurriculums = Get.find();

  final DeleteQuestionController deleteQuestionController =
      DeleteQuestionController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    await myQuestionController.fetchMyQuestionById(
        userID: widget.userId, quesID: widget.questionId);

      final item = myQuestionController.myQuestionID.first;

      if (item.answerMessageText.isNotEmpty) {
        answerController.text = item.answerMessageText;
      } else {
        answerController.text = "لا يوجد رد حتى الاّن";
      }
      questionController.text = item.messageText;

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
              textContent: "سؤالي",
              fontSize: 16.sp,
              textColor: Theme.of(context).textTheme.displayLarge!.color,
            ),
            SizedBox(height: 2.h),
            _questionIdView(),
          ],
        ),
      ),
    );
  }

  Widget _questionIdView() {
    return Obx(() {
      if (myQuestionController.isLoading) {
        return _getLoadingView();
      }
      if (myQuestionController.isError) {
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
      if (myQuestionController.isEmpty) {
        return Center(
          child: CommonViews().customText(
            textContent: "!! لا يوجداسئلة ليتم عرضها",
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
            fontSize: 15.sp,
          ),
        );
      }
      if (myQuestionController.isSuccess) {
        return Column(
          children: myQuestionController.myQuestionID.map((item) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonViews().customText(
                  textContent: "${item.subjectTitleAr}-الفصل الاول",
                  fontSize: 12.sp,
                  textColor: Theme.of(context).textTheme.displayLarge!.color,
                ),
                CommonViews().customText(
                  textContent:
                      " تاريخ السؤال : ${formatter.format(DateTime.fromMillisecondsSinceEpoch(int.parse(item.messageDt)))}",
                  fontSize: 12.sp,
                  withFontFamily: false,
                  textColor: Theme.of(context).textTheme.displayLarge!.color,
                ),
                SizedBox(height: 1.h),
                CommonViews().customText(
                  textContent: "السؤال",
                  textColor: Theme.of(context).textTheme.displayLarge!.color,
                ),
                SizedBox(height: 1.h),
                CommonViews().createTextFormField(
                  controller: questionController,
                  focusNode: questionFocusNode,
                  readOnly: true,
                  keyboardType: TextInputType.multiline,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  borderColor: Theme.of(context).textTheme.titleMedium!.color,
                  fillColor: Theme.of(context).textTheme.titleSmall!.color,
                  radius: 5,
                  height: 10.h,
                  maxLines: 10,
                ),
                SizedBox(height: 2.h),
                CommonViews().customText(
                  textContent: "الجواب",
                  textColor: Theme.of(context).textTheme.displayLarge!.color,
                ),
                SizedBox(height: 1.h),
                CommonViews().createTextFormField(
                  controller: answerController,
                  focusNode: answerFocusNode,
                  readOnly: true,
                  keyboardType: TextInputType.multiline,
                  borderColor: Theme.of(context).textTheme.titleMedium!.color,
                  fillColor: Theme.of(context).textTheme.titleSmall!.color,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  radius: 5,
                  height: 10.h,
                  maxLines: 10,
                  inputAction: TextInputAction.done,
                ),
                SizedBox(height: 2.h),
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
                    SizedBox(width: 1.w),
                    CommonViews().customClickableContainer(
                      onTap: () async {
                        String loginTrx =
                            await General.getPrefString(ConstantValues.MSG, "");
                        await deleteQuestionController.checkUser(
                            loginTrx: loginTrx);
                        await deleteQuestionController.deleteQuestion(
                            questionId: item.studentQuestionId);
                      },
                      radius: 5,
                      width: 30.w,
                      colorBorder: Colors.transparent,
                      color: const Color(0xffff4c51),
                      child: Center(
                        child: CommonViews().customText(
                          textContent: 'حذف السؤال',
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                  ],
                ),
              ],
            );
          }).toList(),
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
}


