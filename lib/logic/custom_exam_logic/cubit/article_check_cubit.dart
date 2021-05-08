import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


class ArticleCheckCubit extends Cubit<List<bool>> {
  ArticleCheckCubit() : super(List.generate(17, (index) => false));

  void chooseArticle(int index){
    // final editedList = state.
  }
}
