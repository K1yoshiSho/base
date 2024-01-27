import 'dart:async';
import 'package:base_starter/src/core/utils/talker_logger.dart';
import 'package:base_starter/src/feature/app/logic/app_runner.dart';

void main() {
  runZonedGuarded(
    () => const AppRunner().initializeAndRun(),
    (error, stackTrace) {
      talker.handle(error, stackTrace);
    },
  );
}
