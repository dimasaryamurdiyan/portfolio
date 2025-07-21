// Section displaying the technologies the user works with.
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/tech_stack_chip.dart';

class TechIWorkWithSection extends StatelessWidget {
  const TechIWorkWithSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24),
      child: Column(
        children: [
          Text(
            "Tech I Work With",
            style: TextStyle(
              fontSize: isLargeScreen ? 24 : 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20.0,
            runSpacing: 20.0,
            children: const [
              TechStackChip(name: "Kotlin", icon: Icons.code),
              TechStackChip(name: "Flutter", icon: Icons.mobile_friendly),
              TechStackChip(name: "Firebase", icon: Icons.cloud),
              TechStackChip(name: "Android Jetpack", icon: Icons.android),
              TechStackChip(name: "MVVM", icon: Icons.architecture),
              TechStackChip(name: "CI/CD", icon: Icons.build),
              // Add more tech stacks from PortfolioData.skills as needed
              // For a more dynamic approach, you could map PortfolioData.skills here.
              // Example:
              // TechStackChip(name: "RxJava", icon: Icons.data_usage),
              // TechStackChip(name: "Hilt", icon: Icons.extension),
            ],
          ),
        ],
      ),
    );
  }
}