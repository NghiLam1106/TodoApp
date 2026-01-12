import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/entities/user/user_entity.dart';
import 'package:todo_app/presentation/pages/home/home_page.dart';
import 'package:todo_app/presentation/pages/login/login_page.dart';
import 'package:todo_app/presentation/pages/register/register_page.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
}

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.login,
      routes: [
        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.register,
          name: 'register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          builder: (context, state) {
            final user = state.extra as UserEntity?;
            if (user == null) {
              // Nếu không có user, redirect về login
              return const LoginPage();
            }
            return HomePage(user: user);
          },
        ),
      ],
    );
  }
}
