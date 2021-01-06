import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/firebase_login/cubit_show_password/show_password_dart_cubit.dart';
import 'package:formz/formz.dart';
import 'package:flutter_firebase_login/logic/account_logic/cubit/new_password_cubit.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class NewPasswordScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NewPasswordScreen());
  }

  const NewPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth.User user = auth.FirebaseAuth.instance.currentUser;
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);
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
      create: (context) => NewPasswordCubit(user),
      child: Scaffold(
        body: BlocListener<NewPasswordCubit, NewPasswordState>(
          listener: (context, state) async {
            if (state.status.isSubmissionFailure) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                      content: Text(
                    'Podano złe hasło konta',
                    textAlign: TextAlign.center,
                  )),
                );
            }
            if (state.status.isSubmissionSuccess) {
              Future.delayed(Duration(seconds: 1));
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
              SizedBox(height: kSpacingUnit.w * 13),
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
                return FlatButton(
                    color: kAccentColor,
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
                      child: Icon(passwordVisibilty
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Stare hasło',
                    helperText: '',
                    errorText: state.oldPassword.invalid
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
                      child: Icon(passwordVisibilty
                          ? Icons.visibility_off
                          : Icons.visibility),
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
