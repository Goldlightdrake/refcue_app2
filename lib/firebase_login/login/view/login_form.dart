import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:refcue_app/firebase_login/cubit_show_password/show_password_dart_cubit.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:formz/formz.dart';
import '../login.dart';
import 'package:refcue_app/firebase_login/sign_up/sign_up.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  backgroundColor: Theme.of(context).backgroundColor,
                  content: Text('Podano zły e-mail lub hasło',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.bodyText1!.color))),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ThemeProvider.of(context)!.brightness == Brightness.dark
                    ? logoDarkPath
                    : logoPath,
                height: 84,
              ),
              const SizedBox(height: 24.0),
              _EmailInput(),
              const SizedBox(height: 10.0),
              _PasswordInput(),
              const SizedBox(height: 10.0),
              _LoginButton(),
              const SizedBox(height: 10.0),
              _GoogleLoginButton(),
              const SizedBox(height: 4.0),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? kAccentColor : Colors.grey),
            labelText: 'E-mail',
            helperText: '',
            errorText: state.email.invalid ? 'Błędny format email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();
    return BlocProvider(
        create: (context) => VisibilityPasswordCubit(),
        child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) =>
              previous.password != current.password,
          builder: (context, state) {
            return Builder(builder: (context) {
              final passwordVisibilty =
                  context.watch<VisibilityPasswordCubit>().state.showPassword;
              return TextField(
                key: const Key('loginForm_passwordInput_textField'),
                onChanged: (password) =>
                    context.read<LoginCubit>().passwordChanged(password),
                obscureText: !passwordVisibilty,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () => passwordVisibilty
                        ? context.read<VisibilityPasswordCubit>().hidePassword()
                        : context
                            .read<VisibilityPasswordCubit>()
                            .showPassword(),
                    child: Icon(
                      passwordVisibilty
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? kAccentColor : Colors.grey),
                  labelText: 'Hasło',
                  helperText: '',
                  errorText: state.password.invalid
                      ? 'Hasło musi posiadać co najmniej 8 znaków, w tym 1 wielką\n literę i 1 cyfre oraz 1 znak specjalny!'
                      : null,
                ),
              );
            });
          },
        ));
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child:
                    const Text('Zaloguj się!', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoogleAuthButton(
      text: 'Użyj konta google',
      style: AuthButtonStyle(
        borderRadius: 12.0,
      ),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      darkMode: Theme.of(context).brightness == Brightness.dark ? true : false,
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      child: Text('Nie masz konta?  Zarejestruj się!',
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
    );
  }
}
