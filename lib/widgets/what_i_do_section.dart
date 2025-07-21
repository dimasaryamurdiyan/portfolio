// Section describing the user's expertise.
import 'package:flutter/material.dart';

class WhatIDoSection extends StatelessWidget {
  const WhatIDoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24),
      child: Column(
        children: [
          Text(
            "What I do",
            style: TextStyle(
              fontSize: isLargeScreen ? 36 : 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              "A Senior Software Engineer with 4+ years of experience blending mobile development expertise with cutting-edge technologies. I specialize in building intelligent, production-ready applications using Flutter, Firebase Cloud Functions, and Generative AI models. Focused on turning ideas into scalable products, automating workflows, and delivering seamless user experiences.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 16,
                height: 1.6,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}