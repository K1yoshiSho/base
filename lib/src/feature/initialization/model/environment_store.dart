import 'package:base_starter/src/feature/initialization/model/environment.dart';

/// Environment store
class EnvironmentStore {
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
