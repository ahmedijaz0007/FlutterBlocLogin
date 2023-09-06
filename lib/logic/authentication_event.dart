part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {
  const AuthenticationEvent();  //value can not be changed.
}

//onlogoutReq
//onAuthenticationStatusChange


final class _AuthenticationStatusChanged extends AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}

