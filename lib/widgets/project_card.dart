import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Color _parseColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return Colors.grey.shade100;
    }
    final hex = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLargeScreen = MediaQuery.of(context).size.width > 800;
    final cardColor = _parseColor(widget.project["card_color"] as String?);
    final techStacks = (widget.project["tech_stacks"] as List<dynamic>?) ?? [];
    final images = (widget.project["images"] as List<String>?) ?? [];
    final hasImages = images.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -4.0 : 0.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? theme.colorScheme.primary.withValues(alpha: 0.5)
                  : theme.colorScheme.outline.withValues(alpha: 0.1),
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: _isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 20 : 10,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Section
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Stack(
                  children: [
                    // Hero Image or Placeholder
                    AspectRatio(
                      aspectRatio: 16 / 10,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        transform: Matrix4.identity()
                          ..scale(_isHovered ? 1.05 : 1.0),
                        transformAlignment: Alignment.center,
                        child: hasImages
                            ? Image.asset(
                                images.first,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildImagePlaceholder(theme, cardColor);
                                },
                              )
                            : _buildImagePlaceholder(theme, cardColor),
                      ),
                    ),

                    // Gradient Overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.3),
                            ],
                            stops: const [0.5, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Logo Badge
                    Positioned(
                      left: 12,
                      bottom: 12,
                      child: Container(
                        width: isLargeScreen ? 44 : 40,
                        height: isLargeScreen ? 44 : 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.8),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: (widget.project["logo_path"] as String?)?.isNotEmpty == true
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.asset(
                                    widget.project["logo_path"] as String,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return _buildFallbackLogo(theme);
                                    },
                                  ),
                                )
                              : _buildFallbackLogo(theme),
                        ),
                      ),
                    ),

                    // Image Count Badge (if multiple images)
                    if (images.length > 1)
                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.photo_library_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${images.length}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Arrow Icon on Hover
                    Positioned(
                      right: 12,
                      top: 12,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _isHovered ? 1.0 : 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_outward_rounded,
                            size: 18,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content Section
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(isLargeScreen ? 20 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Title
                      Text(
                        widget.project["title"] as String? ?? "",
                        style: TextStyle(
                          fontSize: isLargeScreen ? 18 : 16,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // Project Description
                      Expanded(
                        child: Text(
                          widget.project["description"] as String? ?? "",
                          style: TextStyle(
                            fontSize: isLargeScreen ? 14 : 13,
                            fontWeight: FontWeight.w400,
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Tech Stack Chips
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: techStacks.take(3).map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: theme.colorScheme.outline.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Text(
                              tech as String,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(ThemeData theme, Color cardColor) {
    return Container(
      width: double.infinity,
      color: theme.brightness == Brightness.dark
          ? theme.colorScheme.surfaceContainerHighest
          : cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 40,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 8),
          Text(
            "Preview coming soon",
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackLogo(ThemeData theme) {
    final title = widget.project["title"] as String? ?? "PR";
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          title.substring(0, 2).toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
