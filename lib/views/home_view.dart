import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vishal_portfolio/app_theme.dart';
import 'package:vishal_portfolio/controllers/app_controller.dart';
import 'package:vishal_portfolio/controllers/theme_controller.dart';
import 'package:vishal_portfolio/utils/responsive_helper.dart';
import 'package:vishal_portfolio/views/sections/about_section.dart';
import 'package:vishal_portfolio/views/sections/contact_section.dart';
import 'package:vishal_portfolio/views/sections/intro_section.dart';
import 'package:vishal_portfolio/views/sections/portfolio_section.dart';
import 'package:vishal_portfolio/views/sections/services_section.dart';
import 'package:vishal_portfolio/widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find<AppController>();
    final ThemeController themeController = Get.find<ThemeController>();
    
    // Update device type on build
    appController.updateDeviceType(context);
    
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main content with sections
            SingleChildScrollView(
              controller: appController.scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Introduction Section
                  IntroSection(
                    onSectionInit: (height, offset) {
                      appController.updateSectionDimensions(0, height, offset);
                    },
                  ),
                  
                  // About & Skills Section
                  AboutSection(
                    onSectionInit: (height, offset) {
                      appController.updateSectionDimensions(1, height, offset);
                    },
                  ),
                  
                  // Portfolio Section
                  PortfolioSection(
                    onSectionInit: (height, offset) {
                      appController.updateSectionDimensions(2, height, offset);
                    },
                  ),
                  
                  // Services & Capabilities Section
                  ServicesSection(
                    onSectionInit: (height, offset) {
                      appController.updateSectionDimensions(3, height, offset);
                    },
                  ),
                  
                  // Contact Section
                  ContactSection(
                    onSectionInit: (height, offset) {
                      appController.updateSectionDimensions(4, height, offset);
                    },
                  ),
                ],
              ),
            ),
            
            // Header with navigation
            Obx(() => AnimatedOpacity(
              opacity: appController.scrollPosition.value > 100 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: appController.scrollPosition.value > 100
                ? Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SizedBox(
                        width: ResponsiveHelper.getContentMaxWidth(context),
                        child: Padding(
                          padding: ResponsiveHelper.getScreenPadding(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Logo/Name
                              Text(
                                'Vishal A V',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              
                              // Navigation
                              if (!ResponsiveHelper.isMobile(context))
                                Row(
                                  children: [
                                    _buildNavItem(context, 'Home', 0, appController),
                                    _buildNavItem(context, 'About', 1, appController),
                                    _buildNavItem(context, 'Portfolio', 2, appController),
                                    _buildNavItem(context, 'Services', 3, appController),
                                    _buildNavItem(context, 'Contact', 4, appController),
                                    const SizedBox(width: 16),
                                    _buildThemeToggleButton(themeController),
                                  ],
                                ),
                              
                              // Mobile menu
                              if (ResponsiveHelper.isMobile(context))
                                Row(
                                  children: [
                                    _buildThemeToggleButton(themeController),
                                    IconButton(
                                      icon: const Icon(Icons.menu),
                                      onPressed: () => _showMobileMenu(context, appController),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            )),
            
            // Floating action button for contact
            Positioned(
              right: 20,
              bottom: 20,
              child: Obx(() => AnimatedOpacity(
                opacity: appController.currentSection.value != 4 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: appController.currentSection.value != 4
                  ? FloatingActionButton(
                      onPressed: () => appController.scrollToSection(4),
                      backgroundColor: AppTheme.primaryColor,
                      child: const Icon(Icons.email, color: Colors.white),
                    )
                  : const SizedBox.shrink(),
              )),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavItem(BuildContext context, String title, int index, AppController controller) {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () => controller.scrollToSection(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: controller.currentSection.value == index
                ? AppTheme.primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: controller.currentSection.value == index
                  ? AppTheme.primaryColor
                  : Theme.of(context).textTheme.bodyLarge!.color,
              fontWeight: controller.currentSection.value == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    ));
  }
  
  void _showMobileMenu(BuildContext context, AppController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                controller.scrollToSection(0);
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                controller.scrollToSection(1);
              },
            ),
            ListTile(
              title: const Text('Portfolio'),
              onTap: () {
                Navigator.pop(context);
                controller.scrollToSection(2);
              },
            ),
            ListTile(
              title: const Text('Services'),
              onTap: () {
                Navigator.pop(context);
                controller.scrollToSection(3);
              },
            ),
            ListTile(
              title: const Text('Contact'),
              onTap: () {
                Navigator.pop(context);
                controller.scrollToSection(4);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggleButton(ThemeController controller) {
    return Obx(() {
      final isDark = controller.isDarkMode.value;
      return GestureDetector(
        onTap: controller.toggleTheme,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          width: 50,
          height: 28,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 400),
                alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(scale: animation, child: child),
                        );
                      },
                      child: Icon(
                        isDark ? Icons.dark_mode : Icons.light_mode,
                        key: ValueKey<bool>(isDark),
                        color: isDark ? Colors.black : Colors.orange,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
