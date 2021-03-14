import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:refcue_app/data/shared_preference/user_preference.dart';

import 'package:refcue_app/shared/const.dart';
import 'package:refcue_app/ui/screens/splash/view/init_screen.dart';

import 'firebase_login/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: UserSharedPreference.getThemeDataPrefs(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return ThemeProvider(
                initTheme: snapshot.data! ? kLightTheme : kDarkTheme,
                child: Builder(builder: (context) {
                  return MaterialApp(
                    title: 'RefCue',
                    home: InitScreenPage(
                        authenticationRepository: AuthenticationRepository()),
                    debugShowCheckedModeBanner: false,
                  );
                }));
          }
          return Container();
        });
  }
}
