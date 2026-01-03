import 'package:dio/dio.dart';
import 'package:todo_app/core/api/api_client.dart';

final dio = Dio(BaseOptions(baseUrl: ApiClient.baseUrl));
