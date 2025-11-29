import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/theme.dart';

class AchievementsSection extends StatefulWidget {
  const AchievementsSection({super.key});

  @override
  State<AchievementsSection> createState() => _AchievementsSectionState();
}

class _AchievementsSectionState extends State<AchievementsSection> {
  bool _isVisible = false;

  final List<Achievement> achievements = [
    Achievement(
      title: 'Top #43 on Hextree Platform',
      subtitle: 'Android Penetration Testing',
      description:
          'Ranked in top 43 on Hextree leaderboard for Google-sponsored Android security challenges',
      icon: FontAwesomeIcons.bug,
      color: AppTheme.accentPink,
      stats: '43rd Place',
      url: 'https://app.hextree.io/profile/swidan',
    ),
    Achievement(
      title: 'DEPI Certification',
      subtitle: 'Vulnerability Analysis & Penetration Testing',
      description:
          'Digital Egypt Pioneers Initiative - Comprehensive penetration testing training',
      icon: FontAwesomeIcons.certificate,
      color: AppTheme.primaryPurple,
      stats: 'Certified',
    ),
    Achievement(
      title: 'Bachelor\'s Degree',
      subtitle: 'Computer and Informatics',
      description: 'Suez Canal University - Strong foundation in computer science',
      icon: FontAwesomeIcons.graduationCap,
      color: AppTheme.primaryBlue,
      stats: 'Graduate',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return VisibilityDetector(
      key: const Key('achievements-section'),
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
              'Achievements & Certifications',
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
                'Recognition & Milestones',
                style: AppTheme.bodyLarge(context).copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 16 : 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 60),

            // Achievements Grid
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: achievements.asMap().entries.map((entry) {
                final index = entry.key;
                final achievement = entry.value;
                return _AchievementCard(
                  achievement: achievement,
                  isVisible: _isVisible,
                  delay: index * 150,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Achievement {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final String stats;
  final String? url;

  Achievement({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.stats,
    this.url,
  });
}

class _AchievementCard extends StatefulWidget {
  final Achievement achievement;
  final bool isVisible;
  final int delay;

  const _AchievementCard({
    required this.achievement,
    required this.isVisible,
    required this.delay,
  });

  @override
  State<_AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<_AchievementCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(_AchievementCard oldWidget) {
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
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: () async {
              if (widget.achievement.url != null) {
                final uri = Uri.parse(widget.achievement.url!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.identity()
                ..rotateZ(_isHovered ? 0.01 : 0)
                ..scale(_isHovered ? 1.05 : 1.0),
              width: isMobile ? double.infinity : 280,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isHovered
                        ? widget.achievement.color.withOpacity(0.5)
                        : widget.achievement.color.withOpacity(0.2),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered
                          ? widget.achievement.color.withOpacity(0.3)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: _isHovered ? 25 : 10,
                      offset: Offset(0, _isHovered ? 15 : 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            widget.achievement.color,
                            widget.achievement.color.withOpacity(0.6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.achievement.color.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: FaIcon(
                          widget.achievement.icon,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Stats Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.achievement.color.withOpacity(0.2),
                            widget.achievement.color.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.achievement.stats,
                            style: AppTheme.bodySmall(context).copyWith(
                              color: widget.achievement.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.achievement.url != null) ...[
                            const SizedBox(width: 4),
                            FaIcon(
                              FontAwesomeIcons.arrowUpRightFromSquare,
                              size: 10,
                              color: widget.achievement.color,
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Title
                    Text(
                      widget.achievement.title,
                      style: AppTheme.heading4(context).copyWith(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      widget.achievement.subtitle,
                      style: AppTheme.bodyMedium(context).copyWith(
                        color: widget.achievement.color,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    // Description
                    Text(
                      widget.achievement.description,
                      style: AppTheme.bodySmall(context),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
