part of '../../talker.dart';

class TalkerDataCard extends StatelessWidget {
  const TalkerDataCard({
    required this.data,
    super.key,
    this.onTap,
    this.expanded = true,
    this.margin,
    this.color,
  });

  final TalkerDataInterface data;
  final VoidCallback? onTap;
  final bool expanded;
  final EdgeInsets? margin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final errorMessage = _errorMessage;
    final color = this.color ?? _color;
    final errorType = _type;
    final message = _message;
    final stackTrace = _stackTrace;
    return Padding(
      padding: margin ?? const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          TalkerBaseCard(
            color: color,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${data.title} | ${data.displayTime}',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (onTap != null) Icon(Icons.copy, color: color, size: 18),
                  ],
                ),
                if (expanded)
                  Container(
                    width: double.infinity,
                    margin: stackTrace != null
                        ? const EdgeInsets.only(top: 8)
                        : null,
                    padding: stackTrace != null
                        ? const EdgeInsets.all(6)
                        : EdgeInsets.zero,
                    decoration: stackTrace != null
                        ? BoxDecoration(
                            border: Border.all(
                              color: color,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          )
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (expanded && errorType != null)
                          Text(
                            errorType,
                            style: TextStyle(
                              color: color,
                              fontSize: 12,
                            ),
                          ),
                        if (expanded && errorMessage != null)
                          Text(
                            errorMessage,
                            style: TextStyle(
                              color: color,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                if (expanded && message != null)
                  Text(
                    message,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                    ),
                  ),
                if (expanded && stackTrace != null)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: stackTraceBackground,
                      border: Border.all(
                        color: color,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      stackTrace,
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned.fill(
            left: 16,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? get _stackTrace {
    if (data is! TalkerError && data is! TalkerException) {
      return null;
    }
    return 'StackTrace:\n${data.stackTrace}';
  }

  Color get _color {
    if (data.title == WellKnownTitles.httpError.title) {
      return LogLevel.error.color;
    }
    if (data.title == WellKnownTitles.route.title) {
      return Colors.deepPurpleAccent;
    }
    if (data.title == WellKnownTitles.httpResponse.title) {
      return const Color.fromARGB(255, 93, 203, 96);
    }
    if (data.title == WellKnownTitles.httpRequest.title) {
      return httpRequestLogColor;
    }
    if (data.title == WellKnownTitles.route.title) {
      return routeLogColor;
    }
    if (data.title == WellKnownTitles.blocTransition.title) {
      return const Color.fromARGB(255, 119, 138, 98);
    }
    if (data.title == WellKnownTitles.blocEvent.title) {
      return const Color.fromARGB(255, 66, 107, 255);
    }

    return data.logLevel.color;
  }

  String? get _message {
    if (data is TalkerError || data is TalkerException) {
      return null;
    }
    final isHttpLog = [
      WellKnownTitles.httpError.title,
      WellKnownTitles.httpRequest.title,
      WellKnownTitles.httpResponse.title,
    ].contains(data.title);
    if (isHttpLog) {
      return data.generateTextMessage();
    }
    return data.displayMessage;
  }

  String? get _errorMessage {
    var txt = data.exception?.toString() ?? data.exception?.toString();

    if ((txt?.isNotEmpty ?? false) && txt!.contains('Source stack:')) {
      txt = 'Data: ${txt.split('Source stack:').first.replaceAll('\n', '')}';
    }
    return txt;
  }

  String? get _type {
    if (data is! TalkerError && data is! TalkerException) {
      return null;
    }
    return 'Type: ${data.exception?.runtimeType.toString() ?? data.error?.runtimeType.toString() ?? ''}';
  }
}

const defaultCardBackgroundColor = Color.fromARGB(255, 49, 49, 49);
const stackTraceBackground = Colors.transparent;
const httpResponseLogColor = Color(0xFF26FF3C);
const httpRequestLogColor = Color(0xFFF602C1);
const blocTransitionColor = Color(0xFF56FEA8);
const blocEventColor = Color(0xFF63FAFE);
const routeLogColor = Color(0xFFAF5FFF);
