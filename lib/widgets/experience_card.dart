import 'package:flutter/material.dart';

class ExperienceCard extends StatelessWidget {
  final Map<String, String> experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experience["role"]!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
             const SizedBox(height: 4),
            Text(
              "${experience["company"]} - ${experience["location"]}",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              experience["dates"]!,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (experience["description"] != null) ...[
              const SizedBox(height: 12),
              Text(
                experience["description"]!,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
            if (experience["responsibilities"] != null) ...[
              const SizedBox(height: 12),
              Text(
                "Responsibilities:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                experience["responsibilities"]!,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
            if (experience["tech_stacks"] != null) ...[
              const SizedBox(height: 12),
              Text(
                "Tech Stacks:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: experience["tech_stacks"]!
                    .split(', ')
                    .map((tech) => Chip(
                          label: Text(tech),
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      )
    );
  }
}