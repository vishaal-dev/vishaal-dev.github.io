import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  // Observable variables
  final RxInt currentSection = 0.obs;
  final RxDouble scrollPosition = 0.0.obs;
  final RxBool isScrolling = false.obs;
  final RxBool isMobileView = false.obs;
  
  // ScrollController for managing scroll position
  late ScrollController scrollController;
  
  // Section heights for determining active section
  final List<double> sectionHeights = [0, 0, 0, 0, 0];
  final List<double> sectionOffsets = [0, 0, 0, 0, 0];
  
  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }
  
  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }
  
  // Update section heights and offsets
  void updateSectionDimensions(int index, double height, double offset) {
    if (index < sectionHeights.length) {
      sectionHeights[index] = height;
      sectionOffsets[index] = offset;
    }
  }
  
  // Scroll listener to update current section
  void _scrollListener() {
    scrollPosition.value = scrollController.position.pixels;
    
    // Determine current section based on scroll position
    double currentPos = scrollController.position.pixels;
    for (int i = 0; i < sectionOffsets.length; i++) {
      double sectionStart = sectionOffsets[i];
      double sectionEnd = i < sectionOffsets.length - 1 
          ? sectionOffsets[i + 1] 
          : sectionOffsets[i] + sectionHeights[i];
      
      if (currentPos >= sectionStart && currentPos < sectionEnd) {
        if (currentSection.value != i) {
          currentSection.value = i;
        }
        break;
      }
    }
  }
  
  // Scroll to specific section
  void scrollToSection(int index) {
    if (index < sectionOffsets.length) {
      isScrolling.value = true;
      scrollController.animateTo(
        sectionOffsets[index],
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      ).then((_) => isScrolling.value = false);
      currentSection.value = index;
    }
  }
  
  // Update device view type
  void updateDeviceType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    isMobileView.value = width < 600;
  }
}
