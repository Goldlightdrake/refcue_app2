import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/data/repositories/test_repo.dart';
import 'package:flutter_firebase_login/logic/bloc/exam_bloc.dart';

class ExamScreen extends StatefulWidget {
  static Route route({int amountQuestions}) {
    return MaterialPageRoute<void>(
        builder: (_) => ExamScreen(
              amount: amountQuestions,
            ));
  }

  final int amount;
  TestRepository _testRepository;
  ExamScreen({Key key, this.amount}) : super(key: key);

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  void initState() {
    super.initState();
    widget._testRepository = TestRepository(amountOfQuestions: widget.amount);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExamBloc(testRepository: widget._testRepository)..add(ExamFetched()),
      child: BlocBuilder<ExamBloc, ExamState>(
        builder: (context, state) {
          if (state is ExamLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ExamReady) {
            return Center(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    Text(state.questionList[index].article),
                itemCount: state.questionList.length,
              ),
            );
          }
        },
      ),
    );
  }
}
