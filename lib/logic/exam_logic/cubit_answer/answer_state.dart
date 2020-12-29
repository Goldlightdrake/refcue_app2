part of 'answer_cubit.dart';

abstract class AnswerState extends Equatable {
  const AnswerState();

  @override
  List<Object> get props => [];
}

class AnswerInitial extends AnswerState {}

class AnswerPicked extends AnswerState {
  final String answer;
  AnswerPicked({
    this.answer,
  });
  String toString() => '{AnswerPicked: $answer}';

  AnswerPicked copyWith({
    String answer,
  }) {
    return AnswerPicked(
      answer: answer ?? this.answer,
    );
  }

  @override
  List<Object> get props => [answer];
}
