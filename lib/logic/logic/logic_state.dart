part of 'logic_bloc.dart';

@immutable
final class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final String password;
  final String userName;
  final bool isValid;

  const LoginState({
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.password = "",
    this.userName = ""
  });

  LoginState copyWith({
    FormzSubmissionStatus? status,
    String? userName,
    String? password,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }


  @override

  List<Object?> get props => [status,userName,password];

}


