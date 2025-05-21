import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vishal_portfolio/app_constants.dart';
import 'package:vishal_portfolio/app_theme.dart';
import 'package:vishal_portfolio/utils/responsive_helper.dart';
import 'package:vishal_portfolio/widgets/skill_card.dart';

class AboutSection extends StatefulWidget {
  final Function(double height, double offset) onSectionInit;
  
  const AboutSection({
    super.key,
    required this.onSectionInit,
  });

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
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
                'About Me',
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
              const SizedBox(height: 32),
              
              // Bio and Education/Experience
              ResponsiveHelper.responsiveWrapper(
                context: context,
                mobile: _buildMobileLayout(context),
                desktop: _buildDesktopLayout(context),
              ),
              
              const SizedBox(height: 48),
              
              // Skills Section Title
              Text(
                'Skills & Expertise',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              
              // Skills Grid
              _buildSkillsGrid(context),
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
        // Bio
        Text(
          AppConstants.fullBio,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        
        // Education & Experience
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Education
                Row(
                  children: [
                    const Icon(
                      Icons.school,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Education',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  AppConstants.education,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                
                // Experience
                Row(
                  children: [
                    const Icon(
                      Icons.work,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Experience',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  AppConstants.workExperience,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bio
        Expanded(
          flex: 3,
          child: Text(
            AppConstants.fullBio,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(width: 32),
        
        // Education & Experience
        Expanded(
          flex: 2,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Education
                  Row(
                    children: [
                      const Icon(
                        Icons.school,
                        color: AppTheme.primaryColor,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Education',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppConstants.education,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  
                  // Experience
                  Row(
                    children: [
                      const Icon(
                        Icons.work,
                        color: AppTheme.primaryColor,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Experience',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppConstants.workExperience,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildSkillsGrid(BuildContext context) {
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
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3,
      ),
      itemCount: AppConstants.skills.length,
      itemBuilder: (context, index) {
        final skill = AppConstants.skills[index];
        return SkillCard(
          name: skill['name'],
          level: skill['level'],
          description: skill['description'],
        );
      },
    );
  }
}
