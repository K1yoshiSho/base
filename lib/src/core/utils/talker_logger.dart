import 'package:base_starter/src/feature/initialization/model/environment_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// [Talker] - This class contains methods for handling errors and logging.

final Talker talker = TalkerFlutter.init(
  settings: TalkerSettings(),
  logger: TalkerLogger(
    settings: TalkerLoggerSettings(),
  ),
);

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

  PlatformDispatcher.instance.onError = (error, stack) {
    if (const EnvironmentStore().environment.value == "Production" &&
        kDebugMode == false) {
      // FirebaseCrashlytics.instance.recordError(error, stack);
    }
    talker.handle(error, stack);
    return true;
  };

  FlutterError.onError = (details) {
    if (const EnvironmentStore().environment.value == "Production" &&
        // ignore: inference_failure_on_collection_literal
        kDebugMode == false) {
      // FirebaseCrashlytics.instance
      //     .recordError(details.exception, details.stack),
    }
    talker.handle(details.exception, details.stack);
  };
}

class GoodLog extends TalkerLog {
  GoodLog(String super.message);

  /// Your custom log title
  @override
  String get title => 'good';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..xterm(121);
}

class RouteLog extends TalkerLog {
  RouteLog(String super.message);

  /// Your custom log title
  @override
  String get title => 'route';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..rgb(r: 0.5, g: 0.5);
}
