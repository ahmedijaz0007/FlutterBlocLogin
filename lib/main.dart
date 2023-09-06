import 'package:bloclogin/logic/authentication_bloc.dart';
import 'package:bloclogin/packages/authentication/lib/authentication_repository.dart';
import 'package:bloclogin/packages/user_repository/lib/src/user_repository.dart';
import 'package:bloclogin/presentation/home.dart';
import 'package:bloclogin/presentation/login.dart';
import 'package:bloclogin/presentation/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
       RepositoryProvider(create: (_)=> UserRepository() ),
       RepositoryProvider(create: (_)=> AuthenticationRepository())
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(authRepo: RepositoryProvider.of<AuthenticationRepository>(context), userRepo: RepositoryProvider.of<UserRepository>(context)),
        child:AppView()
      ),
    );
  }
}

class AppView extends StatefulWidget{
  @override
  State<AppView> createState() => AppViewState();
}

class AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<
      NavigatorState>(); //global key to acces navigator
  NavigatorState get _navigator =>
      _navigatorKey.currentState ?? NavigatorState();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: _navigatorKey,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    HomePage.route(),
                        (route) => false,
                  );
                case AuthenticationStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                        (route) => false,
                  );
                default:
                  break;
              }
            },
            child: child,
          );
        },
        onGenerateRoute: (_) => SplashPage.route(),
    );
  }

}