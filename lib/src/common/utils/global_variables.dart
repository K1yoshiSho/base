import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// This line declares a global variable which is used to show toast messages.
final FToast fToast = FToast();

/// This line declares a global key variable which is used to access the `NavigatorState` object associated with a widget.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

///  It is used to handle errors and log messages in the app.
final Talker talker = TalkerFlutter.init(
  settings: TalkerSettings(),
  logger: TalkerLogger(
    settings: TalkerLoggerSettings(),
  ),
);
