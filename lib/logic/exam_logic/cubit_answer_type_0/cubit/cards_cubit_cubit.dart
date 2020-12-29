import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cards_cubit_state.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit() : super(CardsState(yellowCards: 0, redCards: 0));

  void setYellowCards(int value) {
    emit(state.copyWith(yellowCards: value));
  }

  void setRedCards(int value) {
    emit(state.copyWith(redCards: value));
  }

  void addYellowCard() {
    emit(state.copyWith(yellowCards: state.yellowCards + 1));
  }

  void addRedCard() {
    emit(state.copyWith(redCards: state.redCards + 1));
  }

  void removeYellowCard() {
    if (state.yellowCards > 0) {
      emit(state.copyWith(yellowCards: state.yellowCards - 1));
    }
  }

  void removeRedCard() {
    if (state.redCards > 0) {
      emit(state.copyWith(redCards: state.redCards - 1));
    }
  }

  void clearCards() {
    emit(CardsState(yellowCards: 0, redCards: 0));
  }
}
