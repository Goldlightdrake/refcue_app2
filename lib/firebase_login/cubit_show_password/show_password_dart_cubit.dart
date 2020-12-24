import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'show_password_dart_state.dart';

class VisibilityPasswordCubit extends Cubit<VisibilityPasswordState> {
  VisibilityPasswordCubit()
      : super(VisibilityPasswordState(showPassword: false));

  void showPassword() {
    emit(state.copyWith(showPassword: true));
  }

  void hidePassword() {
    emit(state.copyWith(showPassword: false));
  }
}
