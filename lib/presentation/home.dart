import 'package:bloclogin/logic/authentication_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const Text("Welcome to Home"),
          const SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                 context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
              }, child: const Text('Logout'))

        ]),
      ),
    );
  }
}
