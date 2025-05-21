import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vishal_portfolio/app_constants.dart';
import 'package:vishal_portfolio/app_theme.dart';
import 'package:vishal_portfolio/controllers/form_controller.dart';
import 'package:vishal_portfolio/utils/responsive_helper.dart';
import 'package:vishal_portfolio/utils/url_launcher_helper.dart';
import 'package:vishal_portfolio/widgets/contact_form.dart';
import 'package:vishal_portfolio/widgets/social_button.dart';

class ContactSection extends StatefulWidget {
  final Function(double height, double offset) onSectionInit;
  
  const ContactSection({
    super.key,
    required this.onSectionInit,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
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
    // Initialize form controller
    Get.put(FormController());
    
    return Container(
      key: _sectionKey,
      width: double.infinity,
      color: Theme.of(context).brightness == Brightness.light
          ? AppTheme.lightSurface
          : AppTheme.darkSurface,
      child: Center(
        child: Container(
          width: ResponsiveHelper.getContentMaxWidth(context),
          padding: ResponsiveHelper.getScreenPadding(context).copyWith(
            top: 80,
            bottom: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              Text(
                'Contact Me',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(
                color: AppTheme.primaryColor,
                thickness: 2,
                endIndent: 80,
              ),
              const SizedBox(height: 16),
              
              // Contact Description
              Text(
                'Have a project in mind or want to discuss a potential collaboration? Feel free to reach out!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              
              // Contact Content
              ResponsiveHelper.responsiveWrapper(
                context: context,
                mobile: _buildMobileLayout(context),
                desktop: _buildDesktopLayout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Information
        _buildContactInfo(context),
        const SizedBox(height: 32),
        
        // Contact Form
        const ContactForm(),
      ],
    );
  }
  
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Information
        Expanded(
          flex: 2,
          child: _buildContactInfo(context),
        ),
        const SizedBox(width: 48),
        
        // Contact Form
        const Expanded(
          flex: 3,
          child: ContactForm(),
        ),
      ],
    );
  }
  
  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Details
        Text(
          'Contact Details',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Email
        _buildContactItem(
          context,
          Icons.email,
          'Email',
          AppConstants.email,
          () => UrlLauncherHelper.launchEmail(AppConstants.email),
        ),
        const SizedBox(height: 16),
        
        // Phone
        _buildContactItem(
          context,
          Icons.phone,
          'Phone',
          AppConstants.phone,
          () => UrlLauncherHelper.launchPhone(AppConstants.phone),
        ),
        const SizedBox(height: 32),
        
        // Social Links
        Text(
          'Connect With Me',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Social Buttons
        Row(
          children: [
            SocialButton(
              icon: Icons.link,
              tooltip: 'LinkedIn',
              onPressed: () => UrlLauncherHelper.launchURL('https://${AppConstants.linkedin}'),
            ),
            const SizedBox(width: 16),
            SocialButton(
              icon: Icons.code,
              tooltip: 'GitHub',
              onPressed: () => UrlLauncherHelper.launchURL(AppConstants.github),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppTheme.primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
