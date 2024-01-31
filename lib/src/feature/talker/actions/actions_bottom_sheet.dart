import 'package:base_starter/src/core/utils/extensions/context_extension.dart';
import 'package:base_starter/src/feature/talker/widgets/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerActionsBottomSheet extends StatelessWidget {
  const TalkerActionsBottomSheet({
    required this.talkerScreenTheme,
    required this.actions,
    super.key,
  });

  final TalkerScreenTheme talkerScreenTheme;
  final List<TalkerActionItem> actions;

  @override
  Widget build(BuildContext context) => BaseBottomSheet(
        title: 'Talker Actions',
        talkerScreenTheme: talkerScreenTheme,
        child: Container(
          margin:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
          decoration: BoxDecoration(
            color: context.colors.card,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...actions
                  .asMap()
                  .entries
                  .map(
                    (e) => _ActionTile(
                      talkerScreenTheme: talkerScreenTheme,
                      action: e.value,
                      showDivider: e.key != actions.length - 1,
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      );
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.action,
    required this.talkerScreenTheme,
    this.showDivider = true,
  });

  final TalkerActionItem action;
  final TalkerScreenTheme talkerScreenTheme;
  final bool showDivider;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () => _onTap(context),
            title: Text(
              action.title,
              style: TextStyle(
                color: talkerScreenTheme.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: Icon(action.icon, color: talkerScreenTheme.textColor),
          ),
          if (showDivider)
            Divider(
              color: talkerScreenTheme.textColor.withOpacity(0.2),
              height: 1,
            ),
        ],
      );

  void _onTap(BuildContext context) {
    Navigator.pop(context);
    action.onTap();
  }
}

class TalkerActionItem {
  const TalkerActionItem({
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final VoidCallback onTap;
  final String title;
  final IconData icon;
}
