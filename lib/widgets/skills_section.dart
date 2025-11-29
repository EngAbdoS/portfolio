import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/theme.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : (isTablet ? 60 : 120),
          vertical: isMobile ? 60 : 100,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.darkCard.withOpacity(0.3)
              : AppTheme.lightCard,
        ),
        child: Column(
          children: [
            // Section Title
            Text(
              'Skills & Expertise',
              style: AppTheme.heading2(context).copyWith(
                fontSize: isMobile ? 32 : 48,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                'Technical Proficiency',
                style: AppTheme.bodyLarge(context).copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 16 : 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 60),

            // Skills Categories
            _buildSkillsGrid(context, isMobile, isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsGrid(BuildContext context, bool isMobile, bool isTablet) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        _SkillCard(
          title: 'Flutter Development',
          icon: FontAwesomeIcons.mobile,
          skills: [
            SkillItem('Cross-platform (Android, iOS, Web, Desktop)', 95),
            SkillItem('Clean Architecture & MVVM', 90),
            SkillItem('State Management (Bloc, Provider)', 85),
            SkillItem('Firebase Integration', 90),
            SkillItem('RESTful API Integration', 88),
            SkillItem('CI/CD Automation', 85),
          ],
          color: AppTheme.primaryBlue,
          isVisible: _isVisible,
          delay: 0,
        ),
        _SkillCard(
          title: 'Cybersecurity',
          icon: FontAwesomeIcons.shield,
          skills: [
            SkillItem('OWASP Top 10 (Web & Mobile)', 85),
            SkillItem('Penetration Testing', 80),
            SkillItem('Mobile App Security (MASVS)', 85),
            SkillItem('Network Security', 75),
            SkillItem('API Security Testing', 80),
            SkillItem('Security Compliance Reporting', 85),
          ],
          color: AppTheme.primaryPurple,
          isVisible: _isVisible,
          delay: 200,
        ),
        _SkillCard(
          title: 'Tools & Technologies',
          icon: FontAwesomeIcons.toolbox,
          skills: [
            SkillItem('Burp Suite & OWASP ZAP', 80),
            SkillItem('MobSF & Frida', 75),
            SkillItem('Git & Version Control', 90),
            SkillItem('Firebase & Cloud Services', 85),
            SkillItem('Nmap & Wireshark', 75),
            SkillItem('Python & Bash Scripting', 70),
          ],
          color: AppTheme.accentCyan,
          isVisible: _isVisible,
          delay: 400,
        ),
      ],
    );
  }
}

class SkillItem {
  final String name;
  final int proficiency;

  SkillItem(this.name, this.proficiency);
}

class _SkillCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<SkillItem> skills;
  final Color color;
  final bool isVisible;
  final int delay;

  const _SkillCard({
    required this.title,
    required this.icon,
    required this.skills,
    required this.color,
    required this.isVisible,
    required this.delay,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(_SkillCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -10.0 : 0.0),
        child: Container(
          width: isMobile ? double.infinity : 380,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? widget.color.withOpacity(0.5)
                  : widget.color.withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.color.withOpacity(0.2)
                    : Colors.black.withOpacity(0.05),
                blurRadius: _isHovered ? 20 : 10,
                offset: Offset(0, _isHovered ? 10 : 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.color.withOpacity(0.2),
                          widget.color.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FaIcon(
                      widget.icon,
                      size: 32,
                      color: widget.color,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: AppTheme.heading4(context).copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Skills List
              ...widget.skills.map((skill) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                skill.name,
                                style: AppTheme.bodyMedium(context),
                              ),
                            ),
                            Text(
                              '${skill.proficiency}%',
                              style: AppTheme.bodySmall(context).copyWith(
                                color: widget.color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Stack(
                              children: [
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: widget.color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: (skill.proficiency / 100) * _animation.value,
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          widget.color,
                                          widget.color.withOpacity(0.7),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: widget.color.withOpacity(0.3),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
