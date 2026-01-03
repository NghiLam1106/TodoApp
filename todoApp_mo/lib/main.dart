import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/constants/app_colors.dart';
import 'package:todo_app/data/datasources/auth_remote_datasources.dart';
import 'package:todo_app/data/repositories/auth_repositories_imp.dart';
import 'package:todo_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:todo_app/presentation/routes/app_route.dart';

void main() {
  final authRepository = AuthRepositoriesImp(AuthRemoteDatasources());

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthBloc(authRepository))],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.createRouter(),
    );
  }
}
