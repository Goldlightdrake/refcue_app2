import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refcue_app/firebase_login/cubit_show_password/show_password_dart_cubit.dart';
import 'package:refcue_app/logic/account_logic/new_password/new_password_cubit.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:formz/formz.dart';

class NewPasswordScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NewPasswordScreen());
  }

  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth.User? user = auth.FirebaseAuth.instance.currentUser;
    var header = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: kSpacingUnit.w * 3),
          IconButton(
            onPressed: () => Navigator.of(context).pop<void>(),
            icon: Icon(LineAwesomeIcons.arrow_left),
            iconSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
          ),
        ]);

    return BlocProvider(
      create: (context) => NewPasswordCubit(user!),
      child: Scaffold(
        body: BlocListener<NewPasswordCubit, NewPasswordState>(
          listener: (context, state) async {
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                      content: Text(
                    'Podano złe hasło do konta',
                    textAlign: TextAlign.center,
                  )),
                );
            }
            if (state.status.isSubmissionSuccess) {
              await Future.delayed(Duration(seconds: 1));
              Navigator.of(context).pop<void>();
            }
          },
          child: Column(
            children: [
              SizedBox(height: kSpacingUnit.w * 5),
              header,
              Text('Zmień hasło',
                  style:
                      kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 2)),
              SizedBox(height: kSpacingUnit.w * 7),
              _OldPasswordInput(),
              _NewPasswordInput(),
              BlocBuilder<NewPasswordCubit, NewPasswordState>(
                  builder: (context, state) {
                if (state.status.isSubmissionInProgress) {
                  return CircularProgressIndicator();
                }
                if (state.status.isSubmissionSuccess) {
                  return Icon(Icons.check, color: Colors.green);
                }
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kAccentColor,
                    ),
                    onPressed: () {
                      context.read<NewPasswordCubit>().changePassword();
                    },
                    child: Text('Potwierdź',
                        style: TextStyle(color: Colors.black)));
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _OldPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => VisibilityPasswordCubit(),
        child: BlocBuilder<NewPasswordCubit, NewPasswordState>(
          buildWhen: (previous, current) =>
              previous.oldPassword != current.oldPassword,
          builder: (context, state) {
            return Builder(builder: (context) {
              final passwordVisibilty =
                  context.watch<VisibilityPasswordCubit>().state.showPassword;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  key: const Key('OldPasswordInput_passwordInput_textField'),
                  onChanged: (oldPassword) => context
                      .read<NewPasswordCubit>()
                      .oldPasswordChanged(oldPassword),
                  obscureText: !passwordVisibilty,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () => passwordVisibilty
                          ? context
                              .read<VisibilityPasswordCubit>()
                              .hidePassword()
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
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Stare hasło',
                    helperText: '',
                    errorText: state.oldPassword.invalid
                        ? 'Hasło musi posiadać co najmniej 8 znaków, w tym 1 wielką\n literę i 1 cyfre oraz 1 znak specjalny!'
                        : null,
                  ),
                ),
              );
            });
          },
        ));
  }
}

class _NewPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => VisibilityPasswordCubit(),
        child: BlocBuilder<NewPasswordCubit, NewPasswordState>(
          buildWhen: (previous, current) =>
              previous.newPassword != current.newPassword,
          builder: (context, state) {
            return Builder(builder: (context) {
              final passwordVisibilty =
                  context.watch<VisibilityPasswordCubit>().state.showPassword;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  key: const Key('newPasswordInput_passwordInput_textField'),
                  onChanged: (newPassword) => context
                      .read<NewPasswordCubit>()
                      .newPasswordChanged(newPassword),
                  obscureText: !passwordVisibilty,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () => passwordVisibilty
                          ? context
                              .read<VisibilityPasswordCubit>()
                              .hidePassword()
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
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Nowe hasło',
                    helperText: '',
                    errorText: state.newPassword.invalid
                        ? 'Podano zły format hasła'
                        : null,
                  ),
                ),
              );
            });
          },
        ));
  }
}
