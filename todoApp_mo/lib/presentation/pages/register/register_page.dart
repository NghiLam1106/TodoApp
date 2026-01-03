import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/constants/app_colors.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/constants/app_spacing.dart';
import 'package:todo_app/core/helper/scale.dart';
import 'package:todo_app/presentation/bloc/auth/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
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

  void _registerHandle(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      context.read<AuthBloc>().add(
        AuthEvent.register(
          username: username,
          email: email,
          passwordHash: password,
        ),
      );
    }
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
                        if (state == AuthState.error(state.toString())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.toString()),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }

                        if (state == AuthState.success()) {
                          if (state == AuthState.success()) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (dialogContext) {
                                return Dialog(
                                  backgroundColor: AppColors.backgroundColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 72,
                                          height: 72,
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(
                                              0.1,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 48,
                                          ),
                                        ),

                                        const SizedBox(height: 20),

                                        const Text(
                                          'Đăng ký thành công',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        Text(
                                          'Tài khoản của bạn đã được tạo',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: scale(
                                              context,
                                              AppFontSize.body,
                                            ),
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            Future.delayed(const Duration(seconds: 2), () {
                              if (!context.mounted) return;
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pop(); // đóng dialog
                              context.go('/login');
                            });
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state == AuthState.loading()) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Tạo tài khoản',
                                style: TextStyle(
                                  fontSize: scale(context, AppFontSize.titleXL),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: AppSpacing.xs),

                              Text(
                                'Vui lòng nhập thông tin để đăng ký',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: scale(context, AppFontSize.body),
                                  color: Colors.grey.shade600,
                                ),
                              ),

                              const SizedBox(height: AppSpacing.xl),

                              TextFormField(
                                controller: _usernameController,
                                textInputAction: TextInputAction.next,
                                decoration: _inputDecoration(
                                  context,
                                  label: 'Username',
                                  hint: 'Nhập tên người dùng',
                                  icon: Icons.person_outline,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập tên người dùng';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: AppSpacing.md),

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
                                  if (!RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+',
                                  ).hasMatch(value)) {
                                    return 'Vui lòng nhập email hợp lệ';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: AppSpacing.md),

                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                decoration: _inputDecoration(
                                  context,
                                  label: 'Mật khẩu',
                                  hint: 'Nhập mật khẩu',
                                  icon: Icons.lock_outline,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập mật khẩu';
                                  }
                                  if (value.length < 6) {
                                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: AppSpacing.xl),

                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _registerHandle(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Colors.grey.shade100,
                                  ),
                                  child: const Text(
                                    'Đăng ký',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: AppSpacing.lg),

                              TextButton(
                                onPressed: () {
                                  context.go('/login');
                                },
                                child: Text(
                                  'Đã có tài khoản? Đăng nhập',
                                  style: TextStyle(
                                    fontSize: scale(context, AppFontSize.body),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
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

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
