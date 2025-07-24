import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/widgets/custom_app_bar.dart';
import 'package:portfolio/widgets/experience_item.dart';
import 'package:portfolio/widgets/hero_section.dart';
import 'package:portfolio/widgets/lets_work_together_section.dart';
import 'package:portfolio/widgets/section_header.dart';
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
  final GlobalKey _experienceKey = GlobalKey(); // Changed from _projectsKey to _experienceKey
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
        onExperiencePressed: () => _scrollToSection(_experienceKey),
        onContactPressed: () => _scrollToSection(_contactKey),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                        onDownloadResumePressed: () => _launchUrl('https://drive.google.com/uc?export=download&id=1E4G1QIgBaqOAqkDKEMjE1DNSw8WJpEwH'), // Replace with actual resume URL
                      ),
                      const SizedBox(height: 60), // Spacing between sections

                      // What I do Section
                      WhatIDoSection(key: _aboutKey),

                      // Tech I Work With Section
                      TechIWorkWithSection(),

                      // Experience Section
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: isLargeScreen ? 120 : 80,
                          horizontal: isLargeScreen ? 120 : 40,
                        ),
                        child: Column(
                          key: _experienceKey,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section Title
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Experience",
                                  style: TextStyle(
                                    fontSize: isLargeScreen ? 48 : 36,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: 80,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).colorScheme.onSurface,
                                        Theme.of(context).colorScheme.onSurfaceVariant,
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                            
                            // Experience Cards
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: PortfolioData.professionalExperience.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 24),
                              itemBuilder: (context, index) {
                                return ExperienceItem(
                                  experience: PortfolioData.professionalExperience[index],
                                );
                              },
                            ),
                          ],
                        ),
                      ),


                      // Let's Work Together Section (Contact)
                      SectionHeader(key: _contactKey, title: ""), // Renamed for consistency
                      LetsWorkTogetherSection(
                        onGetInTouchPressed: () => _launchUrl('mailto:${PortfolioData.email}'),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Sticky Footer
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Text(
                "© ${DateTime.now().year} Dimas Arya Murdiyan. All rights reserved.",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}