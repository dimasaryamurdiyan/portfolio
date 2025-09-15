// The main introductory section of the portfolio.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/services/analytics_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onDownloadResumePressed;

  const HeroSection({
    super.key,
    required this.onDownloadResumePressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _dotController;
  late Animation<double> _dotAnimation;
  final AnalyticsService _analytics = AnalyticsService();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    // Dot animation controller
    _dotController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _dotAnimation = Tween<double>(
      begin: -15.0,
      end: 15.0,
    ).animate(CurvedAnimation(
      parent: _dotController,
      curve: Curves.easeInOut,
    ));
    
    _pulseController.repeat(reverse: true);
    _dotController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _dotController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (kDebugMode) {
        print('Could not launch $url');
      }
    }
  }

  void _scrollDown() {
    // Scroll down to the next section
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isLargeScreen ? 120 : 80,
        horizontal: isLargeScreen ? 120 : 40,
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side - Text content
          Expanded(
            flex: isLargeScreen ? 3 : 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi! I'm \n${PortfolioData.name}.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 64 : 48,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontVariations: [
                        FontVariation('wght', 600),
                    ]
                  ),
                ),
                Text(
                  PortfolioData.title,
                  textAlign: TextAlign.left,
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
                    "Nice to meet you!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: isLargeScreen ? 18 : 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                // Social Media Icons with circular grey stroke
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/github-outline.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () {
                          _analytics.trackSocialMediaClick('github');
                          _launchUrl(PortfolioData.githubUrl);
                        },
                        tooltip: 'GitHub',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/linkedin.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () {
                          _analytics.trackSocialMediaClick('linkedin');
                          _launchUrl(PortfolioData.linkedinUrl);
                        },
                        tooltip: 'LinkedIn',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.download,
                          size: 24,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: widget.onDownloadResumePressed,
                        tooltip: 'Download Resume',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Right side - Scroll down animation (only on large screens)
          if (isLargeScreen) ...[
            const SizedBox(width: 40),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: GestureDetector(
                          onTap: _scrollDown,
                          child: Container(
                            width: 40,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                width: 2,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedBuilder(
                                  animation: _dotAnimation,
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset: Offset(0, _dotAnimation.value),
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
const SizedBox(height: 16),
                  Text(
                    "scroll down",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}