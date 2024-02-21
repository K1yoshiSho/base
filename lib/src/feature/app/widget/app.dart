import 'package:base_starter/src/core/router/router.dart';
import 'package:base_starter/src/core/utils/talker_logger.dart';
import 'package:base_starter/src/feature/app/widget/material_context.dart';

import 'package:base_starter/src/feature/initialization/model/dependencies.dart';
import 'package:base_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:base_starter/src/feature/settings/presentation/settings.dart';

import 'package:flutter/material.dart';

/// {@template app}
/// [App] is an entry point to the application.
///
/// Scopes that don't depend on widgets returned by [MaterialApp]
/// ([Directionality], [MediaQuery], [Localizations]) should be placed here.
/// {@endtemplate}

class App extends StatefulWidget {
  const App({required this.result, super.key});

  @override
  State<App> createState() => _AppState();

  /// The initialization result from the `InitializationProcessor`
  /// which contains initialized dependencies.
  final InitializationResult result;

  /// Running this function will result in attaching
  /// corresponding [RenderObject] to the root of the tree.
  void attach([VoidCallback? callback]) {
    callback?.call();
    runApp(this);
  }
}

class _AppState extends State<App> {
  final _router = createRouter();

  @override
  void initState() {
    _router.routerDelegate.addListener(() {
      talker.logTyped(
        RouteLog(
          _router.routerDelegate.currentConfiguration.last.matchedLocation,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DependenciesScope(
        dependencies: widget.result.dependencies,
        repositories: widget.result.repositories,
        child: SettingsScope(
          settingsBloc: widget.result.dependencies.settingsBloc,
          child: MaterialContext(
            routerConfig: _router,
          ),
        ),
      );
}
