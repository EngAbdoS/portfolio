import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/theme.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isVisible = false;

  final List<ContactMethod> contactMethods = [
    ContactMethod(
      icon: FontAwesomeIcons.envelope,
      title: 'Email',
      value: 'eng.abdelrahman.swidan@gmail.com',
      url: 'mailto:eng.abdelrahman.swidan@gmail.com',
      color: AppTheme.primaryBlue,
    ),
    ContactMethod(
      icon: FontAwesomeIcons.phone,
      title: 'Phone',
      value: '+20 109 578 6953',
      url: 'tel:+201095786953',
      color: AppTheme.primaryPurple,
    ),
    ContactMethod(
      icon: FontAwesomeIcons.linkedin,
      title: 'LinkedIn',
      value: 'abdelrahman-swidan',
      url: 'https://linkedin.com/in/abdelrahman-swidan',
      color: AppTheme.accentCyan,
    ),
    ContactMethod(
      icon: FontAwesomeIcons.github,
      title: 'GitHub',
      value: 'EngAbdoS',
      url: 'https://github.com/EngAbdoS',
      color: AppTheme.accentPink,
    ),
    ContactMethod(
      icon: FontAwesomeIcons.bug,
      title: 'Hextree',
      value: 'swidan',
      url: 'https://app.hextree.io/profile/swidan',
      color: AppTheme.accentCyan,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return VisibilityDetector(
      key: const Key('contact-section'),
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
              'Get In Touch',
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
                'Let\'s Work Together',
                style: AppTheme.bodyLarge(context).copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 16 : 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'I\'m always open to discussing new projects, creative ideas, or opportunities to be part of your vision. Feel free to reach out!',
                style: AppTheme.bodyMedium(context).copyWith(
                  color: AppTheme.mutedText,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 60),

            // Contact Methods Grid
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: contactMethods.asMap().entries.map((entry) {
                final index = entry.key;
                final method = entry.value;
                return _ContactCard(
                  method: method,
                  isVisible: _isVisible,
                  delay: index * 100,
                );
              }).toList(),
            ),

            const SizedBox(height: 60),

            // Location
            _LocationInfo(isVisible: _isVisible),
          ],
        ),
      ),
    );
  }
}

class ContactMethod {
  final IconData icon;
  final String title;
  final String value;
  final String url;
  final Color color;

  ContactMethod({
    required this.icon,
    required this.title,
    required this.value,
    required this.url,
    required this.color,
  });
}

class _ContactCard extends StatefulWidget {
  final ContactMethod method;
  final bool isVisible;
  final int delay;

  const _ContactCard({
    required this.method,
    required this.isVisible,
    required this.delay,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(_ContactCard oldWidget) {
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
              final uri = Uri.parse(widget.method.url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.identity()
                ..translate(0.0, _isHovered ? -10.0 : 0.0),
              width: isMobile ? double.infinity : 260,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered
                        ? widget.method.color.withOpacity(0.5)
                        : widget.method.color.withOpacity(0.2),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered
                          ? widget.method.color.withOpacity(0.2)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: _isHovered ? 20 : 10,
                      offset: Offset(0, _isHovered ? 10 : 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.method.color.withOpacity(0.2),
                            widget.method.color.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: FaIcon(
                          widget.method.icon,
                          color: widget.method.color,
                          size: 28,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Title
                    Text(
                      widget.method.title,
                      style: AppTheme.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: widget.method.color,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Value
                    Text(
                      widget.method.value,
                      style: AppTheme.bodySmall(context),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

class _LocationInfo extends StatefulWidget {
  final bool isVisible;

  const _LocationInfo({required this.isVisible});

  @override
  State<_LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<_LocationInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

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
  }

  @override
  void didUpdateWidget(_LocationInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      Future.delayed(const Duration(milliseconds: 400), () {
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryBlue.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FaIcon(
              FontAwesomeIcons.locationDot,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Based in',
                  style: AppTheme.bodySmall(context).copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cairo, Egypt',
                  style: AppTheme.bodyLarge(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
