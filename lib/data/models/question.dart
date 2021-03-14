import 'dart:convert';

import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String answer;
  final String article;
  final String questionText;
  final String substantiation;
  final int type;
  Question({
    required this.answer,
    required this.article,
    required this.questionText,
    required this.substantiation,
    required this.type,
  });

  @override
  List<Object> get props =>
      [answer, article, questionText, substantiation, type];

  String toString() =>
      'Question ## type: {$type}, article: {$article}, questionText: {$questionText}, answer: {$answer}, substantiation: {$substantiation}';

  Map<String, dynamic> toMap() {
    return {
      'answer': answer,
      'article': article,
      'questionText': questionText,
      'substantiation': substantiation,
      'type': type,
    };
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  factory Question.fromMap(Map map) {
    return Question(
      answer: map['answer'],
      article: map['article'],
      questionText: map['questionText'],
      substantiation: map['substantiation'],
      type: map['type'],
    );
  }
}
