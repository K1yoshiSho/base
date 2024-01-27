import 'package:base_starter/src/core/utils/talker_logger.dart';
import 'package:base_starter/src/feature/initialization/model/dependencies.dart';
import 'package:base_starter/src/feature/initialization/model/environment_store.dart';
import 'package:base_starter/src/feature/settings/bloc/settings_bloc.dart';
import 'package:base_starter/src/feature/settings/data/locale_datasource.dart';
import 'package:base_starter/src/feature/settings/data/locale_repository.dart';
import 'package:base_starter/src/feature/settings/data/theme_datasource.dart';
import 'package:base_starter/src/feature/settings/data/theme_mode_codec.dart';
import 'package:base_starter/src/feature/settings/data/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'initialization_factory.dart';

/// {@template initialization_processor}
/// A class which is responsible for processing initialization steps.
/// {@endtemplate}
final class InitializationProcessor {
  // ignore: unused_field
  final EnvironmentStore _environmentStore;

  /// {@macro initialization_processor}
  const InitializationProcessor({
    required EnvironmentStore environmentStore,
  }) : _environmentStore = environmentStore;

  Future<Dependencies> _initDependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final settingsBloc = await _initSettingsBloc(sharedPreferences);

    return Dependencies(
      sharedPreferences: sharedPreferences,
      settingsBloc: settingsBloc,
    );
  }

  Future<SettingsBloc> _initSettingsBloc(SharedPreferences prefs) async {
    final localeRepository = LocaleRepositoryImpl(
      localeDataSource: LocaleDataSourceLocal(sharedPreferences: prefs),
    );

    final themeRepository = ThemeRepositoryImpl(
      themeDataSource: ThemeDataSourceLocal(
        sharedPreferences: prefs,
        codec: const ThemeModeCodec(),
      ),
    );

    final localeFuture = localeRepository.getLocale();
    final theme = await themeRepository.getTheme();
    final locale = await localeFuture;

    final initialState = SettingsState.idle(appTheme: theme, locale: locale);

    final settingsBloc = SettingsBloc(
      localeRepository: localeRepository,
      themeRepository: themeRepository,
      initialState: initialState,
    );
    return settingsBloc;
  }

  /// Method that starts the initialization process
  /// and returns the result of the initialization.
  ///
  /// This method may contain additional steps that need initialization
  /// before the application starts
  /// (for example, caching or enabling tracking manager)
  Future<InitializationResult> initialize() async {
    final stopwatch = Stopwatch()..start();

    talker.info('Initializing dependencies...');
    // initialize dependencies
    final dependencies = await _initDependencies();
    talker.info('Dependencies initialized');
    talker.good(
        "\nEnvironment value: ${const EnvironmentStore().environment.value}\nEnvironment name: ${const EnvironmentStore().environment.name}\nEnvironment index: ${const EnvironmentStore().environment.index}");

    stopwatch.stop();
    final result = InitializationResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );
    return result;
  }
}
