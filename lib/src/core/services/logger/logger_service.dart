import 'package:frontend/di.dart';
import 'package:logger/logger.dart';

LoggerService get logger => sl<LoggerService>();

class LoggerService {
  final Logger _logger;

  LoggerService({required bool isProduction})
    : _logger = Logger(
        printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
        level: isProduction ? Level.warning : Level.debug,
      );

  void debug(String message) => _logger.d(message);
  void info(String message) => _logger.i(message);
  void warning(String message) => _logger.w(message);
  void error(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
