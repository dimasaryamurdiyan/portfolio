import 'package:flutter/material.dart';
import 'package:portfolio/constants/design_constants.dart';
import 'package:portfolio/utils/color_utils.dart';
import 'package:portfolio/utils/url_launcher_service.dart';
import 'package:portfolio/widgets/image_carousel.dart';

class ProjectDetailDialog extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailDialog({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > DesignConstants.tabletBreakpoint;
    final cardColor = ColorUtils.parseHex(project["card_color"] as String?);
    final techStacks = (project["tech_stacks"] as List<dynamic>?) ?? [];
    final images = (project["images"] as List<String>?) ?? [];
    final playStoreUrl = project["play_store_url"] as String? ?? "";
    final githubUrl = project["github_url"] as String? ?? "";

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 80 : 16,
        vertical: isLargeScreen ? 40 : 24,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 800,
          maxHeight: screenSize.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.25),
              blurRadius: 50,
              offset: const Offset(0, 25),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image Carousel Section
              Stack(
                children: [
                  ImageCarousel(
                    images: images,
                    height: isLargeScreen ? 350 : 260,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    showArrows: true,
                    showIndicators: true,
                    imageFit: BoxFit.contain,
                    placeholderColor: theme.brightness == Brightness.dark
                        ? theme.colorScheme.surfaceContainerHighest
                        : cardColor.withValues(alpha: 0.5),
                  ),

                  // Close Button
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Material(
                      color: theme.colorScheme.surface.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.close_rounded,
                            size: 24,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Logo Badge
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Container(
                      width: isLargeScreen ? 64 : 56,
                      height: isLargeScreen ? 64 : 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (project["logo_path"] as String?)?.isNotEmpty == true
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  project["logo_path"] as String,
                                  fit: BoxFit.contain,
                                  cacheWidth: 128, // 2x the display size for retina
                                  cacheHeight: 128,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildFallbackLogo(theme);
                                  },
                                ),
                              )
                            : _buildFallbackLogo(theme),
                      ),
                    ),
                  ),
                ],
              ),

              // Scrollable Content
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isLargeScreen ? 32 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Title
                      Text(
                        project["title"] as String? ?? "",
                        style: TextStyle(
                          fontFamily: 'Black Han Sans',
                          fontSize: isLargeScreen ? 32 : 24,
                          color: theme.colorScheme.onSurface,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Short Description
                      Text(
                        project["description"] as String? ?? "",
                        style: TextStyle(
                          fontSize: isLargeScreen ? 16 : 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Tech Stack Section
                      _buildSectionTitle(theme, "Technologies", isLargeScreen),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: techStacks.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              tech as String,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 28),

                      // Detailed Description
                      _buildSectionTitle(theme, "About the Project", isLargeScreen),
                      const SizedBox(height: 12),
                      Text(
                        project["detailed_description"] as String? ?? "",
                        style: TextStyle(
                          fontSize: isLargeScreen ? 15 : 14,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.7,
                        ),
                      ),

                      // Links Section
                      if (playStoreUrl.isNotEmpty || githubUrl.isNotEmpty) ...[
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                                theme.colorScheme.secondaryContainer.withValues(alpha: 0.2),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.outline.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.launch_rounded,
                                    size: 20,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "View Project",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Check out the live project or source code",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  if (playStoreUrl.isNotEmpty)
                                    _buildLinkButton(
                                      context,
                                      icon: Icons.shop_rounded,
                                      label: "Play Store",
                                      onTap: () => UrlLauncherService.launch(playStoreUrl),
                                    ),
                                  if (githubUrl.isNotEmpty)
                                    _buildLinkButton(
                                      context,
                                      icon: Icons.code_rounded,
                                      label: "GitHub",
                                      onTap: () => UrlLauncherService.launch(githubUrl),
                                      isPrimary: false,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Bottom padding
                      const SizedBox(height: 8),
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

  Widget _buildSectionTitle(ThemeData theme, String title, bool isLargeScreen) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: isLargeScreen ? 18 : 16,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildLinkButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isPrimary = true,
  }) {
    final theme = Theme.of(context);
    return Material(
      color: isPrimary ? theme.colorScheme.primary : theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: isPrimary
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isPrimary
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isPrimary
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackLogo(ThemeData theme) {
    final title = project["title"] as String? ?? "PR";
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          title.substring(0, 2).toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
