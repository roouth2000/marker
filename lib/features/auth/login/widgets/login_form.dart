import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/social_button.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../register/screens/register_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: 'Mobile or email',
              hintText: '+91 98450 12345',
              prefixIcon: Icons.phone_android,
              controller: _emailController,
              validator: (val) => val != null && val.isNotEmpty ? null : 'Required',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Password',
              hintText: '........',
              prefixIcon: Icons.lock_outline,
              isPassword: _obscurePassword,
              controller: _passwordController,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
              validator: (val) => val != null && val.length >= 6 ? null : 'Password too short',
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(color: AppColors.textLink, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 10),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login Successful!')),
                  );
                } else if (state.status == LoginStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage ?? 'Login Failed')),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  text: 'Sign in',
                  isLoading: state.status == LoginStatus.loading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(
                            LoginSubmitted(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.borderLight)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'or continue with',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ),
                Expanded(child: Divider(color: AppColors.borderLight)),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                SocialButton(
                  text: 'Google',
                  iconPath: 'assets/google.png',
                  onPressed: () {},
                ),
                const SizedBox(width: 15),
                SocialButton(
                  text: 'Apple',
                  iconPath: 'assets/apple.png',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'New here? ',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text(
                    'Create account',
                    style: TextStyle(
                      color: AppColors.textLink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
