// The main introductory section of the portfolio.
import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjectsPressed;
  final VoidCallback onDownloadResumePressed;

  const HeroSection({
    super.key,
    required this.onViewProjectsPressed,
    required this.onDownloadResumePressed,
  });

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 120 : 80, horizontal: 24),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Hi, I'm ${PortfolioData.name}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: isLargeScreen ? 64 : 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            PortfolioData.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isLargeScreen ? 28 : 22,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              PortfolioData.aboutMe,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20.0,
            runSpacing: 16.0,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: onViewProjectsPressed,
                icon: const Icon(Icons.visibility),
                label: const Text('View Projects'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: isLargeScreen ? 20 : 12),
                  textStyle: TextStyle(
                    fontSize: isLargeScreen ? 14 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: onDownloadResumePressed,
                icon: const Icon(Icons.download),
                label: const Text('Download Resume'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  side: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant, width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: isLargeScreen ? 20 : 12),
                  textStyle: TextStyle(
                    fontSize: isLargeScreen ? 14 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}