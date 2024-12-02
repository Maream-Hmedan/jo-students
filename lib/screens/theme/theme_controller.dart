import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeToggleController extends GetxController {
  var isNightMode = false.obs; // Default to light mode

  ThemeMode get themeMode =>
      isNightMode.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPreferences(); // Load the saved theme when the controller is initialized
  }

  void toggleTheme() {
    isNightMode.value = !isNightMode.value;
    Get.changeThemeMode(isNightMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToPreferences();
  }

  void _loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Default to light theme (false) if no preference is found
    isNightMode.value = prefs.getBool('isNightMode') ?? false;
    Get.changeThemeMode(isNightMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void _saveThemeToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNightMode', isNightMode.value);
  }
}

