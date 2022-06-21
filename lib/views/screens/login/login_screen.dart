import 'package:brain_saver_flutter/views/screens/login/cubit/login_cubit.dart';
import 'package:brain_saver_flutter/repositories/auth_repository.dart';
import 'package:brain_saver_flutter/views/screens/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    // GestureDetector to detect all click on background to hide keyboard
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('LOGIN')),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocProvider(
                  create: (_) => LoginCubit(
                    context.read<AuthRepository>(),
                  ),
                  child: const LoginForm(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
