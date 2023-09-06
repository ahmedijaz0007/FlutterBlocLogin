
import 'package:bloc/bloc.dart';
import 'package:bloclogin/packages/authentication/lib/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

part 'logic_event.dart';
part 'logic_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authRepo;

  LoginBloc({required AuthenticationRepository authRepo})
      : _authRepo = authRepo,
        super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<UserNameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  _onUsernameChanged(UserNameChanged event, Emitter emit) {
    var isvalid = false;
    if (event.userName.isNotEmpty && state.password.isNotEmpty) {
      isvalid = true;
    }
    emit(state.copyWith(isValid: isvalid, userName: event.userName));
  }

  _onPasswordChanged(PasswordChanged event, Emitter emit) {
    var isvalid = false;
    if (event.password.isNotEmpty && state.userName.isNotEmpty) {
      isvalid = true;
    }
    emit(state.copyWith(isValid: isvalid, userName: event.password));
  }


  _onLoginSubmitted(LoginSubmitted event, Emitter emit) async {
    try {
      if (state.isValid) {
        await _authRepo.logIn(
            username: state.userName, password: state.password);

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    }
    catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
