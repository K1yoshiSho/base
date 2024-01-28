// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

part of '../../talker.dart';

class TalkerSettingsBottomSheet extends StatefulWidget {
  const TalkerSettingsBottomSheet({
    required this.talker,
    super.key,
  });

  /// Talker implementation
  final ValueNotifier<Talker> talker;

  @override
  State<TalkerSettingsBottomSheet> createState() =>
      _TalkerSettingsBottomSheetState();
}

class _TalkerSettingsBottomSheetState extends State<TalkerSettingsBottomSheet> {
  @override
  void initState() {
    widget.talker.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settings = <Widget>[
      TalkerSettingsCard(
        title: 'Enabled',
        enabled: widget.talker.value.settings.enabled,
        onChanged: (enabled) {
          (enabled ? widget.talker.value.enable : widget.talker.value.disable)
              .call();
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCard(
        canEdit: widget.talker.value.settings.enabled,
        title: 'Use console logs',
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
      TalkerSettingsCard(
        canEdit: widget.talker.value.settings.enabled,
        title: 'Use history',
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
      title: 'Talker Settings',
      child: SizedBox(
        height: 350,
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
