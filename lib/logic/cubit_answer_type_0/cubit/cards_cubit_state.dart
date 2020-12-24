part of 'cards_cubit_cubit.dart';

class CardsState extends Equatable {
  final int yellowCards;
  final int redCards;
  CardsState({
    this.yellowCards,
    this.redCards,
  });

  CardsState copyWith({
    int yellowCards,
    int redCards,
  }) {
    return CardsState(
      yellowCards: yellowCards ?? this.yellowCards,
      redCards: redCards ?? this.redCards,
    );
  }

  @override
  List<Object> get props => [yellowCards, redCards];
}
