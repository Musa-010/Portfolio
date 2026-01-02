import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import '../../core/constants/app_colors.dart';
import '../../screens/home_page.dart';
import 'three_d_loader.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _progressController;
  
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  // Modern color palette
  static const Color primaryPurple = Color(0xFF6C63FF);
  static const Color accentCyan = Color(0xFF00D9FF);
  static const Color backgroundDark = Color(0xFF0F0F1A);

  @override
  void initState() {
    super.initState();
    
    // Rotation animation for outer rings
    _rotationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_rotationController);

    // Pulse animation
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Fade animation for text
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    
    _fadeAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    
    _scaleController.forward();

    // Progress animation
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _progressController.forward();

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      body: Stack(
        children: [
          // Animated gradient background with modern cyberpunk feel
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, -0.3),
                    radius: 1.5,
                    colors: [
                      primaryPurple.withOpacity(0.15 * _pulseAnimation.value),
                      backgroundDark,
                      backgroundDark,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              );
            },
          ),
          
          // Secondary gradient overlay
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.5, 0.8),
                    radius: 1.2,
                    colors: [
                      accentCyan.withOpacity(0.08 * _pulseAnimation.value),
                      backgroundDark.withOpacity(0),
                    ],
                  ),
                ),
              );
            },
          ),
          
          // Grid pattern overlay for tech feel
          Opacity(
            opacity: 0.03,
            child: CustomPaint(
              size: Size.infinite,
              painter: GridPainter(),
            ),
          ),
          
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Rotating rings around loader
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer rotating ring
                      AnimatedBuilder(
                        animation: _rotationAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotationAnimation.value,
                            child: Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryPurple.withOpacity(0.2),
                                  width: 2,
                                ),
                              ),
                              child: CustomPaint(
                                painter: ArcPainter(
                                  color: primaryPurple,
                                  sweepAngle: math.pi / 2,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      
                      // Inner counter-rotating ring
                      AnimatedBuilder(
                        animation: _rotationAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: -_rotationAnimation.value * 1.5,
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: accentCyan.withOpacity(0.2),
                                  width: 2,
                                ),
                              ),
                              child: CustomPaint(
                                painter: ArcPainter(
                                  color: accentCyan,
                                  sweepAngle: math.pi / 3,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      
                      // Pulsing glow effect
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryPurple.withOpacity(0.4 * _pulseAnimation.value),
                                  blurRadius: 40 * _pulseAnimation.value,
                                  spreadRadius: 5 * _pulseAnimation.value,
                                ),
                                BoxShadow(
                                  color: accentCyan.withOpacity(0.3 * _pulseAnimation.value),
                                  blurRadius: 60 * _pulseAnimation.value,
                                  spreadRadius: -5,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      
                      // 3D Loader
                      const ThreeDLoader(size: 100),
                    ],
                  ),
                ),
                
                const SizedBox(height: 50),
                
                // Modern loading text with gradient
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [primaryPurple, accentCyan],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      'LOADING',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 12,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Animated progress dots with modern styling
                AnimatedBuilder(
                  animation: _fadeController,
                  builder: (context, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        final delay = index * 0.15;
                        final animValue = ((_fadeController.value + delay) % 1.0);
                        final color = index == 0 
                            ? primaryPurple 
                            : index == 1 
                                ? Color.lerp(primaryPurple, accentCyan, 0.5)! 
                                : accentCyan;
                        
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color.withOpacity(animValue),
                              boxShadow: [
                                BoxShadow(
                                  color: color.withOpacity(animValue * 0.8),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                
                const SizedBox(height: 30),
                
                // Progress bar
                AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, child) {
                    return Container(
                      width: 200,
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: primaryPurple.withOpacity(0.1),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 200 * _progressController.value,
                          height: 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            gradient: LinearGradient(
                              colors: [primaryPurple, accentCyan],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: accentCyan.withOpacity(0.6),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          // Corner accents for modern UI feel
          Positioned(
            top: 40,
            left: 30,
            child: _buildCornerAccent(),
          ),
          Positioned(
            bottom: 40,
            right: 30,
            child: Transform.rotate(
              angle: math.pi,
              child: _buildCornerAccent(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCornerAccent() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: 0.3 * _fadeAnimation.value,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: primaryPurple, width: 2),
                left: BorderSide(color: accentCyan, width: 2),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Custom painter for arc segments
class ArcPainter extends CustomPainter {
  final Color color;
  final double sweepAngle;
  
  ArcPainter({required this.color, required this.sweepAngle});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Grid pattern painter for tech aesthetic
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    
    const spacing = 40.0;
    
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}