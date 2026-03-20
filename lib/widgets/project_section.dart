import 'package:flutter/material.dart';
import 'package:portfolio/constants/design_constants.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/widgets/project_card.dart';
import 'package:portfolio/widgets/project_detail_dialog.dart';

class ProjectSection extends StatelessWidget {
  final Function(String)? onProjectTap;

  const ProjectSection({
    super.key,
    this.onProjectTap,
  });

  void _showProjectDetail(BuildContext context, Map<String, dynamic> project) {
    onProjectTap?.call(project["title"] as String? ?? "");

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (context) => ProjectDetailDialog(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > DesignConstants.tabletBreakpoint;
    final isMediumScreen = MediaQuery.of(context).size.width > DesignConstants.mobileBreakpoint;
    final theme = Theme.of(context);

    // Calculate grid columns based on screen size
    int crossAxisCount;
    if (isLargeScreen) {
      crossAxisCount = 3;
    } else if (isMediumScreen) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isLargeScreen ? DesignConstants.paddingLargeVertical : DesignConstants.paddingSmallVertical,
        horizontal: isLargeScreen ? DesignConstants.paddingLargeHorizontal : DesignConstants.paddingSmallHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Projects",
                style: TextStyle(
                  fontFamily: 'Black Han Sans',
                  fontSize: isLargeScreen ? 40 : 28,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 80,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.onSurface,
                      theme.colorScheme.onSurfaceVariant,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Here are some of the projects I've worked on",
                style: TextStyle(
                  fontSize: isLargeScreen ? 16 : 14,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),

          // Project Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              // Adjusted aspect ratio for cards with hero images
              childAspectRatio: isLargeScreen ? 0.72 : (isMediumScreen ? 0.75 : 0.85),
            ),
            itemCount: PortfolioData.projects.length,
            itemBuilder: (context, index) {
              final project = PortfolioData.projects[index];
              return ProjectCard(
                project: project,
                onTap: () => _showProjectDetail(context, project),
              );
            },
          ),
        ],
      ),
    );
  }
}
