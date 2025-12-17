import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class SkillTag extends StatefulWidget {
  final String label;
  final Color? color;

  const SkillTag({
    super.key,
    required this.label,
    this.color,
  });

  @override
  State<SkillTag> createState() => _SkillTagState();
}

class _SkillTagState extends State<SkillTag> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.primary;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered 
              ? color.withValues(alpha: 0.2) 
              : color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withValues(alpha: _isHovered ? 0.6 : 0.3),
            width: 1,
          ),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
