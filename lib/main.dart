import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vishal_portfolio/app_theme.dart';
import 'package:vishal_portfolio/controllers/app_controller.dart';
import 'package:vishal_portfolio/controllers/theme_controller.dart';
import 'package:vishal_portfolio/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final ThemeController themeController = Get.put(ThemeController());
    Get.put(AppController());

    return Obx(() => GetMaterialApp(
      title: 'Vishal A V - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      home: const HomeView(),
    ));
  }
}
