import 'package:dartz/dartz.dart';
import 'package:frontend/src/core/services/network/api_failure.dart';
import 'package:frontend/src/features/auth/data/model/profile_model.dart';
import 'package:frontend/src/features/auth/domain/entity/login_entity.dart';
import 'package:frontend/src/features/auth/domain/entity/register_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, ProfileModel>> login(LoginEntity login);
  Future<Either<Failure, ProfileModel>> register(RegisterEntity register);
}
