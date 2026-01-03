import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/constants/app_spacing.dart';
import 'package:todo_app/core/helper/scale.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Title
                        Text(
                          'Đăng nhập',
                          style: TextStyle(
                            fontSize: scale(context, AppFontSize.titleXL),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xs),

                        /// Subtitle
                        Text(
                          'Chào mừng bạn quay trở lại',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: scale(context, AppFontSize.body),
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        /// Email
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: _inputDecoration(
                            context,
                            label: 'Email',
                            hint: 'Nhập email',
                            icon: Icons.email_outlined,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.md),

                        /// Password
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          decoration: _inputDecoration(
                            context,
                            label: 'Mật khẩu',
                            hint: 'Nhập mật khẩu',
                            icon: Icons.lock_outline,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.sm),

                        /// Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                fontSize: scale(context, AppFontSize.body),
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: AppSpacing.lg),

                        /// Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.grey.shade100,
                            ),
                            child: Text(
                              'Đăng nhập',
                              style: TextStyle(
                                fontSize: scale(
                                  context,
                                  AppFontSize.titleSmall,
                                ),
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: AppSpacing.lg),

                        /// Register hint
                        TextButton(
                          onPressed: () {
                            context.go('/register');
                          },
                          child: Text(
                            'Chưa có tài khoản? Đăng ký',
                            style: TextStyle(
                              fontSize: scale(context, AppFontSize.body),
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
