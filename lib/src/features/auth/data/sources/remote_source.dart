import 'package:dartz/dartz.dart';
import 'package:frontend/src/core/services/network/api_endpoints.dart';
import 'package:frontend/src/core/services/network/api_failure.dart';
import 'package:frontend/src/core/services/network/network_service.dart';
import 'package:frontend/src/features/auth/data/model/profile_model.dart';
import 'package:frontend/src/features/auth/domain/entity/login_entity.dart';
import 'package:frontend/src/features/auth/domain/entity/register_entity.dart';

class AuthRemoteSource {
  const AuthRemoteSource(this._networkService);
  final NetworkService _networkService;

  Future<Either<Failure, ProfileModel>> login(LoginEntity login) async {
    final response = await _networkService.post(
      ApiEndpoints.login,
      body: {"email": login.email, "password": login.password},
    );
    return response.fold(
      (error) {
        return Left(error);
      },
      (result) async {
        final ProfileModel profileModel = ProfileModel.fromJson(result);
        await _networkService.setToken(profileModel.token);
        return Right(profileModel);
      },
    );
  }

  Future<Either<Failure, ProfileModel>> register(
    RegisterEntity register,
  ) async {
    final response = await _networkService.post(
      ApiEndpoints.signUp,
      body: {
        "name": register.name,
        "email": register.email,
        "password": register.password,
      },
    );
    return response.fold(
      (error) {
        return Left(error);
      },
      (result) async {
        final ProfileModel profileModel = ProfileModel.fromJson(result);
        await _networkService.setToken(profileModel.token);
        return Right(profileModel);
      },
    );
  }
}
