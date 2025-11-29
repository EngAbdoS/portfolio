import 'package:flutter/material.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/achievements_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode themeMode;

  const HomeScreen({
    super.key,
    required this.onThemeToggle,
    required this.themeMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
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
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    onNavigate: (section) {
                      switch (section) {
                        case 'projects':
                          _scrollToSection(_projectsKey);
                          break;
                        case 'contact':
                          _scrollToSection(_contactKey);
                          break;
                      }
                    },
                  ),
                ),

                // About Section
                Container(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),

                // Skills Section
                Container(
                  key: _skillsKey,
                  child: const SkillsSection(),
                ),

                // Experience Section
                Container(
                  key: _experienceKey,
                  child: const ExperienceSection(),
                ),

                // Projects Section
                Container(
                  key: _projectsKey,
                  child: const ProjectsSection(),
                ),

                // Achievements Section
                Container(
                  key: _achievementsKey,
                  child: const AchievementsSection(),
                ),

                // Contact Section
                Container(
                  key: _contactKey,
                  child: const ContactSection(),
                ),

                // Footer
                const FooterSection(),
              ],
            ),
          ),

          // Custom App Bar
          CustomAppBar(
            onThemeToggle: widget.onThemeToggle,
            themeMode: widget.themeMode,
            onNavigate: (section) {
              switch (section) {
                case 'about':
                  _scrollToSection(_aboutKey);
                  break;
                case 'skills':
                  _scrollToSection(_skillsKey);
                  break;
                case 'experience':
                  _scrollToSection(_experienceKey);
                  break;
                case 'projects':
                  _scrollToSection(_projectsKey);
                  break;
                case 'achievements':
                  _scrollToSection(_achievementsKey);
                  break;
                case 'contact':
                  _scrollToSection(_contactKey);
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
