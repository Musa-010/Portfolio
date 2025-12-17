import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';

class NavBar extends StatefulWidget {
  final Function(int) onNavItemTap;
  final int currentIndex;

  const NavBar({
    super.key,
    required this.onNavItemTap,
    required this.currentIndex,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<String> _navItems = ['Home', 'About', 'Projects', 'Skills', 'Contact'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 20 : 40,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(
            color: AppColors.textMuted.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: Responsive.contentWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              _buildLogo(),
              
              // Navigation Items
              if (Responsive.isDesktop(context))
                Row(
                  children: _navItems.asMap().entries.map((entry) {
                    return _buildNavItem(entry.key, entry.value);
                  }).toList(),
                )
              else
                _buildMobileMenuButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'MK',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          AppStrings.name,
          style: AppTextStyles.titleMedium,
        ),
      ],
    );
  }

  Widget _buildNavItem(int index, String title) {
    final isSelected = widget.currentIndex == index;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: _NavItemButton(
        title: title,
        isSelected: isSelected,
        onTap: () => widget.onNavItemTap(index),
      ),
    );
  }

  Widget _buildMobileMenuButton(BuildContext context) {
    return IconButton(
      onPressed: () => _showMobileMenu(context),
      icon: const Icon(
        Icons.menu,
        color: AppColors.textPrimary,
        size: 28,
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textMuted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ..._navItems.asMap().entries.map((entry) {
              return ListTile(
                title: Text(
                  entry.value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: widget.currentIndex == entry.key 
                        ? AppColors.primary 
                        : AppColors.textPrimary,
                    fontWeight: widget.currentIndex == entry.key 
                        ? FontWeight.w600 
                        : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pop(context);
                  widget.onNavItemTap(entry.key);
                },
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _NavItemButton extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItemButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavItemButton> createState() => _NavItemButtonState();
}

class _NavItemButtonState extends State<_NavItemButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isSelected 
                ? AppColors.primary.withValues(alpha: 0.1)
                : _isHovered 
                    ? AppColors.textMuted.withValues(alpha: 0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: AppTextStyles.navText.copyWith(
                  color: widget.isSelected || _isHovered
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.isSelected ? 20 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
