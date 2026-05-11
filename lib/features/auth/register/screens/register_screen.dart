import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/register/register_bloc.dart';
import '../widgets/register_form.dart';
import '../../login/widgets/login_header.dart'; // Reusing header for consistency

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterBloc(),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              LoginHeader(), // This header can be made generic if needed
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
