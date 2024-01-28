part of '../../../talker.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    required this.child,
    required this.title,
    super.key,
  });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            bottom: mq.padding.bottom,
          ),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12)
                    .copyWith(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: context.theme.textTheme.titleLarge
                          ?.copyWith(color: context.theme.textColor),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.close,
                        color: context.theme.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: context.theme.dividerColor,
                height: 1,
                thickness: 1,
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
