part of '../pages/home.dart';

class _ThemeCard extends StatelessWidget {
  const _ThemeCard(this._color);

  final Color _color;

  @override
  Widget build(BuildContext context) => Card(
        child: Material(
          color: _color,
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            onTap: () {
              SettingsScope.themeOf(context).setThemeSeedColor(_color);
            },
            borderRadius: BorderRadius.circular(4),
            child: const SizedBox.square(dimension: 64),
          ),
        ),
      );
}
