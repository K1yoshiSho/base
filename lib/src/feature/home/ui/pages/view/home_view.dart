part of '../home.dart';

class HomeView extends StatelessWidget {
  final void Function() onSettingsPressed;
  final void Function() onLoggerPressed;
  const HomeView({
    required this.onSettingsPressed,
    required this.onLoggerPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.app_title.capitalize(),
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onBackground,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton.filledTonal(
                        icon: const Icon(Icons.settings_rounded),
                        onPressed: () => onSettingsPressed(),
                        splashRadius: 8,
                      ),
                      if (context.config.isDev) ...[
                        IconButton.filledTonal(
                          icon: const Icon(Icons.monitor_heart),
                          onPressed: () => onLoggerPressed(),
                          splashRadius: 8,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      context.l10n.app_title,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.theme.colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
