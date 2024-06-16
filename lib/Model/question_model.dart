import 'package:prepstar/Model/option_model.dart';

class QuestionModel {
  String questionId;
  String question;
  String? imageUrl;
  List<OptionModel> options;

  QuestionModel({
    required this.questionId,
    required this.question,
    this.imageUrl,
    required this.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      questionId: json['questionId'],
      question: json['question'],
      imageUrl: json['imageUrl'],
      options: (json['options'] as List)
          .map((e) => OptionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'question': question,
      'imageUrl': imageUrl,
      'options': options.map((e) => e.toJson()).toList(),
    };
  }
}