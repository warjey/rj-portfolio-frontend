import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<GlobalKey> _sectionKeys = [
    GlobalKey(), // About
    GlobalKey(), // Projects
    GlobalKey(), // Skills
    GlobalKey(), // Contact
  ];

 void _scrollToSection(int index) {
  final ctx = _sectionKeys[index].currentContext;
  if (ctx != null) {
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }
}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A0F),
      body: Stack(
        children: [
              SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
              children: [
                // Hero — pass scroll callbacks
                HeroSection(
                  onViewProjects: () => _scrollToSection(1),
                  onContact: () => _scrollToSection(3),
                ),

                // About
                SizedBox(
                  key: _sectionKeys[0],
                  child: const AboutSection(),
                ),

                // Projects
                SizedBox(
                  key: _sectionKeys[1],
                  child: const ProjectsSection(),
                ),

                // Skills
                SizedBox(
                  key: _sectionKeys[2],
                  child: const SkillsSection(),
                ),

                // Contact
                SizedBox(
                  key: _sectionKeys[3],
                  child: const ContactSection(),
                ),
              ],
            ),
          ),

          // Fixed navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
            ),
          ),
        ],
      ),
    );
  }
}