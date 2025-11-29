import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/project.dart';
import '../utils/theme.dart';
import '../widgets/project_detail_dialog.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isVisible = false;
  String _selectedFilter = 'all'; // 'all', 'flutter', 'security'

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    List<Project> projects;
    switch (_selectedFilter) {
      case 'flutter':
        projects = ProjectsData.getFlutterProjects();
        break;
      case 'security':
        projects = ProjectsData.getSecurityProjects();
        break;
      default:
        projects = ProjectsData.getAllProjects();
    }

    return VisibilityDetector(
      key: const Key('projects-section'),
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
              'Featured Projects',
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
                'Showcasing Development & Security Expertise',
                style: AppTheme.bodyLarge(context).copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 16 : 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 40),

            // Filter Buttons
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _FilterButton(
                  label: 'All Projects',
                  isSelected: _selectedFilter == 'all',
                  onTap: () => setState(() => _selectedFilter = 'all'),
                ),
                _FilterButton(
                  label: 'Flutter Development',
                  isSelected: _selectedFilter == 'flutter',
                  onTap: () => setState(() => _selectedFilter = 'flutter'),
                ),
                _FilterButton(
                  label: 'Security Testing',
                  isSelected: _selectedFilter == 'security',
                  onTap: () => setState(() => _selectedFilter = 'security'),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // Projects Grid
            _buildProjectsGrid(projects, isMobile, isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(List<Project> projects, bool isMobile, bool isTablet) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: projects.asMap().entries.map((entry) {
        final index = entry.key;
        final project = entry.value;
        return _ProjectCard(
          key: ValueKey(project.title),
          project: project,
          isVisible: _isVisible,
          delay: index * 150,
        );
      }).toList(),
    );
  }
}

class _FilterButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<_FilterButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        decoration: BoxDecoration(
          gradient: widget.isSelected ? AppTheme.primaryGradient : null,
          color: widget.isSelected ? null : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isSelected
                ? Colors.transparent
                : AppTheme.primaryBlue.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                widget.label,
                style: AppTheme.bodyMedium(context).copyWith(
                  color: widget.isSelected ? Colors.white : null,
                  fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final bool isVisible;
  final int delay;

  const _ProjectCard({
    required this.project,
    required this.isVisible,
    required this.delay, required ValueKey<String> key,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
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

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(_ProjectCard oldWidget) {
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
    final categoryColor = widget.project.category == 'flutter'
        ? AppTheme.primaryBlue
        : AppTheme.primaryPurple;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ProjectDetailDialog(project: widget.project),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.identity()
                ..translate(0.0, _isHovered ? -10.0 : 0.0),
              width: isMobile ? double.infinity : 400,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isHovered
                        ? categoryColor.withOpacity(0.5)
                        : categoryColor.withOpacity(0.2),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered
                          ? categoryColor.withOpacity(0.2)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: _isHovered ? 20 : 10,
                      offset: Offset(0, _isHovered ? 10 : 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Image/Placeholder
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            categoryColor.withOpacity(0.3),
                            categoryColor.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                        child: widget.project.screenshots != null &&
                                widget.project.screenshots!.isNotEmpty
                            ? Image.asset(
                                widget.project.screenshots!.first,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: FaIcon(
                                      widget.project.category == 'flutter'
                                          ? FontAwesomeIcons.mobile
                                          : FontAwesomeIcons.shield,
                                      size: 60,
                                      color: categoryColor.withOpacity(0.5),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: FaIcon(
                                  widget.project.category == 'flutter'
                                      ? FontAwesomeIcons.mobile
                                      : FontAwesomeIcons.shield,
                                  size: 60,
                                  color: categoryColor.withOpacity(0.5),
                                ),
                              ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  categoryColor.withOpacity(0.2),
                                  categoryColor.withOpacity(0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.project.category == 'flutter'
                                  ? 'Flutter Development'
                                  : 'Security Testing',
                              style: AppTheme.bodySmall(context).copyWith(
                                color: categoryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Title
                          Text(
                            widget.project.title,
                            style: AppTheme.heading4(context).copyWith(
                              fontSize: 20,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 8),

                          // Subtitle
                          Text(
                            widget.project.subtitle,
                            style: AppTheme.bodyMedium(context).copyWith(
                              color: AppTheme.mutedText,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 16),

                          // Description
                          Text(
                            widget.project.description,
                            style: AppTheme.bodyMedium(context),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 16),

                          // Period
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.calendar,
                                size: 14,
                                color: AppTheme.mutedText,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.project.period,
                                style: AppTheme.bodySmall(context),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Technologies (first 3)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.project.technologies
                                .take(3)
                                .map(
                                  (tech) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: categoryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      tech,
                                      style: AppTheme.caption(context).copyWith(
                                        color: categoryColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),

                          const SizedBox(height: 20),

                          // View Details Button
                          Center(
                            child: TextButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      ProjectDetailDialog(project: widget.project),
                                );
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.arrowRight,
                                size: 14,
                              ),
                              label: const Text('View Details'),
                              style: TextButton.styleFrom(
                                foregroundColor: categoryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
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
