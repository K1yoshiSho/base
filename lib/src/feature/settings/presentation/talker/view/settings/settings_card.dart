// ignore_for_file: avoid_positional_boolean_parameters, inference_failure_on_function_return_type

part of '../../talker.dart';

class TalkerSettingsCard extends StatelessWidget {
  const TalkerSettingsCard({
    required this.title,
    required this.enabled,
    required this.onChanged,
    super.key,
    this.canEdit = true,
  });

  final String title;
  final bool enabled;
  final Function(bool enabled) onChanged;
  final bool canEdit;

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: canEdit ? 1 : 0.7,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TalkerBaseCard(
            padding: EdgeInsets.zero,
            color: Theme.of(context).cardColor,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(
                title,
                style: context.theme.textTheme.bodyLarge,
              ),
              trailing: Switch.adaptive(
                value: enabled,
                activeColor: context.theme.colorScheme.primaryContainer,
                trackColor: canEdit
                    ? MaterialStateProperty.resolveWith((states) => Colors.red)
                    : MaterialStateProperty.resolveWith(
                        (states) => Colors.grey,
                      ),
                onChanged: canEdit ? onChanged : null,
              ),
            ),
          ),
        ),
      );
}
