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
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String passwordHash,
  }) async {
    try {
      final user = await authRemoteDatasources.login(
        email: email,
        passwordHash: passwordHash,
      );
      return Right(user);
    } catch (e) {
      debugPrint('Login error: $e');
      return Left(ServerFailure('Login failed: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await authRemoteDatasources.logout();
      return const Right(unit);
    } catch (e) {
      debugPrint('Logout error: $e');
      return Left(ServerFailure('Logout failed: $e'));
    }
  }
}
