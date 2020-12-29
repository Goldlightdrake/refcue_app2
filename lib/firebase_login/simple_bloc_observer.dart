import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_login/logic/exam_logic/bloc_timer/timer_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    if (bloc is! TimerBloc) {
      print(event);
    }
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    if (cubit is! TimerBloc) {
      print(change);
    }
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (bloc is! TimerBloc) {
      print(transition);
    }
    super.onTransition(bloc, transition);
  }
}
