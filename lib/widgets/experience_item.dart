import 'package:flutter/material.dart';

class ExperienceItem extends StatelessWidget {
  final Map<String, String> experience;

  const ExperienceItem({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLargeScreen = MediaQuery.of(context).size.width > 800;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isLargeScreen ? 16.0 : 12.0,
        horizontal: 0.0,
      ),
      child: Row(
        children: [
          // Company Logo
          Container(
            width: isLargeScreen ? 56 : 48,
            height: isLargeScreen ? 56 : 48,
            decoration: BoxDecoration(
              color: Colors.white, // Always white background
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Add padding inside the logo container
              child: experience["logo_path"]?.isNotEmpty == true
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        experience["logo_path"]!,
                        fit: BoxFit.contain, // Changed from cover to contain for better logo display
                        errorBuilder: (context, error, stackTrace) {
                          return _buildFallbackLogo(theme);
                        },
                      ),
                    )
                  : _buildFallbackLogo(theme),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Company Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company Name
                Text(
                  experience["company"] ?? "",
                  style: TextStyle(
                    fontSize: isLargeScreen ? 18 : 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                    height: 1.2,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Job Title
                Text(
                  experience["role"] ?? "",
                  style: TextStyle(
                    fontSize: isLargeScreen ? 15 : 14,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          
          // Dates
          Text(
            experience["dates"] ?? "",
            style: TextStyle(
              fontSize: isLargeScreen ? 14 : 13,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackLogo(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          experience["company"]?.substring(0, 2).toUpperCase() ?? "EX",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}