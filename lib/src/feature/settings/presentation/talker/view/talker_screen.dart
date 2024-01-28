part of '../talker.dart';

/// UI view for output of all Talker logs and errors
class CustomTalkerScreen extends StatelessWidget {
  const CustomTalkerScreen({
    required this.talker,
    super.key,
    this.appBarTitle = 'Talker',
    this.itemsBuilder,
    this.appBarLeading,
  });

  /// Talker implementation
  final Talker talker;

  /// Screen [AppBar] title
  final String appBarTitle;

  /// Screen [AppBar] leading
  final Widget? appBarLeading;

  /// Optional Builder to customize
  /// log items cards in list
  final TalkerDataBuilder? itemsBuilder;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: TalkerView(
          talker: talker,
          appBarTitle: appBarTitle,
          appBarLeading: appBarLeading,
        ),
      );
}
