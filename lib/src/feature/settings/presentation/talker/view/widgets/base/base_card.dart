part of '../../../talker.dart';

class TalkerBaseCard extends StatelessWidget {
  const TalkerBaseCard({
    required this.child,
    required this.color,
    super.key,
    this.padding = const EdgeInsets.all(8),
    this.backgroundColor,
  });

  final Widget child;
  final Color color;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: padding,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).cardColor,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      );
}
