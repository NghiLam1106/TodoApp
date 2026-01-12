import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/domain/entities/user/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String passwordHash,
  });
  Future<Either<Failure, Unit>> register({
    required String username,
    required String email,
    required String passwordHash,
  });
  Future<Either<Failure, Unit>> logout();
}
