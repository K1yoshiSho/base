part of '../../../talker.dart';

class TalkerMonitorTypedLogsScreen extends StatelessWidget {
  const TalkerMonitorTypedLogsScreen({
    required this.exceptions,
    required this.typeName,
    super.key,
  });

  final String typeName;

  final List<TalkerDataInterface> exceptions;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(
            'Talker Monitor: $typeName',
            style: context.theme.textTheme.titleMedium,
          ),
        ),
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Gap(10),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final data = exceptions[index];
                  return TalkerDataCard(
                    data: data,
                    onTap: () => _copyTalkerDataItemText(context, data),
                  );
                },
                childCount: exceptions.length,
              ),
            ),
          ],
        ),
      );

  void _copyTalkerDataItemText(BuildContext context, TalkerDataInterface data) {
    final text = data.generateTextMessage();
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(context, 'Log item is copied in clipboard');
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
