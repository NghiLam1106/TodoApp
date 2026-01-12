import 'package:dio/dio.dart';
import 'package:todo_app/core/api/api_client.dart';
import 'package:todo_app/data/sharedPreferences/token_storage.dart';

final Dio dio = _createDio();

Dio _createDio() {
  final dioInstance = Dio(BaseOptions(baseUrl: ApiClient.baseUrl));

  dioInstance.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getAccessToken();

        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }

        handler.next(options);
      },
      onError: (DioException error, handler) async {
        final response = error.response;
        final requestOptions = error.requestOptions;

        // Nếu access token hết hạn
        if (response?.statusCode == 400 &&
            requestOptions.extra["retry"] != true) {
          requestOptions.extra["retry"] = true;

          try {
            final refreshToken = await TokenStorage.getRefreshToken();

            if (refreshToken == null) {
              return handler.reject(error);
            }

            // Gọi refresh token
            final refreshResponse = await dioInstance.post(
              '${ApiClient.auth}/refresh-token',
              data: {"refreshToken": refreshToken},
            );

            final newAccessToken = refreshResponse.data["accessToken"];

            // Lưu token mới
            await TokenStorage.saveAccessToken(newAccessToken);

            // Gắn token mới vào request cũ
            requestOptions.headers["Authorization"] = "Bearer $newAccessToken";

            // Gửi lại request cũ
            final clonedResponse = await dioInstance.fetch(requestOptions);

            return handler.resolve(clonedResponse);
          } catch (e) {
            // Refresh token hết hạn → logout
            await TokenStorage.clear();
            return handler.reject(error);
          }
        }

        handler.reject(error);
      },
    ),
  );

  return dioInstance;
}
