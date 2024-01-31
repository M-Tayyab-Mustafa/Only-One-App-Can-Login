part of '_bloc.dart';

abstract class HomeScreenEvent {}

final class Initial extends HomeScreenEvent {}

final class SignOut extends HomeScreenEvent {
  final BuildContext context;

  SignOut({required this.context});
}
