import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../widgets/common/animated_background.dart';
import '../widgets/navigation/nav_bar.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentNavIndex = 0;

  // Keys for each section to enable scroll to
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollPosition = _scrollController.offset;
    final sectionPositions = _getSectionPositions();

    int newIndex = 0;
    for (int i = 0; i < sectionPositions.length; i++) {
      if (scrollPosition >= sectionPositions[i] - 100) {
        newIndex = i;
      }
    }

    if (_currentNavIndex != newIndex) {
      setState(() {
        _currentNavIndex = newIndex;
      });
    }
  }

  List<double> _getSectionPositions() {
    return [
      _getPosition(_heroKey),
      _getPosition(_aboutKey),
      _getPosition(_projectsKey),
      _getPosition(_skillsKey),
      _getPosition(_contactKey),
    ];
  }

  double _getPosition(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return 0;
    return renderBox.localToGlobal(Offset.zero).dy + _scrollController.offset;
  }

  void _scrollToSection(int index) {
    final keys = [_heroKey, _aboutKey, _projectsKey, _skillsKey, _contactKey];
    final RenderBox? renderBox = keys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero).dy + _scrollController.offset;
    _scrollController.animateTo(
      position - 80, // Offset for navbar height
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedBackground(
        child: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 80), // Space for fixed navbar
                  HeroSection(
                    key: _heroKey,
                    onViewWorkPressed: () => _scrollToSection(2),
                  ),
                  AboutSection(key: _aboutKey),
                  ProjectsSection(key: _projectsKey),
                  SkillsSection(key: _skillsKey),
                  ContactSection(key: _contactKey),
                  const FooterSection(),
                ],
              ),
            ),
            
            // Fixed Navigation Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavBar(
                currentIndex: _currentNavIndex,
                onNavItemTap: _scrollToSection,
              ),
            ),
          ],
        ),
      ),
      
      // Floating Action Button for scroll to top
      floatingActionButton: AnimatedOpacity(
        opacity: _currentNavIndex > 0 ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: () => _scrollToSection(0),
          backgroundColor: AppColors.primary,
          child: const Icon(
            Icons.arrow_upward,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
