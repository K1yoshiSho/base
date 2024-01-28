part of '../talker.dart';

class TalkerView extends StatefulWidget {
  const TalkerView({
    required this.talker,
    super.key,
    this.controller,
    this.scrollController,
    this.appBarTitle,
    this.itemsBuilder,
    this.appBarLeading,
  });

  /// Talker implementation
  final Talker talker;

  /// Screen [AppBar] title
  final String? appBarTitle;

  /// Screen [AppBar] leading
  final Widget? appBarLeading;

  /// Optional Builder to customize
  /// log items cards in list
  final TalkerDataBuilder? itemsBuilder;

  final TalkerViewController? controller;

  final ScrollController? scrollController;

  @override
  State<TalkerView> createState() => _TalkerViewState();
}

class _TalkerViewState extends State<TalkerView> {
  final _titilesController = GroupButtonController();
  late final _controller = widget.controller ?? TalkerViewController();
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => TalkerBuilder(
          talker: widget.talker,
          builder: (context, data) {
            final filtredElements =
                data.where((e) => _controller.filter.filter(e)).toList();
            final titles = data.map((e) => e.title).toList();
            final unicTitles = titles.toSet().toList();
            return CustomScrollView(
              controller: widget.scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                TalkerViewAppBar(
                  searchController: _searchController,
                  searchFocusNode: _searchFocusNode,
                  title: widget.appBarTitle,
                  leading: widget.appBarLeading,
                  talker: widget.talker,
                  titilesController: _titilesController,
                  titles: titles,
                  unicTitles: unicTitles,
                  controller: _controller,
                  onMonitorTap: () => _openTalkerMonitor(context),
                  onActionsTap: () => _showActionsBottomSheet(context),
                  onSettingsTap: () => _openTalkerSettings(context),
                  onToggleTitle: (title, isSelected) =>
                      _onToggleTitle(title, isSelected),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final data = _getListItem(filtredElements, i);
                      if (widget.itemsBuilder != null) {
                        return widget.itemsBuilder!.call(context, data);
                      }
                      return TalkerDataCard(
                        key: ValueKey(data.hashCode),
                        data: data,
                        onTap: () => _copyTalkerDataItemText(data),
                        expanded: _controller.expandedLogs,
                      );
                    },
                    childCount: filtredElements.length,
                  ),
                ),
                const SliverToBoxAdapter(child: Gap(16)),
              ],
            );
          },
        ),
      );

  void _onToggleTitle(String title, bool selected) {
    if (selected) {
      _controller.addFilterTitle(title);
    } else {
      _controller.removeFilterTitle(title);
    }
  }

  TalkerDataInterface _getListItem(
    List<TalkerDataInterface> filtredElements,
    int i,
  ) {
    final data = filtredElements[
        _controller.isLogOrderReversed ? filtredElements.length - 1 - i : i];
    return data;
  }

  void _openTalkerSettings(BuildContext context) {
    final talker = ValueNotifier(widget.talker);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TalkerSettingsBottomSheet(
        talker: talker,
      ),
    );
  }

  void _openTalkerMonitor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (context) => TalkerMonitor(
          talker: widget.talker,
        ),
      ),
    );
  }

  void _copyTalkerDataItemText(TalkerDataInterface data) {
    final text = data.generateTextMessage();
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(context, 'Log item is copied in clipboard');
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future<void> _showActionsBottomSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TalkerActionsBottomSheet(
        actions: [
          TalkerActionItem(
            onTap: _controller.toggleLogOrder,
            title: 'Reverse logs',
            icon: Icons.swap_vert,
          ),
          TalkerActionItem(
            onTap: () => _copyAllLogs(context),
            title: 'Copy all logs',
            icon: Icons.copy,
          ),
          TalkerActionItem(
            onTap: _toggleLogsExpanded,
            title: _controller.expandedLogs ? 'Collapse logs' : 'Expand logs',
            icon: _controller.expandedLogs
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          TalkerActionItem(
            onTap: _cleanHistory,
            title: 'Clean history',
            icon: Icons.delete_outline,
          ),
          TalkerActionItem(
            onTap: _shareLogsInFile,
            title: 'Share logs file',
            icon: Icons.ios_share_outlined,
          ),
        ],
      ),
    );
  }

  Future<void> _shareLogsInFile() async {
    await _controller.downloadLogsFile(
      widget.talker.history.text,
    );
  }

  void _cleanHistory() {
    widget.talker.cleanHistory();
    _controller.update();
  }

  void _toggleLogsExpanded() {
    _controller.expandedLogs = !_controller.expandedLogs;
  }

  void _copyAllLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.talker.history.text));
    _showSnackBar(context, 'All logs copied in buffer');
  }
}
