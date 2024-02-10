import 'package:base_starter/src/core/localization/localization.dart';
import 'package:base_starter/src/core/utils/extensions/colors_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// List of extensions for [BuildContext]
extension ContextExtension on BuildContext {
  /// Obtain the nearest widget of the given type T,
  /// which must be the type of a concrete [InheritedWidget] subclass,
  /// and register this build context with that widget such that
  /// when that widget changes (or a new widget of that type is introduced,
  /// or the widget goes away), this build context is rebuilt so that it can
  /// obtain new values from that widget.
  T? inhMaybeOf<T extends InheritedWidget>({bool listen = true}) => listen
      ? dependOnInheritedWidgetOfExactType<T>()
      : getInheritedWidgetOfExactType<T>();

  /// Obtain the nearest widget of the given type T,
  /// which must be the type of a concrete [InheritedWidget] subclass,
  /// and register this build context with that widget such that
  /// when that widget changes (or a new widget of that type is introduced,
  /// or the widget goes away), this build context is rebuilt so that it can
  /// obtain new values from that widget.
  T inhOf<T extends InheritedWidget>({bool listen = true}) =>
      inhMaybeOf<T>(listen: listen) ??
      (throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a $T of the exact type',
        'out_of_scope',
      ));

  /// Maybe inherit specific aspect from [InheritedModel].
  T? maybeInheritFrom<A extends Object, T extends InheritedModel<A>>(
    A? aspect,
  ) =>
      InheritedModel.inheritFrom<T>(this, aspect: aspect);

  /// Inherit specific aspect from [InheritedModel].
  T inheritFrom<A extends Object, T extends InheritedModel<A>>({A? aspect}) =>
      InheritedModel.inheritFrom<T>(this, aspect: aspect) ??
      (throw ArgumentError(
        'Out of scope, not found inherited model '
            'a $T of the exact type',
        'out_of_scope',
      ));

  Size get size => MediaQuery.sizeOf(this);

  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  ThemeData get theme => Theme.of(this);

  AppColorsExtension get colors => theme.extension<AppColorsExtension>()!;

  AppLocalizations get l10n => Localization.of(this);

  bool get isDark => theme.brightness == Brightness.dark;

  bool get isLight => theme.brightness == Brightness.light;

  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;

  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;

  bool get isFuchsia => Theme.of(this).platform == TargetPlatform.fuchsia;

  bool get isMacOS => Theme.of(this).platform == TargetPlatform.macOS;

  bool get isLinux => Theme.of(this).platform == TargetPlatform.linux;

  bool get isWindows => Theme.of(this).platform == TargetPlatform.windows;

  bool get isWeb => kIsWeb;
}

extension ColorsThemeData on ThemeData {
  AppColorsExtension get colors => extension<AppColorsExtension>()!;
}
