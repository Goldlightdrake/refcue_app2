import 'package:bloc/bloc.dart';
import 'package:refcue_app/logic/exam_logic/bloc_timer/timer_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    if (bloc is! TimerBloc) {
      print(event);
    }
    super.onEvent(bloc, event);
  }

  @override
  void onError(Bloc cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (bloc is! TimerBloc) {
      print(transition);
    }
    super.onTransition(bloc, transition);
  }
}
