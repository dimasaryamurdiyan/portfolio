import 'package:flutter/material.dart';

class TechStackItem extends StatelessWidget {
  final Map<String, String> tech;

  const TechStackItem({super.key, required this.tech});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 100,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tech['icon'] ?? '📦',
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 8),
          Text(
            tech['name'] ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class TechStackSection extends StatelessWidget {
  final List<Map<String, String>> techStack;

  const TechStackSection({super.key, required this.techStack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Tech I Work With',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Wrap(
          alignment: WrapAlignment.center,
          children: techStack
              .map((tech) => TechStackItem(tech: tech))
              .toList(),
        ),
      ],
    );
  }
}