import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/firebase_login/authentication/authentication.dart';
import 'package:flutter_firebase_login/firebase_login/login/login.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_firebase_login/ui/screens/account/view/menu/new_password_screen.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_screenutil/size_extension.dart';

class ProfileDataView extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProfileDataView());
  }

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
          _NameInput(),
          _EmailInput(),
          _NewpasswordButton(),
        ],
      )),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: user.email,
            key: const Key('loginForm_emailInput_textField'),
            onChanged: null,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey),
              labelText: 'E-mail',
              helperText: '',
              errorText: state.email.invalid ? 'Błędny format email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: user.name,
            key: const Key('nameForm_nameInput_textField'),
            onChanged: null,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey),
              labelText: 'Imię i nazwisko',
              helperText: '',
            ),
          ),
        );
      },
    );
  }
}

class _NewpasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      key: const Key('nameform_newpassword_button'),
      child: Text(
        'Zmień hasło',
      ),
      onPressed: () =>
          Navigator.of(context).push<void>(NewPasswordScreen.route()),
    );
  }
}
