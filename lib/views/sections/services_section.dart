import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vishal_portfolio/app_constants.dart';
import 'package:vishal_portfolio/app_theme.dart';
import 'package:vishal_portfolio/utils/responsive_helper.dart';
import 'package:vishal_portfolio/widgets/service_card.dart';

class ServicesSection extends StatefulWidget {
  final Function(double height, double offset) onSectionInit;
  
  const ServicesSection({
    super.key,
    required this.onSectionInit,
  });

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
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
      width: double.infinity,
      color: Theme.of(context).colorScheme.background,
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
                'Services & Capabilities',
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
              
              // Services Description
              Text(
                'I offer a range of Flutter development services to help bring your app ideas to life.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              
              // Services Grid
              _buildServicesGrid(context),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildServicesGrid(BuildContext context) {
    final int crossAxisCount = ResponsiveHelper.isMobile(context) 
        ? 1 
        : ResponsiveHelper.isTablet(context) 
            ? 2 
            : 3;
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.0,
      ),
      itemCount: AppConstants.services.length,
      itemBuilder: (context, index) {
        final service = AppConstants.services[index];
        return ServiceCard(
          title: service['title'],
          description: service['description'],
          icon: service['icon'] as IconData,
        );
      },
    );
  }
}
