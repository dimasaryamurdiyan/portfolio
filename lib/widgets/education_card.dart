// Widget to display individual education entries.
import 'package:flutter/material.dart';

class EducationCard extends StatelessWidget {
  final Map<String, String> education;

  const EducationCard({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              education["institution"]!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              education["degree"]!,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "GPA: ${education["gpa"]!}",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              education["dates"]!,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (education["awards"] != null) ...[
              const SizedBox(height: 12),
              Text(
                "Awards: ${education["awards"]!}",
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}