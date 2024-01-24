import 'dart:async';
import 'package:base_starter/src/core/utils/talker_logger.dart';
import 'package:base_starter/src/feature/app/widget/app.dart';
import 'package:base_starter/src/feature/initialization/logic/initialization_processor.dart';
import 'package:base_starter/src/feature/initialization/widget/initialization_failed_app.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template app_runner}
/// A class which is responsible for initialization and running the app.
/// {@endtemplate}
final class AppRunner with InitializationFactoryImpl {
  /// {@macro app_runner}
  const AppRunner();

  /// Start the initialization and in case of success run application
  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    // Preserve splash screen
    binding.deferFirstFrame();

    // // Override logging
    // await initHandling();

    // Setup bloc observer and transformer
    Bloc.transformer = bloc_concurrency.sequential();
    final environmentStore = getEnvironmentStore();

    final initializationProcessor = InitializationProcessor(
      environmentStore: environmentStore,
    );

    Future<void> initializeAndRun() async {
      try {
        final result = await initializationProcessor.initialize();
        // Attach this widget to the root of the tree.
        runApp(App(result: result));
      } catch (e, stackTrace) {
        talker.error('Initialization failed');
        talker.handle(e, stackTrace);
        runApp(
          InitializationFailedApp(
            error: e,
            stackTrace: stackTrace,
            retryInitialization: initializeAndRun,
          ),
        );
      } finally {
        // Allow rendering
        binding.allowFirstFrame();
      }
    }

    // Run the app
    await initializeAndRun();
  }
}
