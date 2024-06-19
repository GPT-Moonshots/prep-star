import 'package:flutter/material.dart';
import 'package:prepstar/Model/option_model.dart';
import 'package:prepstar/Model/question_model.dart';

class QuestionPage extends StatefulWidget {
  final int questionNumber;
  final PageController controller;
  final QuestionModel question;
  const QuestionPage(
      {super.key,
      required this.question,
      required this.questionNumber,
      required this.controller});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with AutomaticKeepAliveClientMixin {
  Color color = Colors.blue;
  OptionModel? selected;
  bool submitted = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Question ${widget.questionNumber}.',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.question.question),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: ListView.builder(
            itemCount: widget.question.options.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.question.options[index].name),
                onTap: () {
                  if (submitted) {
                    return;
                  }
                  setState(() {
                    selected = widget.question.options[index];
                  });
                },
                tileColor: selected == widget.question.options[index]
                    ? color
                    : Colors.white,
              );
            },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (selected == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select an option')));
                return;
              }
              if (selected!.isCorrect) {
                setState(() {
                  color = Colors.green;
                });
              } else {
                setState(() {
                  color = Colors.red;
                });
              }
              submitted = true;
            },
            child: const Text('Submit')),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                widget.controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: const Text('Next'),
            ),
            ElevatedButton(
                onPressed: () {
                  widget.controller.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                child: Text('Prev')),
          ],
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
