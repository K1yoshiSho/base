// ignore_for_file: inference_failure_on_function_return_type, avoid_positional_boolean_parameters

part of '../../talker.dart';

class TalkerViewAppBar extends StatelessWidget {
  const TalkerViewAppBar({
    required this.title,
    required this.leading,
    required this.talker,
    required this.titilesController,
    required this.controller,
    required this.titles,
    required this.unicTitles,
    required this.onMonitorTap,
    required this.onSettingsTap,
    required this.onActionsTap,
    required this.onToggleTitle,
    required this.searchController,
    required this.searchFocusNode,
    super.key,
  });

  final String? title;
  final Widget? leading;

  final Talker talker;
  final GroupButtonController titilesController;
  final TalkerViewController controller;

  final List<String> titles;
  final List<String> unicTitles;

  final VoidCallback onMonitorTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onActionsTap;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;

  final Function(String title, bool isSelected) onToggleTitle;

  @override
  Widget build(BuildContext context) => SliverAppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        pinned: true,
        floating: true,
        expandedHeight: 180,
        collapsedHeight: 60,
        toolbarHeight: 60,
        leading: leading,
        iconTheme: IconThemeData(
          color: context.theme.textColor,
        ),
        actions: [
          UnconstrainedBox(
            child: _MonitorButton(
              talker: talker,
              onPressed: onMonitorTap,
            ),
          ),
          UnconstrainedBox(
            child: IconButton(
              onPressed: onSettingsTap,
              icon: const Icon(
                Icons.settings_rounded,
              ),
            ),
          ),
          UnconstrainedBox(
            child: IconButton(
              onPressed: onActionsTap,
              icon: const Icon(
                Icons.menu_rounded,
              ),
            ),
          ),
          const Gap(10),
        ],
        title: title != null
            ? Text(
                title!,
                style: context.theme.textTheme.titleMedium,
              )
            : null,
        flexibleSpace: FlexibleSpaceBar(
          background: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      scrollDirection: Axis.horizontal,
                      children: [
                        GroupButton(
                          controller: titilesController,
                          isRadio: false,
                          buttonBuilder: (selected, value, context) {
                            final count =
                                titles.where((e) => e == value).length;
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selected
                                    ? context.theme.colorScheme.primary
                                    : context
                                        .theme.colorScheme.secondaryContainer,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Text(
                                      '$count',
                                      style: context.theme.textTheme.bodySmall
                                          ?.copyWith(
                                        color: selected
                                            ? context
                                                .theme.colorScheme.onPrimary
                                            : context.theme.textColor,
                                      ),
                                    ),
                                    const Gap(4),
                                    Text(
                                      value,
                                      style: context.theme.textTheme.bodySmall
                                          ?.copyWith(
                                        color: selected
                                            ? context
                                                .theme.colorScheme.onPrimary
                                            : context.theme.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          onSelected: (_, i, selected) =>
                              onToggleTitle(unicTitles[i], selected),
                          buttons: unicTitles,
                        ),
                      ],
                    ),
                  ),
                  const Gap(4),
                  _SearchTextField(
                    controller: controller,
                    searchFocusNode: searchFocusNode,
                    searchController: searchController,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _SearchTextField extends StatelessWidget {
  const _SearchTextField({
    required this.controller,
    required this.searchController,
    required this.searchFocusNode,
  });

  final TalkerViewController controller;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        style: theme.textTheme.bodyLarge!.copyWith(
          color: context.theme.textColor,
          fontSize: 14,
        ),
        focusNode: searchFocusNode,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onChanged: controller.updateFilterSearchQuery,
        decoration: InputDecoration(
          fillColor: theme.cardColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: searchFocusNode == FocusScope.of(context).focusedChild
                ? theme.colorScheme.primary
                : Colors.grey,
          ),
          hintText: 'Search...',
          hintStyle: theme.textTheme.bodyLarge!.copyWith(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _MonitorButton extends StatelessWidget {
  const _MonitorButton({
    required this.talker,
    required this.onPressed,
  });

  final Talker talker;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => TalkerBuilder(
        talker: talker,
        builder: (context, data) {
          final haveErrors = data
              .where((e) => e is TalkerError || e is TalkerException)
              .isNotEmpty;
          return Stack(
            children: [
              Center(
                child: IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.monitor_heart_outlined,
                  ),
                ),
              ),
              if (haveErrors)
                Positioned(
                  right: 6,
                  top: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    height: 7,
                    width: 7,
                  ),
                ),
            ],
          );
        },
      );
}
