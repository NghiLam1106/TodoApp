import 'package:todo_app/core/api/api_client.dart';
import 'package:todo_app/core/config/dio.dart';
import 'package:todo_app/core/error/failures.dart';

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
}
