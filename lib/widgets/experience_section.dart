import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/theme.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _isVisible = false;

  final List<ExperienceItem> experiences = [
    ExperienceItem(
      title: 'Software Engineer',
      company: 'Future of Egypt',
      period: 'February 2025 – Present',
      location: 'Cairo, Egypt',
      description:
          'Leading Flutter-based web system development for digital transformation projects',
      responsibilities: [
        'Spearheaded Flutter-based web system development',
        'Designed new features aligned with internal workflows',
        'Built scalable, secure, high-performance solutions',
        'Refactored legacy codebases for enhanced maintainability',
        'Collaborated cross-functionally with stakeholders',
      ],
      icon: FontAwesomeIcons.building,
      color: AppTheme.primaryBlue,
    ),
    ExperienceItem(
      title: 'Freelance Flutter Developer',
      company: 'Syanatuk System',
      period: '2025',
      location: 'Remote',
      description:
          'Developed complete Windows desktop application for home appliance maintenance center',
      responsibilities: [
        'Built full-featured desktop app with Clean Architecture',
        'Implemented role-based access control system',
        'Integrated encrypted cloud backup with Blackblaze B2',
        'Set up CI/CD pipeline for automated builds and updates',
        'Deployed production-ready system with 60% efficiency improvement',
      ],
      icon: FontAwesomeIcons.desktop,
      color: AppTheme.primaryPurple,
    ),
    ExperienceItem(
      title: 'Freelance Flutter Developer',
      company: 'El Mohamady Educational Platform',
      period: '2020 – 2024',
      location: 'Remote',
      description:
          'Developed comprehensive educational platform for student management and assessment',
      responsibilities: [
        'Built mobile and web platform with Firebase backend',
        'Implemented exam system with automated grading',
        'Integrated live video and YouTube Data API',
        'Managed online exams and grading systems',
        'Maintained Clean Architecture with MVVM pattern',
      ],
      icon: FontAwesomeIcons.graduationCap,
      color: AppTheme.accentCyan,
    ),
    ExperienceItem(
      title: 'Lead Penetration Tester',
      company: 'Triple S - Graduation Project',
      period: 'July 2024 – November 2024',
      location: 'Suez Canal University',
      description:
          'Conducted comprehensive security assessment following OWASP standards',
      responsibilities: [
        'Applied OWASP Mobile Top 10 and MASVS standards',
        'Identified 12+ critical vulnerabilities',
        'Analyzed Firebase misconfigurations and API security',
        'Provided detailed remediation recommendations',
        'Improved security posture by 70%',
      ],
      icon: FontAwesomeIcons.shieldHalved,
      color: AppTheme.accentPink,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return VisibilityDetector(
      key: const Key('experience-section'),
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
        child: Column(
          children: [
            // Section Title
            Text(
              'Work Experience',
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
                'Professional Journey',
                style: AppTheme.bodyLarge(context).copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 16 : 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 60),

            // Timeline
            ...experiences.asMap().entries.map((entry) {
              final index = entry.key;
              final experience = entry.value;
              return _ExperienceCard(
                experience: experience,
                isVisible: _isVisible,
                delay: index * 200,
                isLast: index == experiences.length - 1,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ExperienceItem {
  final String title;
  final String company;
  final String period;
  final String location;
  final String description;
  final List<String> responsibilities;
  final IconData icon;
  final Color color;

  ExperienceItem({
    required this.title,
    required this.company,
    required this.period,
    required this.location,
    required this.description,
    required this.responsibilities,
    required this.icon,
    required this.color,
  });
}

class _ExperienceCard extends StatefulWidget {
  final ExperienceItem experience;
  final bool isVisible;
  final int delay;
  final bool isLast;

  const _ExperienceCard({
    required this.experience,
    required this.isVisible,
    required this.delay,
    required this.isLast,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_ExperienceCard oldWidget) {
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

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          widget.experience.color,
                          widget.experience.color.withOpacity(0.7),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.experience.color.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: FaIcon(
                        widget.experience.icon,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  if (!widget.isLast)
                    Container(
                      width: 2,
                      height: 200,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.experience.color.withOpacity(0.5),
                            widget.experience.color.withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 24),

              // Content
              Expanded(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) => setState(() => _isHovered = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: Matrix4.identity()
                      ..translate(_isHovered ? 10.0 : 0.0, 0.0),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _isHovered
                            ? widget.experience.color.withOpacity(0.5)
                            : widget.experience.color.withOpacity(0.2),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _isHovered
                              ? widget.experience.color.withOpacity(0.15)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: _isHovered ? 15 : 8,
                          offset: Offset(0, _isHovered ? 8 : 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Company
                        Text(
                          widget.experience.title,
                          style: AppTheme.heading4(context).copyWith(
                            fontSize: isMobile ? 18 : 22,
                            color: widget.experience.color,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.experience.company,
                          style: AppTheme.bodyLarge(context).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Period and Location
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.calendar,
                                  size: 14,
                                  color: AppTheme.mutedText,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.experience.period,
                                  style: AppTheme.bodySmall(context),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.locationDot,
                                  size: 14,
                                  color: AppTheme.mutedText,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.experience.location,
                                  style: AppTheme.bodySmall(context),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Description
                        Text(
                          widget.experience.description,
                          style: AppTheme.bodyMedium(context).copyWith(
                            fontStyle: FontStyle.italic,
                            color: AppTheme.mutedText,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Responsibilities
                        ...widget.experience.responsibilities.map(
                          (responsibility) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.experience.color,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    responsibility,
                                    style: AppTheme.bodyMedium(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
