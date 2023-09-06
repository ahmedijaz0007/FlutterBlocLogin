import 'dart:async';

import 'package:bloclogin/packages/authentication/lib/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_repository/src/models/models.dart';

import 'package:bloclogin/packages/user_repository/lib/src/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authRepo;
  final UserRepository _userRepo;
  late StreamSubscription<AuthenticationStatus> _authStatusSub;

  AuthenticationBloc(
      {required AuthenticationRepository authRepo,
      required UserRepository userRepo})
      : _authRepo = authRepo,
        _userRepo = userRepo,
        super(AuthenticationUnknown()) {
      on<AuthenticationLogoutRequested>(_onLogoutRequested);
      on<_AuthenticationStatusChanged>(
          _onAuthStatusChanged); //This where the actual work will be done
      _authStatusSub = _authRepo.status.listen((status) {
        //any status that will be coming from authRepo will be listened
        add(_AuthenticationStatusChanged(status));
      });

  }

  @override
  Future<void> close() {
    _authStatusSub.cancel();
    return super.close();
  }

  _onLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authRepo
        .logOut(); // this func will send logout status down the stream which will be picked by authStreamSubscription
  }

  _onAuthStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case (AuthenticationStatus.unauthenticated):
        emit(UnAuthenticated()); //emit unAuthenticated state to view
      case (AuthenticationStatus.authenticated):
        final User? user = await _tryGetUser();
        return emit(user != null
            ? Authenticated(user)
            : UnAuthenticated()); //emit authenticated or Unauthenticated depending upon user

      case AuthenticationStatus.unknown:
        return emit(AuthenticationUnknown());
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepo.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
