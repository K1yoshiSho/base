part of '../home.dart';

/// {@template sample_page}
/// SamplePage widget
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro sample_page}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Localization.of(context).appTitle.capitalize(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.monitor_heart),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<Widget>(
                          builder: (_) => CustomTalkerScreen(
                            talker: talker,
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
                    Localization.of(context).locales,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
                _LanguagesSelector(Localization.supportedLocales),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Localization.of(context).default_themes,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
                const _ThemeSelector(Colors.primaries),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    Localization.of(context).custom_colors,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
                const _ThemeSelector(Colors.accents),
                SwitchListTile.adaptive(
                  activeColor: context.theme.colorScheme.primaryContainer,
                  title: Text(
                    Localization.of(context).change_theme,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
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
                      color: Theme.of(context).colorScheme.primaryContainer,
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
