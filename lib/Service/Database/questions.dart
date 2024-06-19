import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prepstar/Model/question_model.dart';

class QuestionsDatabase {
  //getQuestions from  course
  static Future<QuestionModel?> getQuestion(String questionId) async {
    QuestionModel? question;
    try {
      await FirebaseFirestore.instance
          .collection('questions')
          .doc(questionId)
          .get()
          .then((value) {
        question = QuestionModel.fromJson(value.data()!);
      });
      return question!;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // create question
  static Future<bool> createQuestion(QuestionModel question) async {
    try {
      await FirebaseFirestore.instance
          .collection('questions')
          .doc(question.questionId)
          .set(question.toJson());
      print('Question created successfully!');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
