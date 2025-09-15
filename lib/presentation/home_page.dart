import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/services/analytics_service.dart';
import 'package:portfolio/widgets/custom_app_bar.dart';
import 'package:portfolio/widgets/experience_section.dart';
import 'package:portfolio/widgets/hero_section.dart';
import 'package:portfolio/widgets/lets_work_together_section.dart';
import 'package:portfolio/widgets/section_header.dart';
import 'package:portfolio/widgets/tech_i_work_with_section.dart';
import 'package:portfolio/widgets/what_i_do_section.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'dart:async' show unawaited;

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
  
  final AnalyticsService _analytics = AnalyticsService.instance;
  late DateTime _sessionStartTime;
  double _lastScrollPosition = 0;
  bool _hasTrackedInitialPageView = false;

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _sessionStartTime = DateTime.now();
    _setupScrollListener();
    _trackInitialPageView();
    
    // Handle async setup properly
    _setupAnalytics().catchError((error) {
      if (kDebugMode) {
        print('Analytics setup error: $error');
      }
    });
  }

  void _trackInitialPageView() {
    // Track page view once when widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasTrackedInitialPageView) {
        _analytics.trackPageOpen();
        _hasTrackedInitialPageView = true;
      }
    });
  }

  Future<void> _setupAnalytics() async {
    // Track session start and device info
    await _analytics.trackSessionStart();
    
    // Track device/platform info
    String deviceType = 'unknown';
    String platform = 'unknown';
    
    if (kIsWeb) {
      deviceType = 'web';
      platform = 'web';
    } else {
      platform = Platform.operatingSystem;
      deviceType = _getDeviceType();
    }
    
    await _analytics.trackDeviceInfo(deviceType, platform);
    await _analytics.setUserProperty('device_type', deviceType);
    await _analytics.setUserProperty('platform', platform);
  }

  String _getDeviceType() {
    if (kIsWeb) return 'web';
    if (Platform.isAndroid || Platform.isIOS) return 'mobile';
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) return 'desktop';
    return 'unknown';
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      final currentPosition = _scrollController.position.pixels;
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      
      // Page view is now tracked in initState, no need to track here
      
      // Track scroll depth every 25% increment
      final scrollPercentage = (currentPosition / maxScrollExtent) * 100;
      final lastScrollPercentage = (_lastScrollPosition / maxScrollExtent) * 100;
      
      // Track milestone scroll depths (25%, 50%, 75%, 100%)
      final milestones = [25.0, 50.0, 75.0, 100.0];
      for (final milestone in milestones) {
        if (lastScrollPercentage < milestone && scrollPercentage >= milestone) {
          String section = _getCurrentSection(scrollPercentage);
          _analytics.trackScrollDepth(milestone, section);
        }
      }
      
      _lastScrollPosition = currentPosition;
    });
  }

  String _getCurrentSection(double scrollPercentage) {
    if (scrollPercentage < 20) return 'hero';
    if (scrollPercentage < 40) return 'about';
    if (scrollPercentage < 60) return 'tech_stack';
    if (scrollPercentage < 80) return 'experience';
    return 'contact';
  }

  @override
  void dispose() {
    // Track session end - use unawaited to explicitly indicate we don't wait for completion
    final sessionDuration = DateTime.now().difference(_sessionStartTime).inSeconds;
    unawaited(_analytics.trackSessionEnd(sessionDuration));
    
    _scrollController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onAboutPressed: () {
          _analytics.trackSectionView('about');
          _scrollToSection(_aboutKey);
        },
        onExperiencePressed: () {
          _analytics.trackSectionView('experience');
          _scrollToSection(_experienceKey);
        },
        onContactPressed: () {
          _analytics.trackSectionView('contact');
          _scrollToSection(_contactKey);
        },
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
                        onDownloadResumePressed: () {
                          _analytics.trackResumeDownload();
                          _launchUrl('https://drive.google.com/uc?export=download&id=1E4G1QIgBaqOAqkDKEMjE1DNSw8WJpEwH');
                        },
                      ),
                      const SizedBox(height: 60), // Spacing between sections

                      // What I do Section
                      WhatIDoSection(key: _aboutKey),

                      // Tech I Work With Section
                      TechIWorkWithSection(),

                      // Experience Section
                      ExperienceSection(key: _experienceKey),


                      // Let's Work Together Section (Contact)
                      SectionHeader(key: _contactKey, title: ""), // Renamed for consistency
                      LetsWorkTogetherSection(
                        onGetInTouchPressed: () {
                          _analytics.trackEmailClick();
                          _launchUrl('mailto:${PortfolioData.email}');
                        },
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