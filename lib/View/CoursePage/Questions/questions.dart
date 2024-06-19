import 'package:flutter/material.dart';
import 'package:prepstar/Model/option_model.dart';
import 'package:prepstar/Model/question_model.dart';
import 'package:prepstar/Service/Database/questions.dart';

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
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 2,
                      child: FutureBuilder(
                        future: QuestionsDatabase.getQuestion(
                            widget.questions[index]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.data == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            QuestionModel? question =
                                snapshot.data as QuestionModel;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Question $index. ${question.question}'),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: question.options.length,
                                      itemBuilder: (context, idx) {
                                        return ListTile(
                                          onTap: () {
                                            selected = question.options[idx];
                                          },
                                          title:
                                              Text(question.options[idx].name),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: selected == null
                          ? null
                          : () {
                              if (selected!.isCorrect) {
                                const SnackBar(content: Text('Correct ans'));
                              } else {
                                const SnackBar(content: Text('incorrect ans'));
                              }
                            },
                      child: const Text('Check'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Easing.linear);
                      },
                      child: const Text('Next'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Easing.linear);
                      },
                      child: const Text('prev'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
