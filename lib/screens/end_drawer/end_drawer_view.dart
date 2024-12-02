import 'package:jo_students/check_user/check_user_controller.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:jo_students/configuration/app_images.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/curriculums/curriculums_controller.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_classes_dialog/class_name/class_name_controller.dart';
import 'package:jo_students/screens/end_drawer/games_end_drawer/games_screen.dart';
import 'package:jo_students/screens/end_drawer/helper_end_drawer/helper_screen.dart';
import 'package:jo_students/screens/end_drawer/live_class_end_drawer/live_class_controller.dart';
import 'package:jo_students/screens/login/login_screen.dart';
import 'package:jo_students/screens/theme/theme_controller.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:jo_students/utils/ui/common_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dashboard_end_drawer/dashboard_screen.dart';
import 'dashboard_end_drawer/top_notification_dialog/notification_controller.dart';
import 'lessons_end_drawer/lessons_screen.dart';
import 'lessons_end_drawer/specific_subject/specific_lessons_card/specific_lessons_card_controller.dart';
import 'lessons_end_drawer/specific_subject/specific_subject_workbooks/specific_workbooks_controller.dart';
import 'library_end_drawer/library_screen.dart';
import 'live_class_end_drawer/live_class_screen.dart';
import 'question_answer_end_drawer/add_questions/add_question_controller.dart';
import 'question_answer_end_drawer/my_question/my_question_controller.dart';
import 'question_answer_end_drawer/question_answer_screen.dart';
import 'reviews_end_drawer/my_reviews_list/my_reviews_controller.dart';
import 'reviews_end_drawer/reviews_screen.dart';
import 'settings_end_drawer/settings_screen.dart';
import 'subscription_end_drawer/subscription_screen.dart';
import 'subscription_end_drawer/subscription_table/subscription_controller.dart';

class EndDrawerView extends StatefulWidget {
  const EndDrawerView({super.key});

  @override
  State<EndDrawerView> createState() => _EndDrawerViewState();
}

class _EndDrawerViewState extends State<EndDrawerView> {
  final List<MenuModel> _menuItem = [];
  final ThemeToggleController controller = Get.find<ThemeToggleController>();

  @override
  void initState() {
    super.initState();
    _fillMenuItem();
    _loadSelectedItem();
    Get.delete<SpecificCardDetailsController>();
    Get.delete<WorkBooksController>();
    Get.delete<NotificationController>();
    Get.delete<MyQuestionController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68.w,
      height:MediaQuery.of(context).size.height,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10.h,
            padding: const EdgeInsets.all(16),
            child:controller.isNightMode.value ? Image.asset(
              fit: BoxFit.cover,
              appLogo,
            ): Image.asset(
              fit: BoxFit.cover,
              appLogo,
              color: AppColors.backGroundColor,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _menuItem.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      _changeItem(index);
                      Navigator.of(context).pop();
                      if (_menuItem[index].onTap != null) {
                        _menuItem[index].onTap!();
                      } else {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                        ]);
                        FocusScope.of(context).unfocus();
                        AppNavigator.of(context).pushAndRemoveUntil(_menuItem[index].view!);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 6.h,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(3),
                      child: _menuItem[index].isSelected
                          ? Container(
                              width: 90.w,
                              height: 6.h,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: const Color(0xff7367f0),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CommonViews().customText(
                                      textContent: _menuItem[index].name,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Image.asset(
                                      _menuItem[index].icon,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              width: 90.w,
                              height: 6.h,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: null,
                                borderRadius: null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CommonViews().customText(
                                      textContent: _menuItem[index].name,
                                      fontSize: 13.sp,
                                      textColor:  Theme.of(context).textTheme.displayLarge!.color,
                                      fontWeight: FontWeight.w500),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Image.asset(
                                      _menuItem[index].icon,
                                      color:  Theme.of(context).textTheme.displayLarge!.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void _fillMenuItem() {
    _menuItem.addAll(
      [
        MenuModel(
            name: 'الرئيسية',
            view: const DashboardScreen(),
            isSelected: true,
            icon: oneMenuImage),
        MenuModel(
            name: 'الدروس', view:  LessonsCard(), icon: towMenuImage),
        MenuModel(
            name: 'سين/جيم',
            view:  const QuestionAnswerScreen(),
            icon: threeMenuImage),
        MenuModel(
            name: 'حصص مباشرة',
            view:  LiveClassScreen(),
            icon: fourMenuImage),
        MenuModel(
            name: 'مراجعات', view: const ReviewsScreen(), icon: fiveMenuImage),
        MenuModel(
            name: 'المكتبة', view: const LibraryScreen(), icon: sevenMenuImage),
        MenuModel(
            name: 'الالعاب', view: const GameScreen(), icon: sixMenuImage),
        MenuModel(
            name: 'اشتراكي',
            view:  const SubscriptionScreen(),
            icon: eightMenuImage),
        MenuModel(
            name: 'اعدادات',
            view: const SettingsScreen(),
            icon: nineMenuImage),
        MenuModel(
            name: 'مساعدة',
            view:  const HelperScreen(),
            icon: tenMenuImage),
        MenuModel(name: 'خروج',
            onTap: _logOutMethod,
            icon: elevenMenuImage),
      ],
    );
  }

  void _changeItem(int index) {
    setState(() {
      for (var element in _menuItem) {
        element.isSelected = false;
      }
      _menuItem[index].isSelected = true;
    });
    _saveSelectedItem(index);
  }

  Future<void> _saveSelectedItem(int index) async {
    General.savePrefInt(ConstantValues.selectedIndexKey, index);
  }

  Future<void> _loadSelectedItem() async {
    int? selectedIndex =
        await General.getPrefInt(ConstantValues.selectedIndexKey);
    setState(() {
      for (var element in _menuItem) {
        element.isSelected = false;
      }
      _menuItem[selectedIndex!].isSelected = true;
    });
  }

  _logOutMethod() {
    Get.delete<ClassNameController>();
    Get.delete<CurriculumsController>();
    Get.delete<CheckUserController>();
    Get.delete<LiveClassController>();
    Get.delete<AddQuestionController>();
    Get.delete<MyQuestionController>();
    Get.delete<MyReviewsController>();
    Get.delete<SubscriptionController>();
    Get.delete<SearchLiveController>();
    Get.delete<SearchSubController>();
    Get.delete<NotificationController>();
    General.remove(ConstantValues.ID);
    General.remove(ConstantValues.MSG);
    General.remove(ConstantValues.showSubscriptionButton);
    General.remove(ConstantValues.NAME);
    General.remove(ConstantValues.EMAIL);
    General.remove(ConstantValues.PHONE);
    General.savePrefInt(ConstantValues.selectedIndexKey, 0);
    AppNavigator.of(context).pushAndRemoveUntil(const LoginScreen());

  }
}

class MenuModel {
  String name;
  bool isSelected;
  Widget? view;
  String icon;
  VoidCallback? onTap;

  MenuModel({
    required this.name,
    required this.icon,
    this.isSelected = false,
    this.view,
    this.onTap,
  });
}
