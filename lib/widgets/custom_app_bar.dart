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
        flexibleSpace: SizedBox(
          height: kToolbarHeight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left side - Title
                  Text(
                    PortfolioData.codeName,
                    style: TextStyle(
                      fontFamily: 'Black Han Sans',
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontVariations: [
                        FontVariation('wght', 800),
                      ]
                    ),
                  ),
                  // Right side - Theme toggle only
                  IconButton(
                    icon: Icon(Icons.light_mode, color: Theme.of(context).colorScheme.onSurface),
                    onPressed: () {
                      ref.read(themeModeProvider.notifier).toggleTheme();
                    },
                    tooltip: 'Toggle Theme',
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
        centerTitle: false,
        title: Text(
          PortfolioData.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.light_mode, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
            tooltip: 'Toggle Theme',
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
      icon: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      label: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}