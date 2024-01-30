import 'package:base_starter/src/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// {@template initialization_failed_screen}
/// InitializationFailedScreen widget
/// {@endtemplate}
class InitializationFailedApp extends StatefulWidget {
  /// The error that caused the initialization to fail.
  final Object error;

  /// The stack trace of the error that caused the initialization to fail.
  final StackTrace stackTrace;

  /// The callback that will be called when the retry button is pressed.
  ///
  /// If null, the retry button will not be shown.
  final Future<void> Function()? retryInitialization;

  /// {@macro initialization_failed_screen}
  const InitializationFailedApp({
    required this.error,
    required this.stackTrace,
    this.retryInitialization,
    super.key,
  });

  @override
  State<InitializationFailedApp> createState() =>
      _InitializationFailedAppState();
}

class _InitializationFailedAppState extends State<InitializationFailedApp> {
  /// Whether the initialization is in progress.
  final _inProgress = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _inProgress.dispose();
    super.dispose();
  }

  Future<void> _retryInitialization() async {
    _inProgress.value = true;
    await widget.retryInitialization!();
    _inProgress.value = false;
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Initialization failed',
                      style: context.theme.textTheme.headlineMedium,
                    ),
                    if (widget.retryInitialization != null)
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _retryInitialization,
                      ),
                  ],
                ),
                const Gap(16),
                Text(
                  '${widget.error}',
                  style: context.theme.textTheme.bodyLarge
                      ?.copyWith(color: context.theme.colorScheme.error),
                ),
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.stackTrace}',
                    style: context.theme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
