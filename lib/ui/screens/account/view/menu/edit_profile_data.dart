import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:refcue_app/firebase_login/authentication/bloc/authentication_bloc.dart';
import 'package:refcue_app/firebase_login/cubit_show_password/show_password_dart_cubit.dart';
import 'package:refcue_app/logic/account_logic/edit_profile_data/edit_profile_data_cubit.dart';
import 'package:refcue_app/shared/const.dart';

class EditProfileScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => EditProfileScreen());
  }

  const EditProfileScreen({Key key}) : super(key: key);

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
      create: (context) => EditProfileDataCubit(user)
        ..initialData(
            user.displayName != null ? user.displayName : 'Imię Nazwisko',
            user.email),
      child: Scaffold(
        body: BlocListener<EditProfileDataCubit, EditProfileDataState>(
          listener: (context, state) async {
            if (state.status.isSubmissionSuccess) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                      content: Text(
                    'Zweryfikuj nowego maila, wchodząc na poczte',
                    textAlign: TextAlign.center,
                  )),
                );
            }
            if (state.status.isSubmissionFailure) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                      content: Text(
                    'Coś poszło nie tak :( Spróbuj zrestartować aplikacje!',
                    textAlign: TextAlign.center,
                  )),
                );
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: kSpacingUnit.w * 5),
              header,
              Text('Zmień dane',
                  style:
                      kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 2)),
              SizedBox(height: kSpacingUnit.w * 7),
              _NameInput(),
              _EmailInput(),
              _PasswordInput(),
              BlocBuilder<EditProfileDataCubit, EditProfileDataState>(
                  builder: (context, state) {
                if (state.status.isSubmissionInProgress) {
                  return CircularProgressIndicator();
                }
                if (state.status.isSubmissionSuccess) {
                  return Icon(Icons.check, color: Colors.green);
                }
                return FlatButton(
                    color: kAccentColor,
                    onPressed: () async {
                      await context
                          .read<EditProfileDataCubit>()
                          .changeUsersData();
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

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<EditProfileDataCubit, EditProfileDataState>(
      buildWhen: (previous, current) => previous.newName != current.newName,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: user.name != null ? user.name : 'Imię Nazwisko',
            key: const Key('nameForm_nameInput_textField'),
            onChanged: (newName) =>
                context.read<EditProfileDataCubit>().newNameChanged(newName),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey),
              labelText: 'Imię i nazwisko',
              helperText: '',
              errorText: state.newName.invalid ? 'Podano zły format' : null,
            ),
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<EditProfileDataCubit, EditProfileDataState>(
      buildWhen: (previous, current) => previous.newEmail != current.newEmail,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: user.email,
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (newEmail) =>
                context.read<EditProfileDataCubit>().newEmailChanged(newEmail),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey),
              labelText: 'E-mail',
              helperText: '',
              errorText: state.newEmail.invalid ? 'Błędny format email' : null,
            ),
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
        child: BlocBuilder<EditProfileDataCubit, EditProfileDataState>(
          buildWhen: (previous, current) =>
              previous.password != current.password,
          builder: (context, state) {
            return Builder(builder: (context) {
              final passwordVisibilty =
                  context.watch<VisibilityPasswordCubit>().state.showPassword;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  key: const Key('PasswordInput_passwordInput_textField'),
                  onChanged: (password) => context
                      .read<EditProfileDataCubit>()
                      .passwordChanged(password),
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
                    labelText: 'Hasło',
                    helperText: '',
                    errorText: state.password.invalid
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
