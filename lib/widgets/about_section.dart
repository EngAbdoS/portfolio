import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/theme.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() => _isVisible = true);
          _controller.forward();
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : (isTablet ? 60 : 120),
          vertical: isMobile ? 60 : 100,
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                // Section Title
                Text(
                  'About Me',
                  style: AppTheme.heading2(context).copyWith(
                    fontSize: isMobile ? 32 : 48,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Subtitle
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    'Software Engineer & Security Specialist',
                    style: AppTheme.bodyLarge(context).copyWith(
                      color: Colors.white,
                      fontSize: isMobile ? 16 : 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 60),

                // Content
                if (isMobile)
                  Column(
                    children: [
                      _buildProfileImage(),
                      const SizedBox(height: 40),
                      _buildAboutContent(context, isMobile),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildAboutContent(context, isMobile),
                      ),
                      const SizedBox(width: 60),
                      Expanded(
                        flex: 1,
                        child: _buildProfileImage(),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppTheme.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 300,
          height: 300,
          color: Theme.of(context).cardColor,
          child: Image.asset(
            'projects_assets/my_photo.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.person,
                size: 120,
                color: AppTheme.primaryBlue,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello! I\'m Abdelrahman Swidan',
          style: AppTheme.heading3(context).copyWith(
            fontSize: isMobile ? 24 : 32,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          'A passionate Software Engineer specializing in Flutter development and Cybersecurity. I bridge the gap between development and security, building robust applications while ensuring they\'re secure by design.',
          style: AppTheme.bodyLarge(context).copyWith(
            height: 1.8,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'With production-grade experience across Android, web, and desktop platforms, I excel in Clean Architecture, SOLID principles, and modern design patterns. My expertise extends to penetration testing, where I apply OWASP standards to identify and remediate security vulnerabilities.',
          style: AppTheme.bodyLarge(context).copyWith(
            height: 1.8,
          ),
        ),

        const SizedBox(height: 32),

        // Key Points
        _buildKeyPoint(
          context,
          'Flutter Expert',
          'Production-grade apps across mobile, web, and desktop platforms',
        ),
        const SizedBox(height: 16),
        _buildKeyPoint(
          context,
          'Security Focused',
          'Penetration Tester with hands-on mobile and web security experience',
        ),
        const SizedBox(height: 16),
        _buildKeyPoint(
          context,
          'Problem Solver',
          'Strong analytical skills with competitive programming background',
        ),

        const SizedBox(height: 32),

        // Education & Location
        Wrap(
          spacing: 32,
          runSpacing: 16,
          children: [
            _buildInfoChip(
              context,
              Icons.school,
              'Bachelor\'s in Computer Science',
            ),
            _buildInfoChip(
              context,
              Icons.location_on,
              'Cairo, Egypt',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKeyPoint(BuildContext context, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.primaryGradient,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.bodyLarge(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryBlue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTheme.bodyMedium(context).copyWith(
                  color: AppTheme.mutedText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryBlue.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTheme.bodyMedium(context),
          ),
        ],
      ),
    );
  }
}
