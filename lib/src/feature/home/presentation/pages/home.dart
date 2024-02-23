import 'package:base_starter/src/core/router/router.dart';
import 'package:base_starter/src/core/utils/extensions/context_extension.dart';
import 'package:base_starter/src/core/utils/extensions/string_extension.dart';
import 'package:base_starter/src/core/utils/talker_logger.dart';
import 'package:base_starter/src/feature/settings/presentation/settings.dart';
import 'package:base_starter/src/feature/talker/talker_page.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
part 'view/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String name = "Home";
  static const String routePath = "/home";

  @override
  Widget build(BuildContext context) => HomeView(
        onSettingsPressed: () {
          context.pushNamed(SettingsPage.name);
        },
        onLoggerPressed: () {
          context.pushNamed(
            LoggerPage.name,
            extra: {
              LoggerPage.paramTalker: talker,
              LoggerPage.paramTheme: TalkerScreenTheme(
                backgroundColor: context.theme.colorScheme.background,
                textColor: context.colors.text,
                cardColor: context.colors.card,
              ),
            },
          );
        },
      );
}
