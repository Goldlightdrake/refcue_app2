import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/firebase_login/cubit_show_password/show_password_dart_cubit.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:formz/formz.dart';
import 'package:flutter_firebase_login/firebase_login/sign_up/sign_up.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Rejestracja się nie powiodła')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ThemeProvider.of(context).brightness == Brightness.dark
                  ? logoDarkPath
                  : logoPath,
              height: 84,
            ),
            const SizedBox(height: 24.0),
            _EmailInput(),
            const SizedBox(height: 8.0),
            _PasswordInput(),
            const SizedBox(height: 8.0),
            _ConfirmPasswordInput(),
            const SizedBox(height: 8.0),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'Niepoprawny email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisibilityPasswordCubit(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return Builder(
            builder: (context) {
              final passwordVisibilty =
                  context.watch<VisibilityPasswordCubit>().state.showPassword;
              return TextField(
                key: const Key('signUpForm_passwordInput_textField'),
                onChanged: (password) =>
                    context.read<SignUpCubit>().passwordChanged(password),
                obscureText: !passwordVisibilty,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () => passwordVisibilty
                        ? context.read<VisibilityPasswordCubit>().hidePassword()
                        : context
                            .read<VisibilityPasswordCubit>()
                            .showPassword(),
                    child: Icon(passwordVisibilty
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  labelText: 'hasło',
                  helperText: '',
                  errorText:
                      state.password.invalid ? 'Niepoprawne hasło' : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisibilityPasswordCubit(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            previous.password != current.password ||
            previous.confirmedPassword != current.confirmedPassword,
        builder: (context, state) {
          return Builder(
            builder: (context) {
              final passwordVisibilty =
                  context.watch<VisibilityPasswordCubit>().state.showPassword;
              return TextField(
                key: const Key('signUpForm_confirmedPasswordInput_textField'),
                onChanged: (confirmPassword) => context
                    .read<SignUpCubit>()
                    .confirmedPasswordChanged(confirmPassword),
                obscureText: !passwordVisibilty,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () => passwordVisibilty
                        ? context.read<VisibilityPasswordCubit>().hidePassword()
                        : context
                            .read<VisibilityPasswordCubit>()
                            .showPassword(),
                    child: Icon(passwordVisibilty
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  labelText: 'powtórz hasło',
                  helperText: '',
                  errorText: state.confirmedPassword.invalid
                      ? 'Hasła do siebie nie pasują!'
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                child: const Text('Zarejestruj się!'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.orangeAccent,
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
              );
      },
    );
  }
}
