import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'show_password_dart_state.dart';

class ShowPasswordCubit extends Cubit<ShowPasswordState> {
  ShowPasswordCubit() : super(DontShowPassword());

  void showPassword() {
    emit(ShowPassword());
  }

  void hidePassword() {
    emit(DontShowPassword());
  }
}
