import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/presentation/providers/theme_provider.dart';
import 'package:portfolio/widgets/project_card.dart';
import 'package:portfolio/widgets/tech_stack_section.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerStatefulWidget { // Change to ConsumerStatefulWidget
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState(); // Change state type
}

class _HomePageState extends ConsumerState<HomePage> { // Access ref directly here
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
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
    final currentTheme = ref.watch(themeModeProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF3E8FF), // Light purple
            Color(0xFFE0E7FF), // Light indigo
            Color(0xFFF0F9FF), // Light blue
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            PortfolioData.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            if (isLargeScreen) ...[
              TextButton.icon(
                onPressed: () => _scrollToSection(_aboutKey),
                icon: const Icon(Icons.person_outline, size: 16),
                label: const Text('About'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              TextButton.icon(
                onPressed: () => _scrollToSection(_projectsKey),
                icon: const Icon(Icons.work_outline, size: 16),
                label: const Text('Projects'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              TextButton.icon(
                onPressed: () => _scrollToSection(_contactKey),
                icon: const Icon(Icons.mail_outline, size: 16),
                label: const Text('Contact'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
            IconButton(
              onPressed: () => _launchUrl(PortfolioData.githubUrl),
              icon: const Icon(Icons.code),
              tooltip: 'GitHub',
            ),
            IconButton(
              onPressed: () => _launchUrl(PortfolioData.linkedinUrl),
              icon: const Icon(Icons.link),
              tooltip: 'LinkedIn',
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Hero Section
              _buildHeroSection(isLargeScreen),
              
              // About Section
              _buildAboutSection(isLargeScreen),
              
              // Tech Stack Section
              _buildTechStackSection(),
              
              // Projects Section
              _buildProjectsSection(isLargeScreen),
              
              // Contact Section
              _buildContactSection(isLargeScreen),
              
              // Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isLargeScreen) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 80 : 24,
        vertical: isLargeScreen ? 80 : 40,
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            'Hi, I\'m ${PortfolioData.name}',
            style: TextStyle(
              fontSize: isLargeScreen ? 64 : 40,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            PortfolioData.title,
            style: TextStyle(
              fontSize: isLargeScreen ? 24 : 20,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              PortfolioData.heroDescription,
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 16,
                height: 1.5,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _scrollToSection(_projectsKey),
                icon: const Icon(Icons.work_outline),
                label: const Text('View Projects'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _launchUrl('https://drive.google.com/file/d/resume'), // Replace with actual resume URL
                icon: const Icon(Icons.download),
                label: const Text('Download Resume'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildAboutSection(bool isLargeScreen) {
    return Container(
      key: _aboutKey,
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 80 : 24,
        vertical: 60,
      ),
      child: Column(
        children: [
          const Text(
            'What I do',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              PortfolioData.aboutMe,
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 16,
                height: 1.6,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechStackSection() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: TechStackSection(techStack: PortfolioData.techStack),
    );
  }

  Widget _buildProjectsSection(bool isLargeScreen) {
    final featuredProjects = PortfolioData.projects.where((p) => p['featured'] == 'true').toList();
    final otherProjects = PortfolioData.projects.where((p) => p['featured'] != 'true').toList();
    
    return Container(
      key: _projectsKey,
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 80 : 24,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Project
          if (featuredProjects.isNotEmpty) ...[
            ...featuredProjects.map((project) => ProjectCard(project: project)),
            const SizedBox(height: 16),
          ],
          
          // Featured project title and button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TiramAI - From Concept to Creation',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => _launchUrl('https://github.com/jayjhaveri'),
                child: const Text('View TiramAI'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Built TiramAI, an AI-driven mobile code generation and self-healing engine. It generates full Flutter apps from user text or voice prompts — and continuously evolves them. Users can report issues or suggest improvements directly from the app. TiramAI analyzes feedback, regenerates affected screens, and automatically updates the apps to Play Store and App Store — accelerating traditional development cycles by 10x. 20+ production-ready apps generated and shipped in beta using this system.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _launchUrl('https://play.google.com/store/apps/developer?id=TiramAI'),
            icon: const Icon(Icons.play_arrow),
            label: const Text('View Beta Apps on Play Store'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Other Projects
          if (isLargeScreen)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: otherProjects.length,
              itemBuilder: (context, index) => ProjectCard(project: otherProjects[index]),
            )
          else
            ...otherProjects.map((project) => ProjectCard(project: project)),
        ],
      ),
    );
  }

  Widget _buildContactSection(bool isLargeScreen) {
    return Container(
      key: _contactKey,
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            PortfolioData.contactTitle,
            style: TextStyle(
              fontSize: isLargeScreen ? 48 : 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              PortfolioData.contactDescription,
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 16,
                height: 1.5,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => _launchUrl('mailto:${PortfolioData.email}'),
            icon: const Icon(Icons.mail_outline),
            label: const Text('Get In Touch'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Text(
          "© ${DateTime.now().year} Jay Jhaveri. All rights reserved.",
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
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