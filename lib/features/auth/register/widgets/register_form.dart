import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          const CustomTextField(
            label: 'Full Name',
            hintText: 'John Doe',
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(height: 20),
          const CustomTextField(
            label: 'Email',
            hintText: 'john@example.com',
            prefixIcon: Icons.email_outlined,
          ),
          const SizedBox(height: 20),
          const CustomTextField(
            label: 'Password',
            hintText: '........',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 30),
          CustomButton(
            text: 'Create Account',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
