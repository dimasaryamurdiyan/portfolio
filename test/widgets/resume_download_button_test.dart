import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/presentation/providers/resume_provider.dart';
import 'package:portfolio/widgets/resume_download_button.dart';

Widget buildSubject({
  required Future<Uri> Function(Ref ref) loadResumeUrl,
  required ResumeUrlLauncher launcher,
  required ResumeDownloadTracker tracker,
}) {
  return ProviderScope(
    overrides: [
      resumeDownloadUrlProvider.overrideWith(loadResumeUrl),
      resumeUrlLauncherProvider.overrideWithValue(launcher),
      resumeDownloadTrackerProvider.overrideWithValue(tracker),
    ],
    child: const MaterialApp(home: Scaffold(body: ResumeDownloadButton())),
  );
}

void main() {
  testWidgets('disables the action while the URL is loading', (tester) async {
    final completer = Completer<Uri>();
    var launchCalls = 0;

    await tester.pumpWidget(
      buildSubject(
        loadResumeUrl: (_) => completer.future,
        launcher: (_) async {
          launchCalls += 1;
          return true;
        },
        tracker: () async {},
      ),
    );

    final button = tester.widget<ElevatedButton>(
      find.byWidgetPredicate((widget) => widget is ElevatedButton),
    );
    expect(button.onPressed, isNull);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(launchCalls, 0);

    completer.complete(Uri.parse('https://example.com/resume.pdf'));
    await tester.pumpAndSettle();
  });

  testWidgets('launches the configured URL and records analytics', (
    tester,
  ) async {
    final expectedUri = Uri.parse('https://example.com/resume.pdf');
    Uri? launchedUri;
    var trackingCalls = 0;

    await tester.pumpWidget(
      buildSubject(
        loadResumeUrl: (_) async => expectedUri,
        launcher: (uri) async {
          launchedUri = uri;
          return true;
        },
        tracker: () async {
          trackingCalls += 1;
        },
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Resume'));
    await tester.pump();

    expect(launchedUri, expectedUri);
    expect(trackingCalls, 1);
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('shows a retry message when the URL cannot be launched', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildSubject(
        loadResumeUrl: (_) async => Uri.parse('https://example.com/resume.pdf'),
        launcher: (_) async => false,
        tracker: () async {},
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Resume'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      find.text('The resume is temporarily unavailable. Please try again.'),
      findsOneWidget,
    );
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('Retry invalidates and reloads failed configuration', (
    tester,
  ) async {
    var loadAttempts = 0;

    await tester.pumpWidget(
      buildSubject(
        loadResumeUrl: (_) async {
          loadAttempts += 1;
          throw StateError('Remote Config unavailable');
        },
        launcher: (_) async => true,
        tracker: () async {},
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Resume'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(loadAttempts, 1);

    await tester.tap(find.text('Retry'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(loadAttempts, 2);
  });
}
