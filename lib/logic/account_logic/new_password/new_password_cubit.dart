import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:formz/formz.dart';

import 'package:refcue_app/firebase_login/authentication/models/models.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit(
    this.user,
  ) : super(NewPasswordState());

  final auth.User user;

  void oldPasswordChanged(String value) {
    final oldPassword = Password.dirty(value);
    emit(state.copyWith(
      oldPassword: oldPassword,
      status: Formz.validate([oldPassword, state.newPassword]),
    ));
  }

  void newPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    emit(state.copyWith(
      newPassword: newPassword,
      status: Formz.validate([state.oldPassword, newPassword]),
    ));
  }

  Future<void> changePassword() async {
    if (!state.status.isValidated) return;
    if (state.oldPassword.value == state.newPassword.value) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var credential = auth.EmailAuthProvider.credential(
        email: user.email!,
        password: state.oldPassword.value,
      );
      await user.reauthenticateWithCredential(credential).then((_) {
        user.updatePassword(state.newPassword.value);
      }).catchError((error) {
        throw (error);
      });
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
