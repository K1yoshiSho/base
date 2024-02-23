import 'package:base_starter/src/core/configs/dialogs/change_environment.dart';
import 'package:base_starter/src/core/localization/localization.dart';
import 'package:base_starter/src/core/router/router.dart';
import 'package:base_starter/src/core/services/page_model.dart';
import 'package:base_starter/src/core/utils/extensions/context_extension.dart';
import 'package:base_starter/src/core/utils/extensions/string_extension.dart';
import 'package:base_starter/src/core/utils/talker_logger.dart';
import 'package:base_starter/src/feature/app/model/app_theme.dart';
import 'package:base_starter/src/feature/settings/bloc/settings_bloc.dart';
import 'package:base_starter/src/feature/settings/presentation/view/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

part 'view/settings_view.dart';
part 'widgets/language_card.dart';
part 'widgets/language_selector.dart';
part 'widgets/theme_card.dart';
part 'widgets/theme_selector.dart';
part 'settings_scope.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String name = "Settings";
  static const String routePath = "settings";

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsPageModel _model;

  @override
  void initState() {
    _model = createModel(context, () => SettingsPageModel());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _model.dispose();
  }

  @override
  Widget build(BuildContext context) => SettingsView(
        onTapAppVersion: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          _model.tapNumber++;
          talker.info("Tap number on app version: ${_model.tapNumber}");
          if (_model.tapNumber > 5 && _model.tapNumber < 10) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: const Color(0xff656565),
                content: Text(
                  context.l10n.environment_tap_number(10 - _model.tapNumber),
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else if (_model.tapNumber == 10) {
            ChangeEnvironmentDialog.show(context);
            _model.tapNumber = 0;
          }
        },
      );
}
