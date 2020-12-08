import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_firebase_login/ui/screens/splash/view/init_screen.dart';
import 'firebase_login/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: kDarkTheme,
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'Splash Screen',
            home: InitScreenPage(
                authenticationRepository: AuthenticationRepository()),
            debugShowCheckedModeBanner: false,
          );
        }));
  }
}
