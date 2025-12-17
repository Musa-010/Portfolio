import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../common/section_title.dart';
import '../common/skill_tag.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.screenPadding(context),
      // color: AppColors.backgroundLight, // Removed for animated background
      child: Center(
        child: SizedBox(
          width: Responsive.contentWidth(context),
          child: Column(
            children: [
              const SizedBox(height: 80),
              const SectionTitle(
                title: AppStrings.aboutTitle,
                subtitle: 'Get to know me better',
              ),
              ResponsiveWidget(
                desktop: _buildDesktopLayout(context),
                tablet: _buildTabletLayout(context),
                mobile: _buildMobileLayout(context),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _buildAboutContent(context),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 5,
          child: _buildTechStack(context),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        _buildAboutContent(context),
        const SizedBox(height: 50),
        _buildTechStack(context),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAboutContent(context),
        const SizedBox(height: 40),
        _buildTechStack(context),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who I Am',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.aboutMe,
          style: AppTextStyles.bodyMedium,
        ),
        const SizedBox(height: 30),
        _buildInfoCards(context),
      ],
    );
  }

  Widget _buildInfoCards(BuildContext context) {
    final cards = [
      _InfoCard(
        icon: FontAwesomeIcons.briefcase,
        title: '3+ Years',
        subtitle: 'Experience',
      ),
      _InfoCard(
        icon: FontAwesomeIcons.folderOpen,
        title: '20+',
        subtitle: 'Projects',
      ),
      _InfoCard(
        icon: FontAwesomeIcons.users,
        title: '15+',
        subtitle: 'Happy Clients',
      ),
    ];

    if (Responsive.isMobile(context)) {
      return Column(
        children: cards.map((card) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: card,
        )).toList(),
      );
    }

    return Row(
      children: cards.map((card) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: card,
        ),
      )).toList(),
    );
  }

  Widget _buildTechStack(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  FontAwesomeIcons.code,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Tech Stack',
                style: AppTextStyles.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SkillTag(label: 'Flutter', color: AppColors.accent),
              SkillTag(label: 'Dart', color: AppColors.primary),
              SkillTag(label: 'Firebase', color: AppColors.accentGreen),
              SkillTag(label: 'REST APIs', color: AppColors.accent),
              SkillTag(label: 'Node.js', color: AppColors.accentGreen),
              SkillTag(label: 'MongoDB', color: AppColors.accentGreen),
              SkillTag(label: 'Git', color: AppColors.accentPink),
              SkillTag(label: 'BLoC', color: AppColors.primary),
              SkillTag(label: 'Provider', color: AppColors.accent),
              SkillTag(label: 'GetX', color: AppColors.primary),
              SkillTag(label: 'Riverpod', color: AppColors.accentPink),
              SkillTag(label: 'Figma', color: AppColors.accentPink),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered 
              ? AppColors.primary.withValues(alpha: 0.1) 
              : AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered 
                ? AppColors.primary.withValues(alpha: 0.5) 
                : AppColors.textMuted.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(
              widget.icon,
              color: AppColors.primary,
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
