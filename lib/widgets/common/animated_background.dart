import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late List<_Particle> _particles;
  late AnimationController _controller;
  final Random _random = Random();
  Offset? _mousePosition;

  @override
  void initState() {
    super.initState();
    _particles = List.generate(25, (_) => _Particle.random(_random));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Tick constantly
    )..addListener(() {
        setState(() {
          for (final particle in _particles) {
            particle.update();
          }
        });
      })..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.localPosition;
        });
      },
      onExit: (event) {
        setState(() {
          _mousePosition = null;
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Base Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.background,
                  AppColors.backgroundLight,
                  AppColors.background,
                ],
              ),
            ),
          ),
          // Constellation Effect (Lines & Particles)
          CustomPaint(
            painter: _ConstellationPainter(
              particles: _particles,
              lineColor: AppColors.primaryLight.withValues(alpha: 0.15),
              mousePosition: _mousePosition,
            ),
            size: Size.infinite,
          ),
          // Content
          widget.child,
        ],
      ),
    );
  }
}

class _Particle {
  double x;
  double y;
  double size;
  double velocityX;
  double velocityY;
  final Color color;
  final double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.velocityX,
    required this.velocityY,
    required this.color,
    required this.opacity,
  });

  factory _Particle.random(Random rand) {
    final colors = [
      AppColors.primary,
      AppColors.accent,
      AppColors.accentPink,
      AppColors.accentGreen,
    ];

    return _Particle(
      x: rand.nextDouble(),
      y: rand.nextDouble(),
      size: rand.nextDouble() * 5 + 3, // Slightly larger particles
      velocityX: (rand.nextDouble() - 0.5) * 0.0015,
      velocityY: (rand.nextDouble() - 0.5) * 0.0015,
      color: colors[rand.nextInt(colors.length)],
      opacity: rand.nextDouble() * 0.5 + 0.2, // More opaque
    );
  }

  void update() {
    x += velocityX;
    y += velocityY;

    // Bounce off edges (or wrap around, we'll wrap for smoother flow)
    if (x < -0.1) x = 1.1;
    if (x > 1.1) x = -0.1;
    if (y < -0.1) y = 1.1;
    if (y > 1.1) y = -0.1;
  }
}

class _ConstellationPainter extends CustomPainter {
  final List<_Particle> particles;
  final Color lineColor;
  final Offset? mousePosition;

  _ConstellationPainter({
    required this.particles,
    required this.lineColor,
    this.mousePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 1.0;

    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      final pos1 = Offset(p1.x * size.width, p1.y * size.height);

      // Draw Particle
      final particlePaint = Paint()
        ..color = p1.color.withValues(alpha: p1.opacity)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(pos1, p1.size, particlePaint);

      // Connect to Mouse
      if (mousePosition != null) {
        final dist = (pos1 - mousePosition!).distance;
        const connectionDistance = 200.0; // Slightly larger for mouse

        if (dist < connectionDistance) {
          final opacity = (1 - (dist / connectionDistance)).clamp(0.0, 1.0);
          paint.color = AppColors.accent.withValues(alpha: opacity * 0.4);
          canvas.drawLine(pos1, mousePosition!, paint);
        }
      }

      // Draw Connections between particles
      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final pos2 = Offset(p2.x * size.width, p2.y * size.height);

        final dist = (pos1 - pos2).distance;
        const connectionDistance = 150.0;

        if (dist < connectionDistance) {
          final opacity = (1 - (dist / connectionDistance)).clamp(0.0, 1.0);
          paint.color = lineColor.withValues(alpha: opacity * 0.5);
          canvas.drawLine(pos1, pos2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConstellationPainter oldDelegate) => 
      oldDelegate.mousePosition != mousePosition || true;
}
