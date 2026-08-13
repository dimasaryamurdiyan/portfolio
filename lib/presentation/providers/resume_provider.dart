import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/services/analytics_service.dart';
import 'package:portfolio/services/resume_configuration_service.dart';
import 'package:portfolio/utils/url_launcher_service.dart';

typedef ResumeUrlLauncher = Future<bool> Function(Uri uri);
typedef ResumeDownloadTracker = Future<void> Function();

final remoteConfigClientProvider = Provider<RemoteConfigClient>((ref) {
  return FirebaseRemoteConfigClient(FirebaseRemoteConfig.instance);
});

final resumeConfigurationServiceProvider = Provider<ResumeConfigurationService>(
  (ref) {
    return ResumeConfigurationService(ref.watch(remoteConfigClientProvider));
  },
);

final resumeDownloadUrlProvider = FutureProvider<Uri>((ref) {
  return ref.watch(resumeConfigurationServiceProvider).fetchResumeDownloadUri();
});

final resumeUrlLauncherProvider = Provider<ResumeUrlLauncher>((ref) {
  return (uri) => UrlLauncherService.launch(uri.toString());
});

final resumeDownloadTrackerProvider = Provider<ResumeDownloadTracker>((ref) {
  return AnalyticsService.instance.trackResumeDownload;
});
