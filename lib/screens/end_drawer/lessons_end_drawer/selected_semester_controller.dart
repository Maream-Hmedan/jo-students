import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:get/get.dart';
import 'package:jo_students/screens/curriculums/curriculums_controller.dart';
import 'package:jo_students/screens/end_drawer/subscription_end_drawer/basic_subscription/basic_card_screen.dart';
import 'package:jo_students/utils/helpers/app_navigation.dart';

class SelectedSemesterController extends GetxController {
  var isExpanded = false.obs;
  var selectedValue = 'الفصل الاول'.obs;

  static const List<String> semesterList = [
    'الفصل الاول',
    'الفصل الثاني',
  ];

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  void selectValue({required String value,required bool allowPop}) {
    selectedValue.value = value;
    isExpanded.value = false;
    if(allowPop){
      AppNavigator.of(Get.context!).pop();
    }
  }
}

class SelectedGenderController extends GetxController {
  var isExpanded = false.obs;

  var selectedGender = 'ذكر'.obs;

  var gender = 1.obs;

  static const List<String> genderList = [
    'ذكر',
    'انثى',
  ];

  @override
  void onInit() {
    super.onInit();
    loadGenderFromPreferences();
  }
  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }
  void selectValue(String value) {
    selectedGender.value = value;
    gender.value = getGenderIndex(value);
    isExpanded.value = false;

    saveGenderToPreferences(value);
  }
  List<String> getGenderList() {
    return genderList;
  }
  int getGenderIndex(String value) {
    switch (value) {
      case 'ذكر':
        return 1;
      case 'انثى':
        return 2;
      default:
        return 0;
    }
  }
  Future<void> saveGenderToPreferences(String gender) async {
    await General.savePrefString(ConstantValues.SELECTED_GENDER, gender);
  }
  Future<void> loadGenderFromPreferences() async {
    String savedGender = await General.getPrefString(ConstantValues.SELECTED_GENDER, 'ذكر');
    selectedGender.value = savedGender;
    gender.value = getGenderIndex(savedGender);
  }
}


class SelectedCountryController extends GetxController {
  var isExpanded = false.obs;
  var selectedValue = 'الأردن'.obs;
  var country = 1.obs;

  // Call this method when selecting a country
  void selectCountry(String value) {
    selectedValue.value = value;
    isExpanded.value = false;
    country.value = getCountryCode(value); // Get the corresponding country code
    saveSelectedCountry(value); // Save the selected country
  }

  static const List<String> countryList = [
    'الأردن',
    'فلسطين',
    'مصر',
    'العراق',
    'السعودية',
    'قطر',
    'الكويت',
    'المغرب',
  ];

  @override
  void onInit() {
    super.onInit();
    loadSelectedCountry(); // Load the saved country when initializing
  }

  // Toggle dropdown expansion
  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  // Get the list of countries
  List<String> getCountryList() {
    return countryList;
  }

  // Save the selected country in SharedPreferences
  Future<void> saveSelectedCountry(String value) async {
    await General.savePrefString(ConstantValues.SELECTED_COUNTRY, value); // Save the country as a string
  }

  // Load the selected country from SharedPreferences
  Future<void> loadSelectedCountry() async {
    String savedCountry = await General.getPrefString(
        ConstantValues.SELECTED_COUNTRY, 'الأردن');
    selectedValue.value = savedCountry;
    country.value = getCountryCode(savedCountry); // Set the country code based on the saved country
  }

  // Map country names to integer codes
  int getCountryCode(String value) {
    switch (value) {
      case 'الأردن':
        return 1;
      case 'فلسطين':
        return 2;
      case 'مصر':
        return 3;
      case 'العراق':
        return 4;
      case 'السعودية':
        return 5;
      case 'قطر':
        return 6;
      case 'الكويت':
        return 7;
      case 'المغرب':
        return 8;
      default:
        return 0; // Return 0 if the country is not found
    }
  }
}


class SelectedSubjectController extends GetxController {
  var isExpanded = false.obs;
  var selectedValue = 'يرجى اختيار المادة'.obs;
  var errorMessage = RxnString();


  var subjectList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    List<String> subjects = Get.find<CurriculumsController>()
        .curriculums
        .map((curriculum) => curriculum.subjectTitleAr)
        .toList();

    subjectList.assignAll(['يرجى اختيار المادة'] + subjects);
  }

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  void selectValue(String value) {
    selectedValue.value = value;
    errorMessage.value = null;
  }

  bool isSubjectSelected() {
    return selectedValue.value.isNotEmpty &&
        selectedValue.value != 'يرجى اختيار المادة';
  }

  void resetSelection() {
    selectedValue.value = '';
  }

  void validateAndNavigate() {
    if (isSubjectSelected()) {
      AppNavigator.of(Get.context!).push(
        BasicCardScreen(subjectName: selectedValue.value),
      );
      resetSelection();
    } else {
      errorMessage.value = 'يرجى اختيار مادة';
    }
  }
}


