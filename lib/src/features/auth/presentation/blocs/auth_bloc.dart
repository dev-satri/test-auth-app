import 'package:frontend/src/core/services/network/api_failure.dart';
import 'package:frontend/src/features/auth/data/model/profile_model.dart';
import 'package:frontend/src/features/auth/domain/entity/login_entity.dart';
import 'package:frontend/src/features/auth/domain/entity/register_entity.dart';
import 'package:frontend/src/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(AuthState()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
  }

  final AuthRepository _authRepository;

  void _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await _authRepository.login(
      LoginEntity(email: event.email, password: event.password),
    );
    response.fold(
      (error) => emit(state.copyWith(isLoading: false, failure: error)),
      (result) {
        emit(state.copyWith(isLoading: false, profileModel: result));
      },
    );
  }

  void _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await _authRepository.register(
      RegisterEntity(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (error) => emit(state.copyWith(isLoading: false, failure: error)),
      (result) {
        emit(state.copyWith(isLoading: false, profileModel: result));
      },
    );
  }
}
