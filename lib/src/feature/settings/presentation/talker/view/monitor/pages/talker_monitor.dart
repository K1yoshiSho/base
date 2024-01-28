part of '../../../talker.dart';

class TalkerMonitor extends StatelessWidget {
  const TalkerMonitor({
    required this.talker,
    super.key,
  });

  /// Talker implementation
  final Talker talker;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Talker Monitor',
              style: context.theme.textTheme.titleMedium,
            ),
          ),
        ),
        body: TalkerBuilder(
          talker: talker,
          builder: (context, data) {
            final logs = data.whereType<TalkerLog>().toList();
            final errors = data.whereType<TalkerError>().toList();
            final exceptions = data.whereType<TalkerException>().toList();
            final warnings =
                logs.where((e) => e.logLevel == LogLevel.warning).toList();
            final goods =
                logs.where((e) => e.logLevel == LogLevel.good).toList();
            final infos =
                logs.where((e) => e.logLevel == LogLevel.info).toList();
            final verboseDebug = logs
                .where(
                  (e) =>
                      e.logLevel == LogLevel.verbose ||
                      e.logLevel == LogLevel.debug,
                )
                .toList();

            final httpRequests = data
                .where((e) => e.title == WellKnownTitles.httpRequest.title)
                .toList();
            final httpErrors = data
                .where((e) => e.title == WellKnownTitles.httpError.title)
                .toList();
            final httpResponses = data
                .where((e) => e.title == WellKnownTitles.httpResponse.title)
                .toList();

            return CustomScrollView(
              slivers: [
                if (httpRequests.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: Gap(10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorCard(
                      logs: httpRequests,
                      title: context.l10n.talker_type_http,
                      color: Colors.green,
                      icon: Icons.wifi,
                      onTap: () => _openTypedLogsScreen(
                        context,
                        httpRequests,
                        context.l10n.talker_type_http,
                      ),
                      subtitleWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '${httpRequests.length}',
                              style: context.theme.textTheme.bodyMedium,
                              children: const [
                                TextSpan(text: ' http requests executed'),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '${httpResponses.length} successful',
                              style: const TextStyle(color: Colors.green),
                              children: const [
                                TextSpan(
                                  text: ' responses received',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '${httpErrors.length} failure',
                              style: const TextStyle(color: Colors.red),
                              children: const [
                                TextSpan(
                                  text: ' responses received',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (errors.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: Gap(10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorCard(
                      logs: errors,
                      title: context.l10n.talker_type_errors,
                      color: Colors.red,
                      icon: Icons.error_outline_rounded,
                      subtitle:
                          context.l10n.talker_type_errors_count(errors.length),
                      onTap: () => _openTypedLogsScreen(
                        context,
                        errors,
                        context.l10n.talker_type_errors,
                      ),
                    ),
                  ),
                ],
                if (exceptions.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: Gap(10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorCard(
                      logs: exceptions,
                      title: context.l10n.talker_type_exceptions,
                      color: LogLevel.error.color,
                      icon: Icons.error_outline_rounded,
                      subtitle: context.l10n.talker_type_exceptions_count(
                        exceptions.length,
                      ),
                      onTap: () => _openTypedLogsScreen(
                        context,
                        exceptions,
                        context.l10n.talker_type_exceptions,
                      ),
                    ),
                  ),
                ],
                if (warnings.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: Gap(10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorCard(
                      logs: warnings,
                      title: context.l10n.talker_type_warnings,
                      color: LogLevel.warning.color,
                      icon: Icons.warning_amber_rounded,
                      subtitle: context.l10n.talker_type_warnings_count(
                        warnings.length,
                      ),
                      onTap: () => _openTypedLogsScreen(
                        context,
                        warnings,
                        context.l10n.talker_type_warnings,
                      ),
                    ),
                  ),
                ],
                if (infos.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: Gap(10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorCard(
                      logs: infos,
                      title: context.l10n.talker_type_info,
                      color: LogLevel.info.color,
                      icon: Icons.info_outline_rounded,
                      subtitle: context.l10n.talker_type_info_count(
                        infos.length,
                      ),
                      onTap: () => _openTypedLogsScreen(
                        context,
                        infos,
                        context.l10n.talker_type_info,
                      ),
                    ),
                  ),
                ],
                if (goods.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: Gap(10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorCard(
                      logs: goods,
                      title: context.l10n.talker_type_good,
                      color: LogLevel.good.color,
                      icon: Icons.check_circle_outline_rounded,
                      subtitle: context.l10n.talker_type_good_count(
                        goods.length,
                      ),
                      onTap: () => _openTypedLogsScreen(
                        context,
                        goods,
                        context.l10n.talker_type_good,
                      ),
                    ),
                  ),
                ],
                if (verboseDebug.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: Gap(10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorCard(
                      logs: verboseDebug,
                      title: context.l10n.talker_type_debug,
                      color: LogLevel.verbose.color,
                      icon: Icons.remove_red_eye_outlined,
                      subtitle: context.l10n.talker_type_debug_count(
                        verboseDebug.length,
                      ),
                      onTap: () => _openTypedLogsScreen(
                        context,
                        verboseDebug,
                        context.l10n.talker_type_debug,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      );

  void _openTypedLogsScreen(
    BuildContext context,
    List<TalkerDataInterface> logs,
    String typeName,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (context) => TalkerMonitorTypedLogsScreen(
          exceptions: logs,
          typeName: typeName,
        ),
      ),
    );
  }
}
