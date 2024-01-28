part of '../../../talker.dart';

class TalkerMonitorCard extends StatelessWidget {
  const TalkerMonitorCard({
    required this.logs,
    required this.title,
    required this.color,
    required this.icon,
    super.key,
    this.subtitle,
    this.subtitleWidget,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final List<TalkerDataInterface> logs;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: TalkerBaseCard(
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Icon(icon, color: color),
                    const Gap(10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: context.theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              style: context.theme.textTheme.bodyMedium,
                            ),
                          if (subtitleWidget != null) subtitleWidget!,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(Icons.arrow_forward_ios_rounded, color: color, size: 20),
            ],
          ),
        ),
      );
}
