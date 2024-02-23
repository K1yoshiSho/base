import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_starter/src/core/utils/extensions/context_extension.dart';
import 'package:base_starter/src/core/utils/talker_logger.dart';
import 'package:base_starter/src/feature/home/presentation/pages/home.dart';

/// Pages
import 'package:base_starter/src/feature/settings/presentation/settings.dart';
import 'package:base_starter/src/feature/talker/talker_page.dart';
import 'package:flutter/cupertino.dart';

// Other
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

export 'package:go_router/go_router.dart';

/// This line declares a global key variable which is used to access the [NavigatorState] object associated with a widget.

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// This function returns a [CustomTransitionPage] widget with default fade animation.

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );

String? getCurrentPath() {
  if (navigatorKey.currentContext != null) {
    final GoRouterDelegate routerDelegate =
        GoRouter.of(navigatorKey.currentContext!).routerDelegate;
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  } else {
    return null;
  }
}

/// This function returns a [NoTransitionPage] widget with no animation.

CustomTransitionPage<T> buildPageWithNoTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    NoTransitionPage<T>(
      key: state.pageKey,
      child: child,
    );

/// This function returns a dynamic [Page] widget based on the input parameters.
/// It uses the '[buildPageWithDefaultTransition]' function to create a page with a default [fade animation].

Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(
  Widget child,
) =>
    (BuildContext context, GoRouterState state) =>
        buildPageWithDefaultTransition<T>(
          context: context,
          state: state,
          child: child,
        );

/// [createRouter] is a factory function that creates a [GoRouter] instance with all routes.

GoRouter createRouter() => GoRouter(
      initialLocation: HomePage.routePath,
      debugLogDiagnostics: true,
      navigatorKey: navigatorKey,

      // extraCodec: GeneralModelCodec(),
      observers: [
        TalkerRouteObserver(talker),
        HeroController(),
      ],
      errorPageBuilder: (context, state) {
        final error = state.matchedLocation;
        return CupertinoPage(
          child: Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.error),
              centerTitle: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: AutoSizeText.rich(
                          TextSpan(
                            text: "${context.l10n.page_not_found}: ",
                            children: [
                              TextSpan(
                                text: error,
                                style: context.theme.textTheme.titleMedium,
                                children: [
                                  TextSpan(
                                    text: " ${context.l10n.not_found}"
                                        .toLowerCase(),
                                    style: context.theme.textTheme.titleMedium
                                        ?.copyWith(
                                      color: context.colors.error,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          style: context.theme.textTheme.titleMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 16,
                          maxFontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    child: Text(context.l10n.go_to_home),
                    onPressed: () {
                      navigatorKey.currentContext?.goNamed(HomePage.name);
                    },
                  ),
                ),
                const Gap(50),
              ],
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          name: HomePage.name,
          path: HomePage.routePath,
          pageBuilder: (context, pathParameters) => const CupertinoPage(
            child: HomePage(),
          ),
          routes: [
            GoRoute(
              name: SettingsPage.name,
              path: SettingsPage.routePath,
              pageBuilder: (context, pathParameters) => const CupertinoPage(
                child: SettingsPage(),
              ),
            ),
            GoRoute(
              name: LoggerPage.name,
              path: LoggerPage.routePath,
              pageBuilder: (context, pathParameters) {
                final Map<String, dynamic>? args =
                    pathParameters.extra as Map<String, dynamic>?;
                return CupertinoPage(
                  child: LoggerPage(
                    talker: args?[LoggerPage.paramTalker] as Talker,
                    appBarTitle:
                        args?[LoggerPage.paramTitle] as String? ?? "Logger",
                    theme: args?[LoggerPage.paramTheme] as TalkerScreenTheme? ??
                        const TalkerScreenTheme(),
                    itemsBuilder: args?[LoggerPage.paramItemBuilder] as Widget
                        Function(BuildContext, TalkerData)?,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
