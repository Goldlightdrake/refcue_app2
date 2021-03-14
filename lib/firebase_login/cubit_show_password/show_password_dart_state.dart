part of 'show_password_dart_cubit.dart';

class VisibilityPasswordState extends Equatable {
  final bool showPassword;
  VisibilityPasswordState({
    required this.showPassword,
  });

  @override
  List<Object> get props => [showPassword];

  VisibilityPasswordState copyWith({
    bool? showPassword,
  }) {
    return VisibilityPasswordState(
      showPassword: showPassword ?? this.showPassword,
    );
  }
}
