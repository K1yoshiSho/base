import 'package:base_starter/src/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

final class AppPhysics {
  const AppPhysics();

  static ScrollPhysics appPhysics(BuildContext context) => context.isAndroid
      ? const ClampingScrollPhysics(parent: BouncingScrollPhysics())
      : const BouncingScrollPhysics();
}
