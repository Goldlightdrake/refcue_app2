part of 'show_password_dart_cubit.dart';

abstract class ShowPasswordState extends Equatable {
  const ShowPasswordState();

  @override
  List<Object> get props => [];
}

class DontShowPassword extends ShowPasswordState {}

class ShowPassword extends ShowPasswordState {}
