import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:frontend/src/core/bloc/observer/bloc_observer.dart';
import 'package:frontend/src/core/routes/app_router.dart';
import 'package:frontend/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  await GetStorage.init();
  Bloc.observer = AppBlocObserver(); // Set BlocObserver globally
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _appRouter.config());
  }
}
