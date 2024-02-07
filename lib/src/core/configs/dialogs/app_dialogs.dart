// ignore_for_file: inference_failure_on_function_return_type

import 'package:base_starter/src/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final class AppDialogs {
  const AppDialogs();

  static Future<void> dismiss() async {
    await EasyLoading.dismiss();
  }

  static void showError(BuildContext context, {String? title}) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45
      ..radius = 16
      ..textStyle = context.theme.textTheme.bodyLarge
      ..progressColor = context.theme.primaryColor
      ..backgroundColor = context.theme.colorScheme.background
      ..indicatorColor = context.theme.primaryColor
      ..textColor = context.colors.text
      ..maskColor = context.theme.colorScheme.background
      ..userInteractions = true
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..dismissOnTap = false;
    EasyLoading.dismiss();
    EasyLoading.showError(
      title ?? context.l10n.error,
      duration: const Duration(seconds: 2),
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: true,
    );
  }

  static void showToast(BuildContext context, {required String title}) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45
      ..radius = 16
      ..textStyle = context.theme.textTheme.bodyLarge?.copyWith(
        color: Colors.white,
      )
      ..progressColor = context.theme.primaryColor
      ..backgroundColor = const Color(0xff656565)
      ..indicatorColor = context.theme.primaryColor
      ..textColor = Colors.white
      ..maskColor = context.theme.colorScheme.background
      ..userInteractions = true
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..dismissOnTap = false;
    EasyLoading.dismiss();
    EasyLoading.showToast(
      title,
      duration: const Duration(seconds: 1),
      maskType: EasyLoadingMaskType.clear,
      toastPosition: EasyLoadingToastPosition.bottom,
      dismissOnTap: true,
    );
  }

  static Future<void> showSuccessToast(
    BuildContext context, {
    String? title,
    Function()? then,
  }) async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45
      ..radius = 16
      ..textStyle = context.theme.textTheme.bodyLarge?.copyWith(
        color: Colors.white,
      )
      ..progressColor = context.theme.primaryColor
      ..backgroundColor = Colors.green
      ..indicatorColor = context.theme.primaryColor
      ..textColor = Colors.white
      ..backgroundColor = Colors.green
      ..userInteractions = true
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..dismissOnTap = false;
    await EasyLoading.dismiss();
    if (context.mounted) {
      await EasyLoading.showToast(
        title ?? context.l10n.requestSuccess,
        duration: const Duration(seconds: 1),
        maskType: EasyLoadingMaskType.clear,
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      ).then((value) => then?.call());
    }
  }

  static Future<void> showErrorToast(
    BuildContext context, {
    String? title,
  }) async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45
      ..radius = 16
      ..textStyle = context.theme.textTheme.bodyLarge
      ..progressColor = context.theme.primaryColor
      ..backgroundColor = Colors.red
      ..indicatorColor = context.theme.primaryColor
      ..textColor = context.colors.text
      ..maskColor = context.theme.colorScheme.background
      ..userInteractions = true
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..dismissOnTap = false;
    await EasyLoading.dismiss();
    if (context.mounted) {
      await EasyLoading.showToast(
        title ?? context.l10n.error,
        duration: const Duration(seconds: 1),
        maskType: EasyLoadingMaskType.clear,
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    }
  }

  static void showLoader(BuildContext context, {String? title}) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45
      ..radius = 16
      ..textStyle = context.theme.textTheme.bodyLarge
      ..progressColor = context.theme.primaryColor
      ..backgroundColor = context.theme.cardColor
      ..indicatorColor = context.theme.primaryColor
      ..textColor = context.colors.text
      ..maskColor = context.theme.colorScheme.background
      ..userInteractions = false
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..dismissOnTap = false;
    EasyLoading.dismiss();
    EasyLoading.show(
      status: title ?? context.l10n.loading,
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
  }

  static void showSuccess(BuildContext context, {String? title}) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45
      ..radius = 16
      ..textStyle = context.theme.textTheme.bodyLarge
      ..progressColor = context.theme.primaryColor
      ..backgroundColor = context.theme.cardColor
      ..indicatorColor = context.theme.primaryColor
      ..textColor = context.colors.text
      ..maskColor = context.theme.colorScheme.background
      ..userInteractions = true
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..dismissOnTap = false;
    EasyLoading.dismiss();
    EasyLoading.showSuccess(
      title ?? context.l10n.requestSuccess,
      duration: const Duration(seconds: 1),
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: true,
    );
  }
}
