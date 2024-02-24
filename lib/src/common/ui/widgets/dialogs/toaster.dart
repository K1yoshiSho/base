import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_starter/src/common/utils/extensions/context_extension.dart';
import 'package:base_starter/src/common/utils/global_variables.dart';
import 'package:base_starter/src/core/assets/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

final class Toaster {
  const Toaster._();

  static Future<void> showToast(
    BuildContext context, {
    required String title,
    Color backgroundColor = const Color(0xff656565),
    Color textColor = Colors.white,
    bool hasImage = true,
    bool isDismissable = true,
    bool isIgnorePointer = true,
    Duration fadeDuration = const Duration(milliseconds: 200),
    Duration toastDuration = const Duration(seconds: 1),
    ToastGravity gravity = ToastGravity.BOTTOM,
    void Function()? then,
  }) async {
    fToast.removeCustomToast();
    fToast.showToast(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasImage) ...[
                Image.asset(
                  Assets.images.icon1024x1024.path,
                  width: 24,
                  height: 24,
                ),
                const Gap(8),
              ],
              Flexible(
                child: AutoSizeText(
                  title,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: textColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      gravity: gravity,
      fadeDuration: fadeDuration,
      toastDuration: toastDuration,
      ignorePointer: isIgnorePointer,
      isDismissable: isDismissable,
    );

    await Future.delayed(toastDuration, () {
      if (then != null) {
        then.call();
      }
    });
  }

  static Future<void> showSuccessToast(
    BuildContext context, {
    required String title,
    void Function()? then,
    Color textColor = Colors.white,
    bool hasImage = false,
    bool isDismissable = true,
    bool isIgnorePointer = true,
    Duration fadeDuration = const Duration(milliseconds: 200),
    Duration toastDuration = const Duration(milliseconds: 1500),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) async {
    fToast.removeCustomToast();
    fToast.showToast(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.success,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasImage) ...[
                Image.asset(
                  Assets.images.icon1024x1024.path,
                  width: 24,
                  height: 24,
                ),
                const Gap(8),
              ],
              Flexible(
                child: AutoSizeText(
                  title,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: textColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      gravity: gravity,
      fadeDuration: fadeDuration,
      toastDuration: toastDuration,
      ignorePointer: isIgnorePointer,
      isDismissable: isDismissable,
    );

    await Future.delayed(toastDuration, () {
      if (then != null) {
        then.call();
      }
    });
  }

  static Future<void> showErrorToast(
    BuildContext context, {
    required String title,
    void Function()? then,
    Color textColor = Colors.white,
    bool hasImage = false,
    bool isDismissable = true,
    bool isIgnorePointer = true,
    Duration fadeDuration = const Duration(milliseconds: 200),
    Duration toastDuration = const Duration(milliseconds: 1500),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) async {
    fToast.removeCustomToast();
    fToast.showToast(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasImage) ...[
                Image.asset(
                  Assets.images.icon1024x1024.path,
                  width: 24,
                  height: 24,
                ),
                const Gap(8),
              ],
              Flexible(
                child: AutoSizeText(
                  title,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: textColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      gravity: gravity,
      fadeDuration: fadeDuration,
      toastDuration: toastDuration,
      ignorePointer: isIgnorePointer,
      isDismissable: isDismissable,
    );

    await Future.delayed(toastDuration, () {
      if (then != null) {
        then.call();
      }
    });
  }
}
