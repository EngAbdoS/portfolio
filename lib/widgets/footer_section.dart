import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkCard
            : AppTheme.lightCard,
        border: Border(
          top: BorderSide(
            color: AppTheme.primaryBlue.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Social Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIconButton(
                icon: FontAwesomeIcons.github,
                url: 'https://github.com/EngAbdoS',
              ),
              const SizedBox(width: 16),
              _SocialIconButton(
                icon: FontAwesomeIcons.linkedin,
                url: 'https://linkedin.com/in/abdelrahman-swidan',
              ),
              const SizedBox(width: 16),
              _SocialIconButton(
                icon: FontAwesomeIcons.envelope,
                url: 'mailto:eng.abdelrahman.swidan@gmail.com',
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Divider
          Container(
            width: isMobile ? double.infinity : 400,
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppTheme.primaryBlue.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Copyright
          Text(
            '© ${DateTime.now().year} Abdelrahman Swidan. All rights reserved.',
            style: AppTheme.bodySmall(context),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Tagline
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              'Built with Flutter 💙',
              style: AppTheme.bodySmall(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialIconButton({
    required this.icon,
    required this.url,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
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
          ),
          color: _isHovered ? AppTheme.primaryBlue : AppTheme.mutedText,
        ),
      ),
    );
  }
}
