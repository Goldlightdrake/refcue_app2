import 'dart:convert';

import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String answer;
  final List article;
  final String questionText;
  final String substantiation;
  final int type;
  final int id;
  Question({
    required this.answer,
    required this.article,
    required this.questionText,
    required this.substantiation,
    required this.type,
    required this.id,
  });

  @override
  List<Object> get props =>
      [answer, article, questionText, substantiation, type, id];

  String toString() =>
      'Question ## type: {$type}, article: {$article}, id: {$id}, questionText: {$questionText}, answer: {$answer}, substantiation: {$substantiation}';

  Map<String, dynamic> toMap() {
    return {
      'answer': answer,
      'article': article,
      'questionText': questionText,
      'substantiation': substantiation,
      'type': type,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  factory Question.fromMap(Map<dynamic, dynamic> map) {
    return Question(
      answer: map['answer'],
      article: List.from(map['article']),
      questionText: map['questionText'],
      substantiation: map['substantiation'],
      type: map['type'],
      id: map['id'],
    );
  }
}
