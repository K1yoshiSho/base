part of 'initialization_processor.dart';

/// {@template initialization_factory}
/// Factory for creating pre-initialized objects.
/// {@endtemplate}
abstract class InitializationFactory {
  /// Get the environment store.
  EnvironmentStore getEnvironmentStore();
}

/// {@macro initialization_factory}
mixin InitializationFactoryImpl implements InitializationFactory {
  @override
  EnvironmentStore getEnvironmentStore() => const EnvironmentStore();
}
