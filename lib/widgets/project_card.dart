// Widget to display individual project entries.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final Map<String, String> project;

  const ProjectCard({super.key, required this.project});

  // Helper to convert hex string to Color
  Color _hexToColor(String hexCode) {
    String formattedHex = hexCode.replaceAll("#", "");
    if (formattedHex.length == 6) {
      formattedHex = "FF$formattedHex"; // Add full opacity
    }
    return Color(int.parse(formattedHex, radix: 16));
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if(kDebugMode) {
        print('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Removed isLargeScreen as it's not directly used for card internal layout anymore
    // and the card itself is responsive via GridView.builder's childAspectRatio

    return Card(
      elevation: 0, // Set elevation to 0 to match flat design in screenshot
      margin: const EdgeInsets.symmetric(vertical: 0.0), // No vertical margin on the card itself
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Slightly less rounded than before to match screenshot
      clipBehavior: Clip.antiAlias,
      color: _hexToColor(project["card_color"] ?? "#FFFFFF"), // Use dynamic background color
      child: Padding(
        padding: const EdgeInsets.all(24.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
          children: [
            Text(
              project["company"]!, // Using company as project title
              style: TextStyle(
                fontSize: 20, // Adjusted font size
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8), // Spacing between title and description
            Expanded( // Use Expanded to ensure description takes available space
              child: Text(
                project["description"] ?? "No description available.",
                style: TextStyle(
                  fontSize: 16, // Adjusted font size
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                // Removed maxLines and overflow as Expanded handles it better
              ),
            ),
            const SizedBox(height: 16), // Spacing before the button
            Align(
              alignment: Alignment.bottomLeft, // Align button to bottom left
              child: TextButton.icon(
                onPressed: () => _launchUrl(PortfolioData.githubUrl), // Link to GitHub or specific project URL
                icon: Icon(Icons.open_in_new, size: 18), // Changed icon to open_in_new
                label: Text('View Project', style: TextStyle(fontSize: 16)), // Adjusted font size
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface, // Match text color
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.zero, // Remove default button padding
                  alignment: Alignment.centerLeft, // Align text and icon to left within the button area
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}