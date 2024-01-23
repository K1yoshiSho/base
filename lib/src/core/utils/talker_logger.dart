import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// [Talker] - This class contains methods for handling errors and logging.

final Talker talker = TalkerFlutter.init();

/// `initHandling` - This function initializes handling of the app.

Future<void> initHandling() async {
  FlutterError.presentError = (details) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      talker.handle(details.exception, details.stack);
    });
  };

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
    ),
  );

  // PlatformDispatcher.instance.onError = (error, stack) {
  //   if (FlavorConfig.instance.name == FlavorKey.kProduction &&
  //       kDebugMode == false) {
  //     FirebaseCrashlytics.instance.recordError(error, stack);
  //   }
  //   dependenciesContainer.talker.handle(error, stack);
  //   return true;
  // };

  // FlutterError.onError = (details) => {
  //       if (FlavorConfig.instance.name == FlavorKey.kProduction &&
  //           kDebugMode == false) ...[
  //         FirebaseCrashlytics.instance
  //             .recordError(details.exception, details.stack),
  //       ],
  //      dependenciesContainer.talker.handle(details.exception, details.stack),
  //     };
}