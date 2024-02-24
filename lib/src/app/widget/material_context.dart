import 'package:base_starter/src/app/router/router.dart';
import 'package:base_starter/src/common/ui/widgets/other/feedback_body.dart';
import 'package:base_starter/src/core/localization/localization.dart';
import 'package:base_starter/src/feature/initialization/widget/environment_scope.dart';
import 'package:base_starter/src/feature/settings/ui/settings.dart';
import 'package:feedback_plus/feedback_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// [MaterialContext] is an entry point to the material context.
/// This widget sets locales, themes and routing.
class MaterialContext extends StatelessWidget {
  const MaterialContext({required this.routerConfig, super.key});

  final GoRouter routerConfig;

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
    final locale = SettingsScope.localeOf(context).locale;
    final config = EnvironmentScope.of(context);

    return BetterFeedback(
      themeMode: theme.mode,
      localizationsDelegates: Localization.localizationDelegates,
      localeOverride: locale,
      theme: FeedbackThemeData(
        background: Colors.grey[800]!,
        feedbackSheetColor: theme.lightTheme.colorScheme.surface,
        activeFeedbackModeColor: theme.lightTheme.colorScheme.primary,
        colorScheme: theme.lightTheme.colorScheme,
        cardColor: theme.lightTheme.scaffoldBackgroundColor,
        bottomSheetDescriptionStyle:
            theme.lightTheme.textTheme.bodyMedium!.copyWith(
          color: Colors.grey[800],
        ),
        dragHandleColor: Colors.grey[400],
        inactiveColor: Colors.grey[700]!,
        textColor: Colors.grey[800]!,
      ),
      darkTheme: FeedbackThemeData(
        background: Colors.grey[800]!,
        feedbackSheetColor: theme.darkTheme.colorScheme.surface,
        activeFeedbackModeColor: theme.darkTheme.colorScheme.primary,
        colorScheme: theme.darkTheme.colorScheme,
        cardColor: theme.darkTheme.scaffoldBackgroundColor,
        bottomSheetDescriptionStyle:
            theme.lightTheme.textTheme.bodyMedium!.copyWith(
          color: Colors.grey[300],
        ),
        dragHandleColor: Colors.grey[400],
        inactiveColor: Colors.grey[600]!,
        textColor: Colors.grey[300]!,
      ),
      mode: FeedbackMode.navigate,
      feedbackBuilder: (context, extras, scrollController) =>
          simpleFeedbackBuilder(
        context,
        extras,
        scrollController,
        theme.computeTheme(),
      ),
      child: MaterialApp.router(
        key: _globalKey,
        title: config.appName,
        onGenerateTitle: (context) => config.appName,
        theme: theme.lightTheme,
        darkTheme: theme.darkTheme,
        themeMode: theme.mode,
        localizationsDelegates: Localization.localizationDelegates,
        supportedLocales: Localization.supportedLocales,
        locale: locale,
        routerConfig: routerConfig,
        builder: (context, child) {
          child = EasyLoading.init()(context, child);
          child = MediaQuery.withClampedTextScaling(
            minScaleFactor: 1.0,
            maxScaleFactor: 2.0,
            child: child,
          );
          child = FToastBuilder()(context, child);
          return child;
        },
      ),
    );
  }
}
