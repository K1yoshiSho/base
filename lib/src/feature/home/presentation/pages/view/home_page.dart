part of '../home.dart';

/// {@template sample_page}
/// SamplePage widget
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro sample_page}
  const HomeScreen({super.key});

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
                    context.l10n.appTitle.capitalize(),
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onBackground,
                    ),
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
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    context.l10n.locales,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onBackground,
                    ),
                  ),
                ),
                _LanguagesSelector(Localization.supportedLocales),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    context.l10n.default_themes,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onBackground,
                    ),
                  ),
                ),
                const _ThemeSelector(Colors.primaries),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    context.l10n.custom_colors,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onBackground,
                    ),
                  ),
                ),
                const _ThemeSelector(Colors.accents),
                SwitchListTile.adaptive(
                  activeColor: context.theme.colorScheme.primaryContainer,
                  title: Text(
                    context.l10n.change_theme,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onBackground,
                    ),
                  ),
                  value: SettingsScope.themeOf(context).isDarkMode,
                  onChanged: (value) {
                    SettingsScope.themeOf(context).setThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ]),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Card(
                      color: context.theme.colorScheme.primaryContainer,
                      margin: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
