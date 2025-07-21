// Widget to display individual project entries.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final Map<String, String> project;

  const ProjectCard({super.key, required this.project});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (kDebugMode) {
        print('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias, // Ensures image corners are rounded
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image
          Image.network(
            project["image_url"] ?? "https://placehold.co/600x400/CCCCCC/000?text=Project+Image",
            fit: BoxFit.cover,
            height: isLargeScreen ? 200 : 150,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => Container(
              height: isLargeScreen ? 200 : 150,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Center(
                child: Icon(Icons.broken_image, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project["company"]!, // Using company as project title
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project["description"] ?? "No description available.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                    onPressed: () => _launchUrl(PortfolioData.githubUrl), // Link to GitHub or specific project URL
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('View Project'),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}