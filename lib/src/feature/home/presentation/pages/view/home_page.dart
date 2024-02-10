part of '../home.dart';

/// {@template sample_page}
/// SamplePage widget
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro sample_page}
  const HomePage({super.key});

  static const String name = "Home";
  static const String routePath = "/home";

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
                        onPressed: () {
                          context.pushNamed(SettingsPage.name);
                        },
                        splashRadius: 8,
                      ),
                      IconButton.filledTonal(
                        icon: const Icon(Icons.monitor_heart),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<Widget>(
                              builder: (_) => TalkerPage(
                                talker: talker,
                                theme: TalkerScreenTheme(
                                  backgroundColor:
                                      context.theme.colorScheme.background,
                                  textColor: context.colors.text,
                                  cardColor: context.colors.card,
                                ),
                                appBarLeading: IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        splashRadius: 8,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        context.l10n.locales,
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.colorScheme.onBackground,
                        ),
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
