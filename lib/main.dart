import 'dart:async';
import 'package:base_starter/src/core/utils/talker_logger.dart';
import 'package:base_starter/src/feature/app/logic/app_runner.dart';
import 'package:base_starter/src/feature/initialization/logic/initialization_processor.dart';
import 'package:base_starter/src/feature/initialization/model/dependencies.dart';
import 'package:base_starter/src/feature/initialization/model/initialization_hook.dart';

void main() {
  final hook = InitializationHook.setup(
    onInitializing: _onInitializing,
    onInitialized: _onInitialized,
    onError: _onError,
    onInit: _onInit,
  );

  runZonedGuarded(
    () => AppRunner().initializeAndRun(hook),
    (error, stackTrace) {
      talker.handle(error, stackTrace);
    },
  );
}

void _onInitializing(InitializationStepInfo info) {
  final percentage = ((info.step / info.stepsCount) * 100).toInt();
  talker.info(
    'Inited ${info.stepName} in ${info.msSpent} ms | '
    'Progress: $percentage%',
  );
}

void _onInitialized(InitializationResult result) {
  talker.info('Initialization completed successfully in ${result.msSpent} ms');
}

void _onError(int step, Object error) {
  talker.error('Initialization failed on step $step with error: $error');
}

void _onInit() {
  talker.info('Initialization started');
}
