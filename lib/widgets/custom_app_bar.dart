import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/presentation/providers/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Custom AppBar for the portfolio, including navigation and theme toggle.
class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback onAboutPressed;
  final VoidCallback onProjectsPressed;
  final VoidCallback onContactPressed;

  const CustomAppBar({
    super.key,
    required this.onAboutPressed,
    required this.onProjectsPressed,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    if (isLargeScreen) {
      return AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Left side - Title
                  Text(
                    PortfolioData.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  // const SizedBox(width: 32),
                  // Center - Navigation buttons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _AppBarButton(text: 'About', onPressed: onAboutPressed, icon: Icons.person_outline),
                      const SizedBox(width: 8),
                      _AppBarButton(text: 'Projects', onPressed: onProjectsPressed, icon: Icons.work_outline),
                      const SizedBox(width: 8),
                      _AppBarButton(text: 'Contact', onPressed: onContactPressed, icon: Icons.mail_outline),
                    ],
                  ),
                  // const SizedBox(width: 32),
                  // Right side - Social icons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.light_mode, color: Theme.of(context).colorScheme.onSurface),
                        onPressed: () {
                          ref.read(themeModeProvider.notifier).toggleTheme();
                        },
                        tooltip: 'Toggle Theme',
                      ),
                      IconButton(
                        icon: Icon(Icons.code, color: Theme.of(context).colorScheme.onSurface),
                        onPressed: () => _launchUrl(PortfolioData.githubUrl),
                        tooltip: 'GitHub',
                      ),
                      IconButton(
                        icon: Icon(Icons.link, color: Theme.of(context).colorScheme.onSurface),
                        onPressed: () => _launchUrl(PortfolioData.linkedinUrl),
                        tooltip: 'LinkedIn',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            PortfolioData.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onBackground),
            onSelected: (String value) {
              if (value == 'about') onAboutPressed();
              if (value == 'projects') onProjectsPressed();
              if (value == 'contact') onContactPressed();
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: 'about', child: Text('About')),
              const PopupMenuItem<String>(value: 'projects', child: Text('Projects')),
              const PopupMenuItem<String>(value: 'contact', child: Text('Contact')),
            ],
          ),
          IconButton(
            icon: Icon(Icons.light_mode, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
            tooltip: 'Toggle Theme',
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.code, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => _launchUrl(PortfolioData.githubUrl),
            tooltip: 'GitHub',
          ),
          IconButton(
            icon: Icon(Icons.link, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => _launchUrl(PortfolioData.linkedinUrl),
            tooltip: 'LinkedIn',
          ),
          const SizedBox(width: 16),
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (kDebugMode) {
        print('Could not launch $url');
      }
    }
  }
}

class _AppBarButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;

  const _AppBarButton({
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Theme.of(context).colorScheme.onBackground),
      label: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}