import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme.dart';

class ThemeController extends GetxController {
  // Observable variables
  final RxBool isDarkMode = false.obs;
  
  // Get current theme
  ThemeData get currentTheme => isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme;
  
  // Toggle theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(currentTheme);
  }
  
  // Set specific theme
  void setTheme(bool darkMode) {
    isDarkMode.value = darkMode;
    Get.changeTheme(currentTheme);
  }
}
