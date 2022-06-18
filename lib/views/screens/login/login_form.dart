import 'package:brain_saver_flutter/views/components/components.dart';
import 'package:brain_saver_flutter/views/screens/login/cubit/login_cubit.dart';
import 'package:brain_saver_flutter/views/screens/screens.dart';
import 'package:brain_saver_flutter/views/theme/style_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          // Do something if error on login
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png', width: 200, height: 200),
          const SizedBox(height: 8),
          Text('BRAIN SAVER', style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 20),
          _EmailInput(),
          const SizedBox(height: 13),
          _PasswordInput(),
          const SizedBox(height: 26),
          _LoginButton(),
          const SizedBox(height: 13),
          _SignUpButton()
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormFieldApp(
            label: 'Identifiant',
            onChange: (email) {
              context.read<LoginCubit>().emailChanged(email);
            },
            icon: Icons.person,
            obscureText: false,
            enableSuggestions: false);
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormFieldApp(
            label: 'Password',
            onChange: (password) {
              context.read<LoginCubit>().passwordChanged(password);
            },
            icon: Icons.lock,
            obscureText: true,
            enableSuggestions: false);
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submitting
            ? const CircularProgressIndicator(
                color: PRIMARYCOLOR,
              )
            : ElevatedButtonValidation(
                onPressed: () {
                  context.read<LoginCubit>().logInWithCredentials();
                },
                child: const Text('LOGIN'),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push<void>(
        SignupScreen.route(),
      ),
      child: const Text(
        "SIGN UP",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
