part of 'auth_bloc.dart';

class AuthState {
  const AuthState({this.isLoading = false, this.profileModel, this.failure});
  final bool isLoading;
  final ProfileModel? profileModel;
  final Failure? failure;

  AuthState copyWith({
    bool? isLoading,
    ProfileModel? profileModel,
    Failure? failure,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      profileModel: profileModel ?? this.profileModel,
      failure: failure ?? this.failure,
    );
  }
}
