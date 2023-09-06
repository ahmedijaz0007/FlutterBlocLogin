part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable{
   AuthenticationStatus? status;
   User? user;
   @override
   List<Object?> get props => [user,status];
}

class AuthenticationUnknown extends AuthenticationState {
  AuthenticationUnknown(){
    status = AuthenticationStatus.unknown;
  }
}


class Authenticated extends AuthenticationState{
  Authenticated(User user){
    status = AuthenticationStatus.authenticated;
    user = user;
  }
}

class UnAuthenticated extends AuthenticationState{
  UnAuthenticated(){
    status = AuthenticationStatus.unauthenticated;
  }
}


//logged in
//logged out
//unknown  (Default/Initial State, bloc doesn't yet know whether the current user is authenticated or not