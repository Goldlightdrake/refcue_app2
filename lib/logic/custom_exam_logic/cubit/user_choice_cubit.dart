import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';

part 'user_choice_state.dart';

class UserChoiceCubit extends Cubit<UserChoiceTaken> {
  UserChoiceCubit()
      : super(UserChoiceTaken(
            articles: List.generate(17, (index) => false), time: 0));

  void chooseArticle(int article) {
    List<bool> changedList = List.from(state.articles);
    changedList[article] = !state.articles[article];
    emit(state.copyWith(articles: changedList, time: state.time));
  }

  void chooseTime(int time) {
    emit(state.copyWith(articles: state.articles, time: time));
  }

  void submitCustoming() {
    if (state.articles.contains(true) && state.time != 0) {}
  }
}
