import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/data/datasources/auth_remote_datasources.dart';
import 'package:todo_app/domain/entities/user/user_entity.dart';
import 'package:todo_app/domain/repositories/auth_repository.dart';

class AuthRepositoriesImp implements AuthRepository {
  final AuthRemoteDatasources authRemoteDatasources;

  AuthRepositoriesImp(this.authRemoteDatasources);

  @override
  Future<Either<Failure, Unit>> register({
    required String username,
    required String email,
    required String passwordHash,
  }) async {
    try {
      await authRemoteDatasources.register(
        username: username,
        email: email,
        passwordHash: passwordHash,
      );
      return Future.value(const Right(unit));
    } catch (e) {
      debugPrint('Registration error: $e');
      return Future.value(Left(ServerFailure('Registration failed: $e')));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
