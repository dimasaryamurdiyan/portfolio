import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/presentation/providers/theme_provider.dart';
import 'package:portfolio/widgets/certificate_card.dart';
import 'package:portfolio/widgets/custom_app_bar.dart';
import 'package:portfolio/widgets/education_card.dart';
import 'package:portfolio/widgets/experience_card.dart';
import 'package:portfolio/widgets/hero_section.dart';
import 'package:portfolio/widgets/lets_work_together_section.dart';
import 'package:portfolio/widgets/project_card.dart';
import 'package:portfolio/widgets/section_header.dart';
import 'package:portfolio/widgets/skill_chip.dart';
import 'package:portfolio/widgets/tech_i_work_with_section.dart';
import 'package:portfolio/widgets/what_i_do_section.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey(); // Renamed from _experienceKey
  final GlobalKey _contactKey = GlobalKey(); // Combined with "Let's Work Together"

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (kDebugMode) {
        print('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: CustomAppBar(
        onAboutPressed: () => _scrollToSection(_aboutKey),
        onProjectsPressed: () => _scrollToSection(_projectsKey),
        onContactPressed: () => _scrollToSection(_contactKey),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200), // Increased max width for more spacious layout
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
              children: [
                // Hero Section
                HeroSection(
                  onViewProjectsPressed: () => _scrollToSection(_projectsKey),
                  onDownloadResumePressed: () => _launchUrl('https://example.com/your_resume.pdf'), // Replace with actual resume URL
                ),
                const SizedBox(height: 80), // Spacing between sections

                // What I do Section
                const WhatIDoSection(),

                // Tech I Work With Section
                const TechIWorkWithSection(),
                const SizedBox(height: 80),

                // Projects Section (formerly Professional Experience)
                SectionHeader(key: _projectsKey, title: "Projects"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isLargeScreen ? 3 : (MediaQuery.of(context).size.width > 600 ? 2 : 1),
                      crossAxisSpacing: 24.0,
                      mainAxisSpacing: 24.0,
                      childAspectRatio: isLargeScreen ? 0.8 : 0.9, // Adjust aspect ratio for better card sizing
                    ),
                    itemCount: PortfolioData.professionalExperience.length,
                    itemBuilder: (context, index) {
                      return ProjectCard(project: PortfolioData.professionalExperience[index]);
                    },
                  ),
                ),
                const SizedBox(height: 80),

                // Let's Work Together Section (Contact)
                SectionHeader(key: _contactKey, title: "Contact"), // Renamed for consistency
                LetsWorkTogetherSection(
                  onGetInTouchPressed: () => _launchUrl('mailto:${PortfolioData.email}'),
                ),
                const SizedBox(height: 40),

                // Footer
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    "© ${DateTime.now().year} Dimas Arya Murdiyan. All rights reserved.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}