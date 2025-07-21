import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/presentation/providers/theme_provider.dart';
import 'package:portfolio/widgets/certificate_card.dart';
import 'package:portfolio/widgets/education_card.dart';
import 'package:portfolio/widgets/experience_card.dart';
import 'package:portfolio/widgets/section_header.dart';
import 'package:portfolio/widgets/skill_chip.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerStatefulWidget { // Change to ConsumerStatefulWidget
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState(); // Change state type
}

class _HomePageState extends ConsumerState<HomePage> { // Access ref directly here
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _certificatesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

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
      // In a real app, you might show a SnackBar or dialog here
      // to inform the user that the link couldn't be opened.
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;
    final currentTheme = ref.watch(themeModeProvider); // Watch the current theme

    return Scaffold(
      appBar: AppBar(
        title: Text(
          PortfolioData.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(_getThemeIcon(currentTheme)),
            onPressed: () {
              // Toggle theme using the ThemeModeNotifier
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
            tooltip: _getThemeTooltip(currentTheme),
          ),
          if (isLargeScreen) ...[
            TextButton(
              onPressed: () => _scrollToSection(_aboutKey),
              child: const Text('About', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => _scrollToSection(_experienceKey),
              child: const Text('Experience', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => _scrollToSection(_skillsKey),
              child: const Text('Skills', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => _scrollToSection(_educationKey),
              child: const Text('Education', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => _scrollToSection(_certificatesKey),
              child: const Text('Certificates', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => _scrollToSection(_contactKey),
              child: const Text('Contact', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 16),
          ] else ...[
            PopupMenuButton<String>(
              onSelected: (String value) {
                if (value == 'about') _scrollToSection(_aboutKey);
                if (value == 'experience') _scrollToSection(_experienceKey);
                if (value == 'skills') _scrollToSection(_skillsKey);
                if (value == 'education') _scrollToSection(_educationKey);
                if (value == 'certificates') _scrollToSection(_certificatesKey);
                if (value == 'contact') _scrollToSection(_contactKey);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(value: 'about', child: Text('About')),
                const PopupMenuItem<String>(value: 'experience', child: Text('Experience')),
                const PopupMenuItem<String>(value: 'skills', child: Text('Skills')),
                const PopupMenuItem<String>(value: 'education', child: Text('Education')),
                const PopupMenuItem<String>(value: 'certificates', child: Text('Certificates')),
              ],
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000), // Max width for content
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 70,
                        // You can add a profile image here, e.g., backgroundImage: NetworkImage('your_image_url.jpg'),
                        child: Icon(Icons.person, size: 80), // Placeholder icon
                      ),
                      const SizedBox(height: 16),
                      Text(
                        PortfolioData.name,
                        style: TextStyle(
                          fontSize: isLargeScreen ? 48 : 36,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        PortfolioData.title,
                        style: TextStyle(
                          fontSize: isLargeScreen ? 24 : 18,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        PortfolioData.location,
                        style: TextStyle(
                          fontSize: isLargeScreen ? 18 : 14,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16.0,
                        runSpacing: 8.0,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _launchUrl('mailto:${PortfolioData.email}'),
                            icon: const Icon(Icons.email),
                            label: const Text('Email'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _launchUrl(PortfolioData.githubUrl),
                            icon: const Icon(Icons.code), // Using a generic code icon
                            label: const Text('GitHub'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _launchUrl(PortfolioData.linkedinUrl),
                            icon: const Icon(Icons.link), // Using a generic link icon
                            label: const Text('LinkedIn'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(height: 60, thickness: 1),

                // About Me Section
                SectionHeader(key: _aboutKey, title: "About Me"),
                Text(
                  PortfolioData.aboutMe,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const Divider(height: 60, thickness: 1),

                // Professional Experience Section
                SectionHeader(key: _experienceKey, title: "Professional Experience"),
                ...PortfolioData.professionalExperience
                    .map((exp) => ExperienceCard(experience: exp))
                    .toList(),
                const Divider(height: 60, thickness: 1),

                // Skills Section
                SectionHeader(key: _skillsKey, title: "Skills"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: PortfolioData.skills.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: entry.value.map((skill) => SkillChip(skill: skill)).toList(),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const Divider(height: 60, thickness: 1),

                // Education Section
                SectionHeader(key: _educationKey, title: "Education"),
                ...PortfolioData.education
                    .map((edu) => EducationCard(education: edu))
                    .toList(),
                const Divider(height: 60, thickness: 1),

                // Certificates Section
                SectionHeader(key: _certificatesKey, title: "Certificates"),
                ...PortfolioData.certificates
                    .map((cert) => CertificateCard(certificate: cert))
                    .toList(),
                const Divider(height: 60, thickness: 1),

                // Contact Section
                SectionHeader(key: _contactKey, title: "Contact Me"),
                Center(
                  child: Column(
                    children: [
                      SelectableText(
                        "Email: ${PortfolioData.email}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        "Phone: ${PortfolioData.phone}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16.0,
                        runSpacing: 8.0,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _launchUrl(PortfolioData.githubUrl),
                            icon: const Icon(Icons.code),
                            label: const Text('GitHub Profile'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _launchUrl(PortfolioData.linkedinUrl),
                            icon: const Icon(Icons.link),
                            label: const Text('LinkedIn Profile'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Center(
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

  IconData _getThemeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  String _getThemeTooltip(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Switch to Dark Mode';
      case ThemeMode.dark:
        return 'Switch to System Mode';
      case ThemeMode.system:
        return 'Switch to Light Mode';
    }
  }
}