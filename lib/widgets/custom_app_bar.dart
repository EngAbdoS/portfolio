import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/theme.dart';

class CustomAppBar extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode themeMode;
  final Function(String) onNavigate;

  const CustomAppBar({
    super.key,
    required this.onThemeToggle,
    required this.themeMode,
    required this.onNavigate,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    // Listen to scroll events would be handled by parent
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: _isScrolled
              ? (isDark ? AppTheme.darkCard.withOpacity(0.95) : AppTheme.lightCard.withOpacity(0.95))
              : Colors.transparent,
          boxShadow: _isScrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo/Name
            ShaderMask(
              shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                'AS',
                style: AppTheme.heading3(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Navigation Items (Desktop)
            if (!isMobile) ...[
              Row(
                children: [
                  _NavItem(
                    label: 'About',
                    onTap: () => widget.onNavigate('about'),
                  ),
                  const SizedBox(width: 32),
                  _NavItem(
                    label: 'Skills',
                    onTap: () => widget.onNavigate('skills'),
                  ),
                  const SizedBox(width: 32),
                  _NavItem(
                    label: 'Experience',
                    onTap: () => widget.onNavigate('experience'),
                  ),
                  const SizedBox(width: 32),
                  _NavItem(
                    label: 'Projects',
                    onTap: () => widget.onNavigate('projects'),
                  ),
                  const SizedBox(width: 32),
                  _NavItem(
                    label: 'Contact',
                    onTap: () => widget.onNavigate('contact'),
                  ),
                  const SizedBox(width: 32),
                  
                  // Theme Toggle
                  IconButton(
                    onPressed: widget.onThemeToggle,
                    icon: FaIcon(
                      widget.themeMode == ThemeMode.dark
                          ? FontAwesomeIcons.sun
                          : FontAwesomeIcons.moon,
                      size: 20,
                    ),
                    tooltip: 'Toggle Theme',
                  ),
                ],
              ),
            ],

            // Mobile Menu
            if (isMobile) ...[
              Row(
                children: [
                  IconButton(
                    onPressed: widget.onThemeToggle,
                    icon: FaIcon(
                      widget.themeMode == ThemeMode.dark
                          ? FontAwesomeIcons.sun
                          : FontAwesomeIcons.moon,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showMobileMenu(context);
                    },
                    icon: const FaIcon(FontAwesomeIcons.bars, size: 20),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MobileNavItem(
              label: 'About',
              icon: FontAwesomeIcons.user,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('about');
              },
            ),
            _MobileNavItem(
              label: 'Skills',
              icon: FontAwesomeIcons.code,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('skills');
              },
            ),
            _MobileNavItem(
              label: 'Experience',
              icon: FontAwesomeIcons.briefcase,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('experience');
              },
            ),
            _MobileNavItem(
              label: 'Projects',
              icon: FontAwesomeIcons.folderOpen,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('projects');
              },
            ),
            _MobileNavItem(
              label: 'Contact',
              icon: FontAwesomeIcons.envelope,
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate('contact');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTheme.bodyMedium(context).copyWith(
            color: _isHovered ? AppTheme.primaryBlue : null,
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            FaIcon(icon, size: 20, color: AppTheme.primaryBlue),
            const SizedBox(width: 16),
            Text(
              label,
              style: AppTheme.bodyLarge(context),
            ),
          ],
        ),
      ),
    );
  }
}
