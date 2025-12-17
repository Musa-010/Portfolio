import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';

class SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const SocialButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -4.0 : 0.0),
        child: IconButton(
          onPressed: widget.onPressed,
          icon: FaIcon(
            widget.icon,
            color: _isHovered 
                ? (widget.color ?? AppColors.primary) 
                : AppColors.textSecondary,
            size: 24,
          ),
          style: IconButton.styleFrom(
            backgroundColor: _isHovered 
                ? (widget.color ?? AppColors.primary).withValues(alpha: 0.1) 
                : AppColors.backgroundCard,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: _isHovered 
                    ? (widget.color ?? AppColors.primary).withValues(alpha: 0.3) 
                    : AppColors.textMuted.withValues(alpha: 0.2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
