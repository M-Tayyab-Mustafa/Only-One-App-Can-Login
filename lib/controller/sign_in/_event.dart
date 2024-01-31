part of '_bloc.dart';

abstract class SignInScreenEvent {}

final class Initial extends SignInScreenEvent {}

final class SignIn extends SignInScreenEvent {
  final BuildContext context;

  SignIn({required this.context});
}

final class SignUp extends SignInScreenEvent {
  final BuildContext context;

  SignUp({required this.context});
}
