import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../common/primary_button.dart';
import '../common/social_button.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWorkPressed;
  
  const HeroSection({
    super.key,
    required this.onViewWorkPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: screenHeight - 80, // Subtract navbar height
      ),
      decoration: const BoxDecoration(
        // Removed opaque gradient to show animated background
      ),
      child: Center(
        child: Padding(
          padding: Responsive.screenPadding(context),
          child: ResponsiveWidget(
            desktop: _buildDesktopLayout(context),
            tablet: _buildTabletLayout(context),
            mobile: _buildMobileLayout(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SizedBox(
      width: Responsive.contentWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: _buildContent(context, isDesktop: true),
          ),
          const SizedBox(width: 60),
          Expanded(
            flex: 4,
            child: _buildProfileImage(context, size: 380),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(context, size: 280),
        const SizedBox(height: 50),
        _buildContent(context, isDesktop: false),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(context, size: 200),
        const SizedBox(height: 40),
        _buildContent(context, isDesktop: false),
      ],
    );
  }

  Widget _buildContent(BuildContext context, {required bool isDesktop}) {
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.heroTitle,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.w500,
          ),
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.name,
          style: isDesktop 
              ? AppTextStyles.headingLarge 
              : AppTextStyles.headingMedium.copyWith(
                  fontSize: Responsive.isMobile(context) ? 36 : 42,
                ),
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: DefaultTextStyle(
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primary,
              fontSize: Responsive.isMobile(context) ? 20 : 24,
            ),
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  AppStrings.title,
                  speed: const Duration(milliseconds: 100),
                ),
                TypewriterAnimatedText(
                  'Mobile App Developer',
                  speed: const Duration(milliseconds: 100),
                ),
                TypewriterAnimatedText(
                  'UI/UX Enthusiast',
                  speed: const Duration(milliseconds: 100),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: isDesktop ? 500 : double.infinity,
          child: Text(
            AppStrings.tagline,
            style: AppTextStyles.bodyLarge,
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),
        _buildButtons(context, isDesktop),
        const SizedBox(height: 50),
        _buildSocialLinks(context, isDesktop),
      ],
    );
  }

  Widget _buildButtons(BuildContext context, bool isDesktop) {
    final buttons = [
      PrimaryButton(
        text: 'View Work',
        icon: FontAwesomeIcons.briefcase,
        onPressed: onViewWorkPressed,
      ),
      const SizedBox(width: 20, height: 16),
      PrimaryButton(
        text: 'Download CV',
        icon: FontAwesomeIcons.download,
        isOutlined: true,
        onPressed: () => _launchUrl(AppStrings.cvUrl),
      ),
    ];

    if (Responsive.isMobile(context)) {
      return Column(
        children: buttons.map((e) => e is SizedBox ? e : SizedBox(width: double.infinity, child: e)).toList(),
      );
    }

    return Wrap(
      alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
      spacing: 20,
      runSpacing: 16,
      children: [buttons[0], buttons[2]],
    );
  }

  Widget _buildSocialLinks(BuildContext context, bool isDesktop) {
    return Row(
      mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        SocialButton(
          icon: FontAwesomeIcons.github,
          onPressed: () => _launchUrl(AppStrings.githubUrl),
        ),
        const SizedBox(width: 16),
        SocialButton(
          icon: FontAwesomeIcons.linkedin,
          color: const Color(0xFF0077B5),
          onPressed: () => _launchUrl(AppStrings.linkedinUrl),
        ),
        const SizedBox(width: 16),
        SocialButton(
          icon: FontAwesomeIcons.envelope,
          color: AppColors.accentPink,
          onPressed: () => _launchUrl('mailto:${AppStrings.email}'),
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, {required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: ClipOval(
        child: Container(
          width: size - 12,
          height: size - 12,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.backgroundLight,
          ),
          child: Image.asset(
            'lib/assets/musa.png',
            width: size - 12,
            height: size - 12,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
