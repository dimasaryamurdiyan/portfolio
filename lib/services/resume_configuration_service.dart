import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract interface class RemoteConfigClient {
  Future<void> configure();

  Future<bool> fetchAndActivate();

  String getString(String key);
}

class FirebaseRemoteConfigClient implements RemoteConfigClient {
  FirebaseRemoteConfigClient(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  @override
  Future<void> configure() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await _remoteConfig.setDefaults(const {
      ResumeConfigurationService.resumeDownloadUrlKey: '',
    });
  }

  @override
  Future<bool> fetchAndActivate() => _remoteConfig.fetchAndActivate();

  @override
  String getString(String key) => _remoteConfig.getString(key);
}

class ResumeConfigurationException implements Exception {
  const ResumeConfigurationException(this.message);

  final String message;

  @override
  String toString() => 'ResumeConfigurationException: $message';
}

class ResumeConfigurationService {
  ResumeConfigurationService(this._remoteConfigClient);

  static const resumeDownloadUrlKey = 'resume_download_url';

  final RemoteConfigClient _remoteConfigClient;

  Future<Uri> fetchResumeDownloadUri() async {
    await _remoteConfigClient.configure();

    Object? fetchError;
    try {
      await _remoteConfigClient.fetchAndActivate();
    } catch (error) {
      // Remote Config retains the last activated value. Validate that cached
      // value before deciding whether the fetch failure is fatal.
      fetchError = error;
    }

    final rawUrl = _remoteConfigClient.getString(resumeDownloadUrlKey).trim();
    final uri = Uri.tryParse(rawUrl);

    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty) {
      final suffix =
          fetchError == null
              ? ''
              : ' The latest Remote Config fetch also failed.';
      throw ResumeConfigurationException(
        'Remote Config parameter "$resumeDownloadUrlKey" must contain a '
        'public HTTPS URL.$suffix',
      );
    }

    return uri;
  }
}
