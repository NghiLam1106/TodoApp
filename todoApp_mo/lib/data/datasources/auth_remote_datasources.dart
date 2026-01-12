import 'package:todo_app/core/api/api_client.dart';
import 'package:todo_app/core/config/dio.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/data/sharedPreferences/token_storage.dart';
import 'package:todo_app/domain/entities/user/user_entity.dart';

class AuthRemoteDatasources {
  Future<void> register({
    required String username,
    required String email,
    required String passwordHash,
  }) async {
    final response = await dio.post(
      '${ApiClient.auth}/register',
      data: {
        'username': username,
        'email': email,
        'passwordHash': passwordHash,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Future.value();
    } else {
      throw ServerFailure('Lỗi máy chủ. Vui lòng thử lại sau.');
    }
  }

  Future<UserEntity> login({
    required String email,
    required String passwordHash,
  }) async {
    final response = await dio.post(
      '${ApiClient.auth}/login',
      data: {'email': email, 'password_hash': passwordHash},
    );
    if (response.statusCode == 200) {
      final data = response.data;

      // Lưu tokens
      await TokenStorage.saveAccessToken(data['result']['accessToken']);
      await TokenStorage.saveRefreshToken(data['result']['refreshToken']);

      // Trả về user entity
      return UserEntity.fromJson(data['result']['userData']);
    } else {
      throw ServerFailure('Lỗi máy chủ. Vui lòng thử lại sau.');
    }
  }

  Future<void> logout() async {
    try {
      await TokenStorage.clear();
      return Future.value();
    } catch (e) {
      print('Logout API error: $e');
    }
  }
}
