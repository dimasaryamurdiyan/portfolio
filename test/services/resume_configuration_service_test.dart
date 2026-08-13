import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/services/resume_configuration_service.dart';

class FakeRemoteConfigClient implements RemoteConfigClient {
  String value = '';
  Object? fetchError;
  int configureCalls = 0;
  int fetchCalls = 0;

  @override
  Future<void> configure() async {
    configureCalls += 1;
  }

  @override
  Future<bool> fetchAndActivate() async {
    fetchCalls += 1;
    final error = fetchError;
    if (error != null) throw error;
    return true;
  }

  @override
  String getString(String key) => value;
}

void main() {
  group('ResumeConfigurationService', () {
    late FakeRemoteConfigClient remoteConfigClient;
    late ResumeConfigurationService service;

    setUp(() {
      remoteConfigClient = FakeRemoteConfigClient();
      service = ResumeConfigurationService(remoteConfigClient);
    });

    test('returns a valid HTTPS resume URL', () async {
      remoteConfigClient.value = ' https://example.com/resume.pdf ';

      final uri = await service.fetchResumeDownloadUri();

      expect(uri, Uri.parse('https://example.com/resume.pdf'));
      expect(remoteConfigClient.configureCalls, 1);
      expect(remoteConfigClient.fetchCalls, 1);
    });

    test('rejects an empty Remote Config value', () {
      expect(
        service.fetchResumeDownloadUri,
        throwsA(isA<ResumeConfigurationException>()),
      );
    });

    test('rejects a malformed URL', () {
      remoteConfigClient.value = 'not a URL';

      expect(
        service.fetchResumeDownloadUri,
        throwsA(isA<ResumeConfigurationException>()),
      );
    });

    test('rejects a non-HTTPS URL', () {
      remoteConfigClient.value = 'http://example.com/resume.pdf';

      expect(
        service.fetchResumeDownloadUri,
        throwsA(isA<ResumeConfigurationException>()),
      );
    });

    test('uses the activated cached value when fetching fails', () async {
      remoteConfigClient
        ..value = 'https://example.com/cached-resume.pdf'
        ..fetchError = StateError('offline');

      final uri = await service.fetchResumeDownloadUri();

      expect(uri, Uri.parse('https://example.com/cached-resume.pdf'));
    });

    test('reports an error when fetching fails without a cached value', () {
      remoteConfigClient.fetchError = StateError('offline');

      expect(
        service.fetchResumeDownloadUri,
        throwsA(
          isA<ResumeConfigurationException>().having(
            (error) => error.message,
            'message',
            contains('fetch also failed'),
          ),
        ),
      );
    });
  });
}
