import 'package:flutter_bloc/flutter_bloc.dart';

class YellowCardCubit extends Cubit<int> {
  YellowCardCubit() : super(0);

  void addYellowCard() {
    emit(state + 1);
  }

  void removeYellowCard() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void clearCards() {
    emit(0);
  }
}

class RedCardCubit extends Cubit<int> {
  RedCardCubit() : super(0);

  void addRedCard() {
    emit(state + 1);
  }

  void removeRedCard() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void clearCards() {
    emit(0);
  }
}
