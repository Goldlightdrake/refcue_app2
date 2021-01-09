part of 'edit_profile_data_cubit.dart';

class EditProfileDataState extends Equatable {
  const EditProfileDataState({
    this.newName = const NameInput.pure(),
    this.newEmail = const Email.pure(),
    this.status = FormzStatus.pure,
    this.password = const Password.pure(),
  });

  final NameInput newName;
  final Email newEmail;
  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [newName, newEmail, status, password];

  EditProfileDataState copyWith({
    NameInput newName,
    Email newEmail,
    FormzStatus status,
    Password password,
  }) {
    return EditProfileDataState(
      newName: newName ?? this.newName,
      newEmail: newEmail ?? this.newEmail,
      status: status ?? this.status,
      password: password ?? this.password,
    );
  }
}
