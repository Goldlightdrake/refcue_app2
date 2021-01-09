part of 'new_password_cubit.dart';

class NewPasswordState extends Equatable {
  const NewPasswordState({
    this.oldPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final Password oldPassword;
  final Password newPassword;
  final FormzStatus status;

  @override
  List<Object> get props => [oldPassword, newPassword, status];

  NewPasswordState copyWith({
    Password oldPassword,
    Password newPassword,
    FormzStatus status,
  }) {
    return NewPasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      status: status ?? this.status,
    );
  }
}
