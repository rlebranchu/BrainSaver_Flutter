import 'package:brain_saver_flutter/repositories/auth_repository.dart';
import 'package:brain_saver_flutter/views/screens/signup/cubit/signup_cubit.dart';
import 'package:brain_saver_flutter/views/screens/signup/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const SignupScreen());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('SIGNUP')),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocProvider(
                  create: (_) => SignupCubit(
                    context.read<AuthRepository>(),
                  ),
                  child: const SignupForm(),
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
