import 'dart:io';

import 'package:base_starter/src/core/utils/extensions/context_extension.dart';
import 'package:base_starter/src/feature/talker/talker_view.dart' as view;
import 'package:feedback_plus/feedback_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// UI view for output of all Talker logs and errors
class TalkerPage extends StatelessWidget {
  const TalkerPage({
    required this.talker,
    super.key,
    this.appBarTitle = 'Logger',
    this.theme = const TalkerScreenTheme(),
    this.itemsBuilder,
    this.appBarLeading,
  });

  static const String name = "Logger";
  static const String routePath = "logger";

  static const String paramTalker = "paramTalker";
  static const String paramTheme = "paramTheme";
  static const String paramTitle = "paramTitle";
  static const String paramItemBuilder = "paramItemBuilder";

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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            BetterFeedback.of(context).show((UserFeedback feedback) async {
              final screenshotFilePath =
                  await writeImageToStorage(feedback.screenshot);

              await Share.shareXFiles(
                [screenshotFilePath],
                text: feedback.text,
              );
            });
          },
          label: Text(context.l10n.fix),
          icon: const Icon(Icons.camera_enhance_rounded),
        ),
        body: view.TalkerView(
          talker: talker,
          theme: theme,
          appBarTitle: appBarTitle,
          appBarLeading: appBarLeading,
        ),
      );
}

Future<XFile> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final Directory output = await getTemporaryDirectory();
  final String screenshotFilePath = '${output.path}/feedback.png';
  final File screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return XFile(screenshotFilePath, bytes: feedbackScreenshot);
}
