import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  final List<String> questions;
  const Questions({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
      ),
      body: SafeArea(
        child: Center(
          child: PageView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return Center(
                child: Text('Question ${index + 1}'),
              );
            },
          ),
        ),
      ),
    );
  }
}
