import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/constants/app_spacing.dart';
import 'package:todo_app/core/helper/scale.dart';
import 'package:todo_app/presentation/bloc/auth/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

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
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        state.whenOrNull(
                          error: (message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          },
                          authenticated: (user) {
                            // Navigate đến home với user data
                            context.go('/home', extra: user);
                          },
                        );
                      },
                      builder: (context, state) {
                        return Column(
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

                            /// Form
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  /// Email
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    decoration: _inputDecoration(
                                      context,
                                      label: 'Email',
                                      hint: 'Nhập email',
                                      icon: Icons.email_outlined,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui lòng nhập email';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: AppSpacing.md),

                                  /// Password
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: !_passwordVisible,
                                    textInputAction: TextInputAction.done,
                                    decoration:
                                        _inputDecoration(
                                          context,
                                          label: 'Mật khẩu',
                                          hint: 'Nhập mật khẩu',
                                          icon: Icons.lock_outline,
                                        ).copyWith(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui lòng nhập mật khẩu';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
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
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      AuthEvent.login(
                                        email: _emailController.text,
                                        passwordHash: _passwordController.text,
                                      ),
                                    );
                                  }
                                },
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
                        );
                      },
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
