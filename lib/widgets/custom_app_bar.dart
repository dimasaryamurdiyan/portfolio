import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/presentation/providers/theme_provider.dart';

// Custom AppBar for the portfolio, including navigation and theme toggle.
class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback onAboutPressed;
  final VoidCallback onExperiencePressed; // Changed from onProjectsPressed
  final VoidCallback onContactPressed;

  const CustomAppBar({
    super.key,
    required this.onAboutPressed,
    required this.onExperiencePressed, // Changed from onProjectsPressed
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
          PortfolioData.codeName,
          style: TextStyle(
            fontFamily: 'Black Han Sans',
            fontSize: 20,
            color: Theme.of(context).colorScheme.onSurface,
            fontVariations: [
              FontVariation('wght', 800),
            ]
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

}