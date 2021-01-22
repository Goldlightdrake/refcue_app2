part of 'user_stats_cubit.dart';

abstract class UserStatsState extends Equatable {
  const UserStatsState();

  @override
  List<Object> get props => [];
}

class UserStatsInitial extends UserStatsState {}

class UserStatsError extends UserStatsState {}
