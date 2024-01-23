import 'package:base_starter/src/feature/initialization/model/environment.dart';

/// {@template environment_store}
/// Environment store
/// {@endtemplate}
class EnvironmentStore {
  /// {@macro environment_store}
  const EnvironmentStore();

  /// The environment.
  Environment get environment {
    var environment = const String.fromEnvironment('ENVIRONMENT');

    if (environment.isNotEmpty) {
      return Environment.from(environment);
    }

    environment = const String.fromEnvironment('FLUTTER_APP_FLAVOR');

    return Environment.from(environment);
  }
}