import 'package:bloc/bloc.dart';
import 'package:refcue_app/data/repositories/user_stats_repo.dart';
import 'package:equatable/equatable.dart';

part 'user_stats_state.dart';

class UserStatsCubit extends Cubit<UserStatsState> {
  UserStatsCubit({required UserStatsRepository userStatsRepository})
      : _userStatsRepository = userStatsRepository,
        super(UserStatsInitial());

  final UserStatsRepository _userStatsRepository;

  void createUserData() {
    try {
      _userStatsRepository.addUserToStatsDatabase();
    } catch (e) {
      emit(UserStatsError());
      throw (e);
    }
  }
}
