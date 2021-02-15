import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'custom_exam_state.dart';

class CustomExamCubit extends Cubit<CustomExamState> {
  CustomExamCubit() : super(CustomExamInitial());
}
