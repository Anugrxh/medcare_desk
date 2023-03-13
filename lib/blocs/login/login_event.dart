part of 'login_bloc.dart';

class LoginEvent {
  final String email, password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}
