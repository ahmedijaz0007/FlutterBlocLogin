
import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated; // first time only send
    yield* _controller.stream; // send status when an event is added
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(   //check email and password through api
      const Duration(milliseconds: 300),
          () => _controller.add(AuthenticationStatus.authenticated),//send status as event is added
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}