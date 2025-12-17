import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../data/skills_data.dart';
import '../common/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.screenPadding(context),
      decoration: const BoxDecoration(
        // Removed opaque gradient
      ),
      child: Center(
        child: SizedBox(
          width: Responsive.contentWidth(context),
          child: Column(
            children: [
              const SizedBox(height: 80),
              const SectionTitle(
                title: AppStrings.skillsTitle,
                subtitle: 'Technologies I work with',
              ),
              _buildSkillsGrid(context),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsGrid(BuildContext context) {
    final crossAxisCount = Responsive.isDesktop(context) 
        ? 4 
        : Responsive.isTablet(context) 
            ? 3 
            : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.1,
      ),
      itemCount: skills.length,
      itemBuilder: (context, index) => SkillCard(skill: skills[index]),
    );
  }
}

class SkillCard extends StatefulWidget {
  final Skill skill;

  const SkillCard({super.key, required this.skill});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.05 : 1.0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isHovered 
              ? widget.skill.color.withValues(alpha: 0.1) 
              : AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered 
                ? widget.skill.color.withValues(alpha: 0.5) 
                : AppColors.textMuted.withValues(alpha: 0.1),
            width: 2,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.skill.color.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.skill.color.withValues(alpha: _isHovered ? 0.2 : 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.skill.icon,
                color: widget.skill.color,
                size: Responsive.isMobile(context) ? 28 : 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.skill.name,
              style: AppTextStyles.bodyMedium.copyWith(
                color: _isHovered ? widget.skill.color : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
