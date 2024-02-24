// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, implementation_imports

import 'package:base_starter/src/common/utils/extensions/context_extension.dart';
import 'package:base_starter/src/feature/talker/widget/base_bottom_sheet.dart';
import 'package:base_starter/src/feature/talker/widget/settings_card.dart';
import 'package:flutter/material.dart';

import 'package:talker_flutter/talker_flutter.dart';

class TalkerSettingsBottomSheets extends StatefulWidget {
  const TalkerSettingsBottomSheets({
    required this.talkerScreenTheme,
    required this.talker,
    super.key,
  });

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme talkerScreenTheme;

  /// Talker implementation
  final ValueNotifier<Talker> talker;

  @override
  State<TalkerSettingsBottomSheets> createState() =>
      _TalkerSettingsBottomSheetState();
}

class _TalkerSettingsBottomSheetState
    extends State<TalkerSettingsBottomSheets> {
  @override
  void initState() {
    widget.talker.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settings = <Widget>[
      TalkerSettingsCardItem(
        talkerScreenTheme: widget.talkerScreenTheme,
        title: context.l10n.enabled,
        enabled: widget.talker.value.settings.enabled,
        backgroundColor: widget.talkerScreenTheme.cardColor,
        onChanged: (enabled) {
          (enabled ? widget.talker.value.enable : widget.talker.value.disable)
              .call();
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCardItem(
        canEdit: widget.talker.value.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: context.l10n.use_console_logs,
        backgroundColor: widget.talkerScreenTheme.cardColor,
        enabled: widget.talker.value.settings.useConsoleLogs,
        onChanged: (enabled) {
          widget.talker.value.configure(
            settings: widget.talker.value.settings.copyWith(
              useConsoleLogs: enabled,
            ),
          );
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCardItem(
        canEdit: widget.talker.value.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: context.l10n.use_history,
        backgroundColor: widget.talkerScreenTheme.cardColor,
        enabled: widget.talker.value.settings.useHistory,
        onChanged: (enabled) {
          widget.talker.value.configure(
            settings: widget.talker.value.settings.copyWith(
              useHistory: enabled,
            ),
          );
          widget.talker.notifyListeners();
        },
      ),
    ];

    return BaseBottomSheet(
      title: context.l10n.settings,
      talkerScreenTheme: widget.talkerScreenTheme,
      child: Expanded(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ...settings.map((e) => SliverToBoxAdapter(child: e)),
          ],
        ),
      ),
    );
  }
}
