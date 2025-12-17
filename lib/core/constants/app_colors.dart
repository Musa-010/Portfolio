import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF8B85FF);
  static const Color primaryDark = Color(0xFF5046E5);

  // Background Colors
  static const Color background = Color(0xFF0F0F1A);
  static const Color backgroundLight = Color(0xFF1A1A2E);
  static const Color backgroundCard = Color(0xFF16162A);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB4B4C4);
  static const Color textMuted = Color(0xFF6B6B80);

  // Accent Colors
  static const Color accent = Color(0xFF00D9FF);
  static const Color accentGreen = Color(0xFF00FF94);
  static const Color accentPink = Color(0xFFFF6B9D);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [backgroundCard, backgroundLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
