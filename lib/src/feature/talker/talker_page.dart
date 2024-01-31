import 'package:base_starter/src/feature/talker/talker_view.dart' as view;
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// UI view for output of all Talker logs and errors
class TalkerPage extends StatelessWidget {
  const TalkerPage({
    required this.talker,
    super.key,
    this.appBarTitle = 'Talker',
    this.theme = const TalkerScreenTheme(),
    this.itemsBuilder,
    this.appBarLeading,
  });

  /// Talker implementation
  final Talker talker;

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme theme;

  /// Screen [AppBar] title
  final String appBarTitle;

  /// Screen [AppBar] leading
  final Widget? appBarLeading;

  /// Optional Builder to customize
  /// log items cards in list
  final TalkerDataBuilder? itemsBuilder;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: theme.backgroundColor,
        body: view.TalkerView(
          talker: talker,
          theme: theme,
          appBarTitle: appBarTitle,
          appBarLeading: appBarLeading,
        ),
      );
}
