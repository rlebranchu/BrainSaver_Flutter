import 'package:brain_saver_flutter/views/components/components.dart';
import 'package:brain_saver_flutter/views/screens/signup/cubit/signup_cubit.dart';
import 'package:brain_saver_flutter/views/theme/style_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Form to allow sign up to user of application
class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Container of differents element of sign up form
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo_signup.png', width: 200, height: 200),
        const SizedBox(height: 8),
        Text('BRAIN SAVER', style: Theme.of(context).textTheme.headline1),
        const SizedBox(height: 20),
        _EmailInput(),
        const SizedBox(height: 13),
        _PasswordInput(),
        const SizedBox(height: 26),
        _SignUpButton(),
      ],
    );
  }
}

// Emil Input
class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      // Refresh only if email of state has changed
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        // Use Custom TextFormFieldApp for email
        return TextFormFieldApp(
            label: 'Identifiant',
            onChange: (email) {
              context.read<SignupCubit>().emailChanged(email);
            },
            icon: Icons.person,
            obscureText: false,
            enableSuggestions: false);
      },
    );
  }
}

// Password Input
class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      // Refresh only if password of state has changed
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        // Use Custom TextFormFieldApp to password with obscure options
        return TextFormFieldApp(
            label: 'Password',
            onChange: (password) {
              context.read<SignupCubit>().passwordChanged(password);
            },
            icon: Icons.lock,
            obscureText: true,
            enableSuggestions: false);
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      // Refresh only if status of state has changed
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == SignupStatus.submitting
            ? const CircularProgressIndicator(
                color: PRIMARYCOLOR,
              )
            : ElevatedButtonValidation(
                onPressed: () {
                  context.read<SignupCubit>().signupFormSubmitted();
                },
                child: const Text('SIGNUP'),
              );
      },
    );
  }
}
