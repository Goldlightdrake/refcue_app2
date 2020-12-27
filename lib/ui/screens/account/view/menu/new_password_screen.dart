import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/firebase_login/cubit_show_password/show_password_dart_cubit.dart';
import 'package:flutter_firebase_login/firebase_login/login/login.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class NewPasswordScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NewPasswordScreen());
  }

  const NewPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: kSpacingUnit.w * 5),
            header,
            SizedBox(height: kSpacingUnit.w * 9),
            _OldPasswordInput(),
            _NewPasswordInput(),
          ],
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
        child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) =>
              previous.password != current.password,
          builder: (context, state) {
            return Builder(builder: (context) {
              final passwordVisibilty =
                  context.watch<VisibilityPasswordCubit>().state.showPassword;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  key: const Key('OldPasswordInput_passwordInput_textField'),
                  onChanged: null,
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
                    errorText:
                        state.password.invalid ? 'Podano złe hasło' : null,
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
        child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) =>
              previous.password != current.password,
          builder: (context, state) {
            return Builder(builder: (context) {
              final passwordVisibilty =
                  context.watch<VisibilityPasswordCubit>().state.showPassword;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  key: const Key('newPasswordInput_passwordInput_textField'),
                  onChanged: null,
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
                    errorText:
                        state.password.invalid ? 'Podano złe hasło' : null,
                  ),
                ),
              );
            });
          },
        ));
  }
}
