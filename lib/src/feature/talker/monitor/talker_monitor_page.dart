// ignore_for_file: implementation_imports

import 'package:base_starter/src/common/utils/extensions/context_extension.dart';
import 'package:base_starter/src/feature/talker/monitor/monitor_card.dart';
import 'package:base_starter/src/feature/talker/monitor/monitor_info_page.dart';
import 'package:base_starter/src/feature/talker/utils/get_data_color.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitorPage extends StatelessWidget {
  const TalkerMonitorPage({
    required this.theme,
    required this.talker,
    super.key,
  });

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme theme;

  /// Talker implementation
  final Talker talker;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Talker Monitor',
              style: TextStyle(fontSize: 18),
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
            final goods = logs.where((e) => e.title == "good").toList();

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
                .where((e) => e.key == TalkerLogType.httpRequest.key)
                .toList();
            final httpErrors = data
                .where((e) => e.key == TalkerLogType.httpError.key)
                .toList();
            final httpResponses = data
                .where((e) => e.key == TalkerLogType.httpResponse.key)
                .toList();
            final allHttps = data
                .where(
                  (e) =>
                      e.key == TalkerLogType.httpRequest.key ||
                      e.key == TalkerLogType.httpError.key ||
                      e.key == TalkerLogType.httpResponse.key,
                )
                .toList();
            final blocEvents = data
                .where((e) => e.key == TalkerLogType.blocEvent.key)
                .toList();
            final blocTransitions = data
                .where((e) => e.key == TalkerLogType.blocTransition.key)
                .toList();
            final blocCreates = data
                .where((e) => e.key == TalkerLogType.blocCreate.key)
                .toList();
            final blocCloses = data
                .where((e) => e.key == TalkerLogType.blocClose.key)
                .toList();
            final allBlocs = data
                .where(
                  (e) =>
                      e.key == TalkerLogType.blocEvent.key ||
                      e.key == TalkerLogType.blocTransition.key ||
                      e.key == TalkerLogType.blocCreate.key ||
                      e.key == TalkerLogType.blocClose.key,
                )
                .toList();

            return CustomScrollView(
              slivers: [
                if (httpRequests.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorsCard(
                      logs: httpRequests,
                      title: context.l10n.talker_type_http,
                      color: Colors.green,
                      icon: Icons.http_rounded,
                      onTap: () => _openTypedLogsScreen(
                        context,
                        allHttps,
                        context.l10n.talker_type_http,
                      ),
                      subtitleWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.talker_http_requests_count(
                              httpRequests.length,
                            ),
                            style: const TextStyle(
                              color: Color(0xFFF602C1),
                            ),
                          ),
                          Text(
                            context.l10n.talker_http_failues_count(
                              httpErrors.length,
                            ),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 239, 83, 80),
                            ),
                          ),
                          Text(
                            context.l10n.talker_http_responses_count(
                              httpResponses.length,
                            ),
                            style: const TextStyle(
                              color: Color(0xFF26FF3C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (allBlocs.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorsCard(
                      logs: allBlocs,
                      title: context.l10n.talker_type_bloc,
                      color: Colors.grey,
                      icon: Icons.code_rounded,
                      onTap: () => _openTypedLogsScreen(
                        context,
                        allBlocs,
                        context.l10n.talker_type_bloc,
                      ),
                      subtitleWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.talker_bloc_events_count(
                              blocEvents.length,
                            ),
                            style: TextStyle(
                              color: getTypeColor(
                                context: context,
                                key: "bloc-event",
                              ),
                            ),
                          ),
                          Text(
                            context.l10n.talker_bloc_transition_count(
                              blocTransitions.length,
                            ),
                            style: TextStyle(
                              color: getTypeColor(
                                context: context,
                                key: "bloc-transition",
                              ),
                            ),
                          ),
                          Text(
                            context.l10n.talker_bloc_create_count(
                              blocCreates.length,
                            ),
                            style: TextStyle(
                              color: getTypeColor(
                                context: context,
                                key: "bloc-create",
                              ),
                            ),
                          ),
                          Text(
                            context.l10n.talker_bloc_close_count(
                              blocCloses.length,
                            ),
                            style: TextStyle(
                              color: getTypeColor(
                                context: context,
                                key: "bloc-close",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (errors.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorsCard(
                      logs: errors,
                      title: context.l10n.talker_type_errors,
                      color: theme.logColors.getByType(TalkerLogType.error),
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
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorsCard(
                      logs: exceptions,
                      title: context.l10n.talker_type_exceptions,
                      color: theme.logColors.getByType(TalkerLogType.exception),
                      icon: Icons.error_outline_rounded,
                      subtitle: context.l10n
                          .talker_type_exceptions_count(exceptions.length),
                      onTap: () => _openTypedLogsScreen(
                        context,
                        exceptions,
                        context.l10n.talker_type_exceptions,
                      ),
                    ),
                  ),
                ],
                if (warnings.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorsCard(
                      logs: warnings,
                      title: context.l10n.talker_type_warnings,
                      color: theme.logColors.getByType(TalkerLogType.warning),
                      icon: Icons.warning_amber_rounded,
                      subtitle: context.l10n
                          .talker_type_warnings_count(warnings.length),
                      onTap: () => _openTypedLogsScreen(
                        context,
                        warnings,
                        context.l10n.talker_type_warnings,
                      ),
                    ),
                  ),
                ],
                if (infos.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorsCard(
                      logs: infos,
                      title: context.l10n.talker_type_info,
                      color: theme.logColors.getByType(TalkerLogType.info),
                      icon: Icons.info_outline_rounded,
                      subtitle:
                          context.l10n.talker_type_info_count(infos.length),
                      onTap: () => _openTypedLogsScreen(
                        context,
                        infos,
                        context.l10n.talker_type_info,
                      ),
                    ),
                  ),
                ],
                if (goods.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorsCard(
                      logs: goods,
                      title: context.l10n.talker_type_good,
                      color: getTypeColor(context: context, key: "good"),
                      icon: Icons.check_circle_outline_rounded,
                      subtitle:
                          context.l10n.talker_type_good_count(goods.length),
                      onTap: () => _openTypedLogsScreen(
                        context,
                        goods,
                        context.l10n.talker_type_good,
                      ),
                    ),
                  ),
                ],
                if (verboseDebug.isNotEmpty) ...[
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverToBoxAdapter(
                    child: TalkerMonitorsCard(
                      logs: verboseDebug,
                      title: context.l10n.talker_type_debug,
                      color: theme.logColors.getByType(TalkerLogType.verbose),
                      icon: Icons.remove_red_eye_outlined,
                      subtitle: context.l10n
                          .talker_type_debug_count(verboseDebug.length),
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
    List<TalkerData> logs,
    String typeName,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (context) => TalkerMonitorLogsScreen(
          exceptions: logs,
          theme: theme,
          typeName: typeName,
        ),
      ),
    );
  }
}
