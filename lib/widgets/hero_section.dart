import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme.dart';

class HeroSection extends StatelessWidget {
  final Function(String) onNavigate;

  const HeroSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.heroGradient
            : const LinearGradient(
                colors: [Color(0xFFF8F9FA), Color(0xFFE8EAF6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
      ),
      child: Stack(
        children: [
          // Animated Background Elements
          ...List.generate(20, (index) {
            return Positioned(
              left: (index * 100) % size.width,
              top: (index * 80) % size.height,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 2000 + (index * 200)),
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: 0.05 * value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppTheme.primaryBlue.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),

          // Main Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : (isTablet ? 60 : 120),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Greeting
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: ShaderMask(
                            shaderCallback: (bounds) =>
                                AppTheme.primaryGradient.createShader(bounds),
                            child: Text(
                              'Hello, I\'m',
                              style: AppTheme.bodyLarge(context).copyWith(
                                color: Colors.white,
                                fontSize: isMobile ? 18 : 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Name
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1000),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: Text(
                            'Abdelrahman Swidan',
                            style: AppTheme.heading1(context).copyWith(
                              fontSize: isMobile ? 36 : (isTablet ? 48 : 64),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Animated Titles
                  SizedBox(
                    height: isMobile ? 80 : 100,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Software Engineer',
                          textStyle: AppTheme.heading3(context).copyWith(
                            fontSize: isMobile ? 20 : (isTablet ? 28 : 32),
                            color: AppTheme.primaryBlue,
                          ),
                          speed: const Duration(milliseconds: 100),
                          textAlign: TextAlign.center,
                        ),
                        TypewriterAnimatedText(
                          'Flutter Developer',
                          textStyle: AppTheme.heading3(context).copyWith(
                            fontSize: isMobile ? 20 : (isTablet ? 28 : 32),
                            color: AppTheme.primaryPurple,
                          ),
                          speed: const Duration(milliseconds: 100),
                          textAlign: TextAlign.center,
                        ),
                        TypewriterAnimatedText(
                          'Penetration Tester',
                          textStyle: AppTheme.heading3(context).copyWith(
                            fontSize: isMobile ? 20 : (isTablet ? 28 : 32),
                            color: AppTheme.accentCyan,
                          ),
                          speed: const Duration(milliseconds: 100),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      repeatForever: true,
                      pause: const Duration(milliseconds: 2000),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Tagline
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1400),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: isMobile ? 300 : 600,
                            ),
                            child: Text(
                              'Building robust Flutter applications while ensuring they\'re secure by design through penetration testing expertise',
                              style: AppTheme.bodyLarge(context).copyWith(
                                color: AppTheme.mutedText,
                                fontSize: isMobile ? 14 : 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 48),

                  // CTA Buttons
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1600),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              _GradientButton(
                                label: 'View Projects',
                                icon: FontAwesomeIcons.folderOpen,
                                onPressed: () => onNavigate('projects'),
                              ),
                              _OutlineButton(
                                label: 'Contact Me',
                                icon: FontAwesomeIcons.envelope,
                                onPressed: () => onNavigate('contact'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 48),

                  // Social Links
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1800),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _SocialIcon(
                              icon: FontAwesomeIcons.github,
                              url: 'https://github.com/EngAbdoS',
                              delay: 0,
                            ),
                            const SizedBox(width: 16),
                            _SocialIcon(
                              icon: FontAwesomeIcons.linkedin,
                              url: 'https://linkedin.com/in/abdelrahman-swidan',
                              delay: 100,
                            ),
                            const SizedBox(width: 16),
                            _SocialIcon(
                              icon: FontAwesomeIcons.envelope,
                              url: 'mailto:eng.abdelrahman.swidan@gmail.com',
                              delay: 200,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Scroll Indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 2000),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Column(
                    children: [
                      Text(
                        'Scroll Down',
                        style: AppTheme.bodySmall(context),
                      ),
                      const SizedBox(height: 8),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 10),
                        duration: const Duration(milliseconds: 1000),
                        builder: (context, double offset, child) {
                          return Transform.translate(
                            offset: Offset(0, offset),
                            child: const FaIcon(
                              FontAwesomeIcons.chevronDown,
                              size: 16,
                              color: AppTheme.mutedText,
                            ),
                          );
                        },
                        onEnd: () {
                          // Repeat animation
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          icon: FaIcon(widget.icon, size: 18),
          label: Text(widget.label),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: _isHovered ? 8 : 4,
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: OutlinedButton.icon(
          onPressed: widget.onPressed,
          icon: FaIcon(widget.icon, size: 18),
          label: Text(widget.label),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            foregroundColor: AppTheme.primaryBlue,
            side: BorderSide(
              color: AppTheme.primaryBlue,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final int delay;

  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.delay,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -5.0 : 0.0),
        child: IconButton(
          onPressed: () async {
            final uri = Uri.parse(widget.url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          icon: FaIcon(
            widget.icon,
            size: 24,
            color: _isHovered ? AppTheme.primaryBlue : AppTheme.mutedText,
          ),
        ),
      ),
    );
  }
}
