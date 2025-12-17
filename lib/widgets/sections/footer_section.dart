import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      color: AppColors.background,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.textMuted.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.code,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Built with ',
                style: AppTextStyles.bodySmall,
              ),
              const Icon(
                FontAwesomeIcons.heart,
                color: AppColors.accentPink,
                size: 14,
              ),
              Text(
                ' using Flutter',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '© ${DateTime.now().year} Musa Khan. All rights reserved.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
