part of '_bloc.dart';

abstract class SignInScreenState {}

final class Loading extends SignInScreenState {}

final class Loaded extends SignInScreenState {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  Loaded(
      {required this.formKey,
      required this.emailController,
      required this.passwordController});
}

final class Error extends SignInScreenState {}
