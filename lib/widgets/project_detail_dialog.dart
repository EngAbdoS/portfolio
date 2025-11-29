import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../models/project.dart';
import '../utils/theme.dart';

class ProjectDetailDialog extends StatefulWidget {
  final Project project;

  const ProjectDetailDialog({super.key, required this.project});

  @override
  State<ProjectDetailDialog> createState() => _ProjectDetailDialogState();
}

class _ProjectDetailDialogState extends State<ProjectDetailDialog> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.project.videoPath != null) {
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.asset(widget.project.videoPath!);
    await _videoController!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: false,
      looping: false,
      aspectRatio: _videoController!.value.aspectRatio,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            'Error loading video',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final categoryColor = widget.project.category == 'flutter'
        ? AppTheme.primaryBlue
        : AppTheme.primaryPurple;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: isMobile ? size.width * 0.9 : size.width * 0.8,
        constraints: BoxConstraints(
          maxHeight: size.height * 0.9,
          maxWidth: 1200,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: categoryColor.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    categoryColor.withOpacity(0.2),
                    categoryColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.2),
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
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const FaIcon(FontAwesomeIcons.xmark),
                    color: AppTheme.mutedText,
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.project.title,
                      style: AppTheme.heading3(context).copyWith(
                        fontSize: isMobile ? 24 : 32,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      widget.project.subtitle,
                      style: AppTheme.bodyLarge(context).copyWith(
                        color: categoryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Period
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.calendar,
                          size: 16,
                          color: AppTheme.mutedText,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.project.period,
                          style: AppTheme.bodyMedium(context).copyWith(
                            color: AppTheme.mutedText,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Media Section (Video or Images)
                    if (widget.project.videoPath != null) ...[
                      _buildVideoPlayer(),
                      const SizedBox(height: 24),
                    ] else if (widget.project.screenshots != null &&
                        widget.project.screenshots!.isNotEmpty) ...[
                      _buildImageCarousel(),
                      const SizedBox(height: 24),
                    ],

                    // Description
                    Text(
                      'Overview',
                      style: AppTheme.heading4(context),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.project.description,
                      style: AppTheme.bodyMedium(context).copyWith(
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Technologies
                    Text(
                      'Technologies',
                      style: AppTheme.heading4(context),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.technologies
                          .map(
                            (tech) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: categoryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: categoryColor.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                tech,
                                style: AppTheme.bodySmall(context).copyWith(
                                  color: categoryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 24),

                    // Key Features
                    Text(
                      'Key Features',
                      style: AppTheme.heading4(context),
                    ),
                    const SizedBox(height: 12),
                    ...widget.project.keyFeatures.map(
                      (feature) => Padding(
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
                                color: categoryColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: AppTheme.bodyMedium(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (widget.project.achievements != null &&
                        widget.project.achievements!.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Achievements',
                        style: AppTheme.heading4(context),
                      ),
                      const SizedBox(height: 12),
                      ...widget.project.achievements!.map(
                        (achievement) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.trophy,
                                size: 14,
                                color: AppTheme.accentPink,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  achievement,
                                  style: AppTheme.bodyMedium(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Links
                    if (widget.project.githubUrl != null ||
                        widget.project.liveUrl != null)
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          if (widget.project.githubUrl != null)
                            _buildLinkButton(
                              'View on GitHub',
                              FontAwesomeIcons.github,
                              widget.project.githubUrl!,
                            ),
                          if (widget.project.liveUrl != null)
                            _buildLinkButton(
                              'Live Demo',
                              FontAwesomeIcons.arrowUpRightFromSquare,
                              widget.project.liveUrl!,
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_chewieController == null) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: Chewie(controller: _chewieController!),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    final screenshots = widget.project.screenshots!;

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 400,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enableInfiniteScroll: screenshots.length > 1,
            onPageChanged: (index, reason) {
              setState(() => _currentImageIndex = index);
            },
          ),
          items: screenshots.map((screenshot) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  screenshot,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 60),
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
        if (screenshots.length > 1) ...[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: screenshots.asMap().entries.map((entry) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == entry.key
                      ? AppTheme.primaryBlue
                      : AppTheme.mutedText.withOpacity(0.3),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildLinkButton(String label, IconData icon, String url) {
    return ElevatedButton.icon(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      icon: FaIcon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
