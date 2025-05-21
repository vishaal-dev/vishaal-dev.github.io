import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vishal_portfolio/app_constants.dart';
import 'package:vishal_portfolio/app_theme.dart';
import 'package:vishal_portfolio/utils/responsive_helper.dart';
import 'package:vishal_portfolio/widgets/project_card.dart';

class PortfolioSection extends StatefulWidget {
  final Function(double height, double offset) onSectionInit;
  
  const PortfolioSection({
    super.key,
    required this.onSectionInit,
  });

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
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
                'Portfolio',
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
              
              // Portfolio Description
              Text(
                'Explore my recent projects and applications built with Flutter.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              
              // Projects Grid
              _buildProjectsGrid(context),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildProjectsGrid(BuildContext context) {
    final int crossAxisCount = ResponsiveHelper.isMobile(context) 
        ? 1 
        : ResponsiveHelper.isTablet(context) 
            ? 1
            : 2;
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 14,
        mainAxisSpacing: 24,
        childAspectRatio: ResponsiveHelper.isMobile(context) ? 1.0 : 1.0,
      ),
      itemCount: AppConstants.projects.length,
      itemBuilder: (context, index) {
        final project = AppConstants.projects[index];
        return ProjectCard(
          name: project['name'],
          description: project['description'],
          role: project['role'],
          technologies: List<String>.from(project['technologies']),
          imagePath: project['image'],
        );
      },
    );
  }
}
