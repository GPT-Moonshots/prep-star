import 'package:flutter/material.dart';
import 'package:prepstar/Model/option_model.dart';
import 'package:prepstar/Model/question_model.dart';
import 'package:prepstar/Service/Database/questions.dart';
import 'package:prepstar/View/CoursePage/Questions/question_page.dart';

class Questions extends StatefulWidget {
  final List questions;

  const Questions({super.key, required this.questions});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  final PageController controller = PageController();
  OptionModel? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
      ),
      body: SafeArea(
        child: Center(
          child: PageView.builder(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.questions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2,
                  child: FutureBuilder(
                    future:
                        QuestionsDatabase.getQuestion(widget.questions[index]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        QuestionModel? question =
                            snapshot.data as QuestionModel;
                        return QuestionPage(
                            question: question,
                            questionNumber: index + 1,
                            controller: controller);
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
