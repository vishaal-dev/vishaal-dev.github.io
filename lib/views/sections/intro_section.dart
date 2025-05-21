import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vishal_portfolio/app_constants.dart';
import 'package:vishal_portfolio/app_theme.dart';
import 'package:vishal_portfolio/controllers/app_controller.dart';
import 'package:vishal_portfolio/utils/responsive_helper.dart';
import 'package:vishal_portfolio/widgets/animated_text.dart';
import 'package:vishal_portfolio/widgets/custom_button.dart';

class IntroSection extends StatefulWidget {
  final Function(double height, double offset) onSectionInit;
  
  const IntroSection({
    super.key,
    required this.onSectionInit,
  });

  @override
  State<IntroSection> createState() => _IntroSectionState();
}

class _IntroSectionState extends State<IntroSection> {
  final GlobalKey _sectionKey = GlobalKey();
  
  @override
  void initState() {
    super.initState();
    // Use post-frame callback to get section dimensions after render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _sectionKey.currentContext?.findRenderObject() as RenderBox;
      final Size size = renderBox.size;
      final Offset position = renderBox.localToGlobal(Offset.zero);
      widget.onSectionInit(size.height, position.dy);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      key: _sectionKey,
      height: ResponsiveHelper.isMobile(context) 
          ? MediaQuery.of(context).size.height * 0.9
          : MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.background.withOpacity(0.8),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: ResponsiveHelper.getContentMaxWidth(context),
          padding: ResponsiveHelper.getScreenPadding(context),
          child: ResponsiveHelper.responsiveWrapper(
            context: context,
            mobile: _buildMobileLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ),
      ),
    );
  }
  
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Image
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primaryColor,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  child: const Icon(
                    Icons.person,
                    size: 80,
                    color: AppTheme.primaryColor,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 32),
        
        // Name
        Text(
          AppConstants.name,
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        
        // Title with animation
        AnimatedText(
          text: AppConstants.title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 24),
        
        // Short Bio
        Text(
          AppConstants.shortBio,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        
        // CTA Button
        CustomButton(
          text: 'Contact Me',
          onPressed: () {
            // Scroll to contact section
            Get.find<AppController>().scrollToSection(4);
          },
          icon: Icons.email,
        ),
      ],
    );
  }
  
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text Content
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(
                AppConstants.name,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              
              // Title with animation
              AnimatedText(
                text: AppConstants.title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 24),
              
              // Short Bio
              Text(
                AppConstants.shortBio,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              
              // CTA Button
              CustomButton(
                text: 'Contact Me',
                onPressed: () {
                  // Scroll to contact section
                  Get.find<AppController>().scrollToSection(4);
                },
                icon: Icons.email,
              ),
            ],
          ),
        ),
        
        // Profile Image
        Expanded(
          flex: 2,
          child: Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryColor,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      child: const Icon(
                        Icons.person,
                        size: 120,
                        color: AppTheme.primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
