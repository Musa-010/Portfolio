import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/constants/app_colors.dart';

class ThreeDLoader extends StatefulWidget {
  final double size;
  final Duration duration;

  const ThreeDLoader({
    super.key,
    this.size = 100.0,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<ThreeDLoader> createState() => _ThreeDLoaderState();
}

class _ThreeDLoaderState extends State<ThreeDLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _ThreeDRingPainter(
              animationValue: _controller.value,
              primaryColor: AppColors.primary,
              accentColor: AppColors.accent,
            ),
          ),
        );
      },
    );
  }
}

class _ThreeDRingPainter extends CustomPainter {
  final double animationValue;
  final Color primaryColor;
  final Color accentColor;

  _ThreeDRingPainter({
    required this.animationValue,
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 4.0;

    // Ring 1 - Rotates on X axis
    _drawRing(
      canvas,
      center,
      radius,
      strokeWidth,
      primaryColor,
      animationValue * 2 * math.pi,
      Axis.horizontal,
    );

    // Ring 2 - Rotates on Y axis
    _drawRing(
      canvas,
      center,
      radius * 0.7,
      strokeWidth,
      accentColor,
      animationValue * 2 * math.pi + (math.pi / 4), // Offset phase
      Axis.vertical,
    );

    // Ring 3 - Rotates on Z axis (2D rotation)
    _drawRing(
      canvas,
      center,
      radius * 0.4,
      strokeWidth,
      primaryColor.withOpacity(0.8),
      -animationValue * 2 * math.pi,
      Axis.z,
    );
  }

  void _drawRing(
    Canvas canvas,
    Offset center,
    double radius,
    double strokeWidth,
    Color color,
    double angle,
    Axis axis,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.translate(center.dx, center.dy);

    if (axis == Axis.horizontal) {
      // Fake 3D effect by scaling Y based on Sine of angle, but simpler:
      // Actually just rotating the oval rect? No, that's Z-rotation.
      // To simulate X-rotation, we scale the height.
      // However, a true 3D rotation of a ring looks like an oscillating oval.
      
      // Let's use a simpler approach for "3D form" requested by user:
      // We will rotate the canvas.
      
      // For X-rotation (tumbling forward/back), we can't easily do true 3D in 2D canvas without perspective.
      // But we can simulate it by drawing an oval and rotating the canvas, or varying the oval's height.
      
      // Better appraoch for "3D" look in 2D:
      // Draw the oval with varying height to simulate X-axis tilt, and rotate the whole thing to simulate Z-axis.
      
      // Let's stick to the "Atomic" model look, which is 3 rings rotated 60 degrees from each other on Z, 
      // but then the particles move? Or just the rings themselves rotate?
      
      // Let's try 3 rings rotating on 3 different axes resulting in a gyroscope look.
      
      // Ring 1
      canvas.rotate(angle);
      // To make it look 3D, we scale one axis
      canvas.scale(1.0, 0.3 + 0.7 * math.sin(angle)); 
      
    } else if (axis == Axis.vertical) {
       canvas.rotate(-angle);
       canvas.scale(0.3 + 0.7 * math.cos(angle), 1.0);
    } else {
      // Z axis - just rotation
      canvas.rotate(angle);
    }
    
    // Draw the circle/oval
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: radius * 2, height: radius * 2),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ThreeDRingPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

enum Axis { horizontal, vertical, z }
