import 'package:flutter/material.dart';
import 'package:portfolio/constants/design_constants.dart';

class LetsWorkTogetherSection extends StatelessWidget {
  final VoidCallback onGetInTouchPressed;

  const LetsWorkTogetherSection({super.key, required this.onGetInTouchPressed});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > DesignConstants.tabletBreakpoint;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: DesignConstants.paddingLargeVertical, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Let's Work Together",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isLargeScreen ? 48 : 36,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              "I'm always excited to collaborate, innovate, and build meaningful solutions. Whether you have a project, a job opportunity, or just want to connect — let's talk!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 16,
                height: 1.6,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: onGetInTouchPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: isLargeScreen ? 20 : 16),
              textStyle: TextStyle(fontSize: isLargeScreen ? 14 : 12, fontWeight: FontWeight.bold),
            ),
            child: const Text('Get In Touch'),
          ),
        ],
      ),
    );
  }
}