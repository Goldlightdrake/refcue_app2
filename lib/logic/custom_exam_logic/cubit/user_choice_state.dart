part of 'user_choice_cubit.dart';

class UserChoiceTaken {
  final List<bool> articles;
  final int time;
  UserChoiceTaken({
    required this.articles,
    required this.time,
  });

  UserChoiceTaken copyWith({
    List<bool>? articles,
    int? time,
  }) {
    return UserChoiceTaken(
      articles: articles ?? this.articles,
      time: time ?? this.time,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserChoiceTaken &&
        listEquals(other.articles, articles) &&
        other.time == time;
  }

  @override
  int get hashCode => articles.hashCode ^ time.hashCode;
}
