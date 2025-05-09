import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/src/core/services/logger/logger_service.dart';
import 'package:frontend/di.dart';

class AppBlocObserver extends BlocObserver {
  final LoggerService _loggerService = sl<LoggerService>();

  /// We can run something when we create our Bloc
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    /// We can check if the BlocBase is a Bloc or a Cubit
    if (bloc is Cubit) {
      _loggerService.info("$bloc is a Cubit");
    } else {
      _loggerService.info("$bloc is a Bloc");
    }
  }

  /// We can react to events
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _loggerService.info("An event happened in $bloc, the event is $event");
  }

  /// We can even react to transitions
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    /// With this, we can specifically know when and what changed in our Bloc
    _loggerService.info(
      "There was a transition from ${transition.currentState} to ${transition.nextState}",
    );
  }

  /// We can react to errors, and we will know the error and the StackTrace
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _loggerService.error(
      "Error happened in $bloc with error $error and the stacktrace is $stackTrace",
      error,
      stackTrace,
    );
  }

  /// We can even run something when we close our Bloc
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _loggerService.info("$bloc is closed");
  }
}
