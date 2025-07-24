// Section displaying the technologies the user works with.
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/skill_chip.dart';
import 'package:portfolio/data/portfolio_data.dart';

class TechIWorkWithSection extends StatelessWidget {
  const TechIWorkWithSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isLargeScreen ? 120 : 80,
        horizontal: isLargeScreen ? 120 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tech Stacks",
            style: TextStyle(
              fontSize: isLargeScreen ? 42 : 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Container(
              width: 60,
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
          const SizedBox(height: 40),
          // Display skills by category
          ...PortfolioData.skills.entries.map((entry) {
            final category = entry.key;
            final skills = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 18 : 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: skills.map((skill) => SkillChip(skill: skill)).toList(),
                ),
                const SizedBox(height: 32),
              ],
            );
          }),
        ],
      ),
    );
  }
}