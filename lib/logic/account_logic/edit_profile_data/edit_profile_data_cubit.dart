import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:formz/formz.dart';

import 'package:flutter_firebase_login/firebase_login/authentication/models/models.dart';

part 'edit_profile_data_state.dart';

class EditProfileDataCubit extends Cubit<EditProfileDataState> {
  EditProfileDataCubit(
    this.user,
  )   : assert(user != null),
        super(EditProfileDataState());

  final auth.User user;

  void initialData(String name, String email) {
    final initName = NameInput.dirty(name);
    final initEmail = Email.dirty(email);
    emit(
      state.copyWith(
        newName: initName,
        newEmail: initEmail,
        status: Formz.validate(
          [initName, initEmail, state.password],
        ),
      ),
    );
  }

  void newNameChanged(String value) {
    final newName = NameInput.dirty(value);
    emit(state.copyWith(
      newName: newName,
      status: Formz.validate([newName, state.newEmail, state.password]),
    ));
  }

  void newEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    emit(state.copyWith(
      newEmail: newEmail,
      status: Formz.validate([state.newName, newEmail, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.newEmail, state.newName, password]),
    ));
  }

  Future<void> changeUsersData() async {
    if (!state.status.isValidated) return;
    if (user.email == state.newEmail.value &&
        user.displayName == state.newName.value) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      if (user.email != state.newEmail.value) {
        var credential = auth.EmailAuthProvider.credential(
          email: user.email,
          password: state.password.value,
        );
        await user.reauthenticateWithCredential(credential).then((value) => user
                .verifyBeforeUpdateEmail(state.newEmail.value)
                .catchError((error) {
              print(error);
              emit(state.copyWith(status: FormzStatus.submissionFailure));
            }));
      }
      if (user.displayName != state.newName.value) {
        await user.updateProfile(displayName: state.newName.value);
      }
      await user.reload();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
