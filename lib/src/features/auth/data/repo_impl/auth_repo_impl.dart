import 'package:dartz/dartz.dart';
import 'package:frontend/src/core/services/network/api_failure.dart';
import 'package:frontend/src/features/auth/data/model/profile_model.dart';
import 'package:frontend/src/features/auth/data/sources/remote_source.dart';
import 'package:frontend/src/features/auth/domain/entity/login_entity.dart';
import 'package:frontend/src/features/auth/domain/entity/register_entity.dart';
import 'package:frontend/src/features/auth/domain/repo/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authRemoteSource);
  final AuthRemoteSource _authRemoteSource;

  @override
  Future<Either<Failure, ProfileModel>> login(LoginEntity login) async {
    return _authRemoteSource.login(login);
  }

  @override
  Future<Either<Failure, ProfileModel>> register(
    RegisterEntity register,
  ) async {
    return _authRemoteSource.register(register);
  }
}
