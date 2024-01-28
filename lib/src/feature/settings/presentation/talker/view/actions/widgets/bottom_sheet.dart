part of '../../../talker.dart';

class TalkerActionsBottomSheet extends StatelessWidget {
  const TalkerActionsBottomSheet({
    required this.actions,
    super.key,
  });

  final List<TalkerActionItem> actions;

  @override
  Widget build(BuildContext context) => BaseBottomSheet(
        title: 'Talker Actions',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...actions
                .map(
                  (e) => _ActionTile(
                    action: e,
                  ),
                )
                .toList(),
          ],
        ),
      );
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.action,
  });

  final TalkerActionItem action;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: () {
            Navigator.pop(context);
            action.onTap();
          },
          title: Text(
            action.title,
            style: context.theme.textTheme.bodyLarge,
          ),
          leading: Icon(action.icon, color: context.theme.textColor),
        ),
      );
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
