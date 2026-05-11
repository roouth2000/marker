import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (event.email == "test@test.com" && event.password == "password") {
      emit(state.copyWith(status: LoginStatus.success));
    } else {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: "Invalid email or password",
      ));
    }
  }
}
