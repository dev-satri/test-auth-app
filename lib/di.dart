import 'package:frontend/src/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:frontend/src/features/auth/data/sources/remote_source.dart';
import 'package:frontend/src/features/auth/domain/repo/auth_repo.dart';
import 'package:frontend/src/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:frontend/src/core/services/logger/logger_service.dart';
import 'package:frontend/src/core/services/network/network_service.dart';

final sl = GetIt.instance; //sl-> service locator

void initDependencies() {
  services();
  sources();
  repo();
  blocs();
}

void services() {
  sl.registerLazySingleton(
    () => LoggerService(
      isProduction: const bool.fromEnvironment('dart.vm.product'),
    ),
  );
  sl.registerLazySingleton<NetworkService>(() => NetworkService());
}

void sources() {
  sl.registerLazySingleton<AuthRemoteSource>(() => AuthRemoteSource(sl()));
}

void repo() {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
}

void blocs() {
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(sl()));
}
