import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/presentation/providers/resume_provider.dart';

class ResumeDownloadButton extends ConsumerStatefulWidget {
  const ResumeDownloadButton({super.key});

  @override
  ConsumerState<ResumeDownloadButton> createState() =>
      _ResumeDownloadButtonState();
}

class _ResumeDownloadButtonState extends ConsumerState<ResumeDownloadButton> {
  bool _isDownloadInProgress = false;

  Future<void> _downloadResume({bool refresh = false}) async {
    if (_isDownloadInProgress) return;

    setState(() => _isDownloadInProgress = true);
    unawaited(ref.read(resumeDownloadTrackerProvider)());

    if (refresh) {
      ref.invalidate(resumeDownloadUrlProvider);
    }

    try {
      final uri = await ref.read(resumeDownloadUrlProvider.future);
      final launched = await ref.read(resumeUrlLauncherProvider)(uri);
      if (!launched) {
        _showFailureMessage();
      }
    } catch (_) {
      _showFailureMessage();
    } finally {
      if (mounted) {
        setState(() => _isDownloadInProgress = false);
      }
    }
  }

  void _showFailureMessage() {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text(
            'The resume is temporarily unavailable. Please try again.',
          ),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () {
              unawaited(_downloadResume(refresh: true));
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final resumeUrl = ref.watch(resumeDownloadUrlProvider);
    final isLoading = resumeUrl.isLoading || _isDownloadInProgress;

    return IconButton(
      icon:
          isLoading
              ? SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
              : Icon(
                Icons.download,
                size: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
      onPressed: isLoading ? null : _downloadResume,
      tooltip: isLoading ? 'Loading Resume' : 'Download Resume',
    );
  }
}
