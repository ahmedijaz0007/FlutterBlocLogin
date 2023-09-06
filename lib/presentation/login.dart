import 'package:bloclogin/logic/logic/logic_bloc.dart';
import 'package:bloclogin/packages/authentication/lib/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          authRepo: RepositoryProvider.of<AuthenticationRepository>(context)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Username',
                      errorText: context.watch<LoginBloc>().state.isValid
                          ? null
                          : 'Invalid Username',
                    ),
                    onChanged: (value) {
                      context.read<LoginBloc>().add(UserNameChanged(userName: value));
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      errorText: context.watch<LoginBloc>().state.isValid
                          ? null
                          : 'Invalid Password',
                    ),
                    onChanged: (value) {
                      context.read<LoginBloc>().add(PasswordChanged(password: value));
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
