part of 'logic_bloc.dart';

@immutable
abstract class LoginEvent {}

class UserNameChanged extends LoginEvent{
  final String userName;
  UserNameChanged({required this.userName});
}

class PasswordChanged extends LoginEvent{
  final String password;
  PasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent{}


