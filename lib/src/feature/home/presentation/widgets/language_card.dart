part of '../pages/home.dart';

class _LanguageCard extends StatelessWidget {
  const _LanguageCard(this._language);

  final Locale _language;

  @override
  Widget build(BuildContext context) => Card(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: InkWell(
            onTap: () => SettingsScope.localeOf(context).setLocale(_language),
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              width: 64,
              child: Center(
                child: Text(
                  _language.languageCode,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ),
          ),
        ),
      );
}
