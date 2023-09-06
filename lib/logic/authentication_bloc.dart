import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloclogin/packages/user_repository/lib/src/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../packages/user_repository/lib/src/models/models.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authRepo;
  final UserRepository _userRepo;
  late StreamSubscription<AuthenticationStatus>
      _authStatusSub;

  AuthenticationBloc(
      {required AuthenticationRepository authRepo,
      required UserRepository userRepo})
      : _authRepo = authRepo,
        _userRepo = userRepo,
        super(AuthenticationUnknown()) {
    on<AuthenticationEvent>((event, emit) async {
      on<AuthenticationLogoutRequested>(_onLogoutRequested);
      on<_AuthenticationStatusChanged>(_onAuthStatusChanged);   //This where the actual work will be done
      _authStatusSub = _authRepo.status.listen((status) {   //any status that will be coming from authRepo will be handled here
        add(_AuthenticationStatusChanged(status));
      });
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
    _authRepo.logOut();   // this func will send logout status down the stream which will be picked by authStreamSubscription
  }

  _onAuthStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) {


  }
}
