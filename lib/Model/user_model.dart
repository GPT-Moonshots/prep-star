import 'package:prepstar/Model/course_model.dart';
import 'package:prepstar/Model/question_model.dart';

class UserModel {
  String username;
  String email;
  String uid;
  int currStreak;
  int longestStreak;
  int totalPoints;
  int totalQuestionsSolved;
  int averageTimePerQuestion;
  int totalQuestionsAttempted;
  int rank;
  List<QuestionModel> questionsAttempted;
  List<QuestionModel> questionsSolved;
  List<QuestionModel> questionsUnsolved;
  List<CourseModel> courses;

  UserModel({
    required this.email,
    required this.uid,
    this.username = "",
    this.currStreak = 0,
    this.longestStreak = 0,
    this.totalPoints = 0,
    this.totalQuestionsSolved = 0,
    this.averageTimePerQuestion = 0,
    this.totalQuestionsAttempted = 0,
    this.rank = -1,
    this.questionsAttempted = const [],
    this.questionsSolved = const [],
    this.questionsUnsolved = const [],
    this.courses = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'uid': uid,
      'currStreak': currStreak,
      'longestStreak': longestStreak,
      'totalPoints': totalPoints,
      'totalQuestionsSolved': totalQuestionsSolved,
      'averageTimePerQuestion': averageTimePerQuestion,
      'totalQuestionsAttempted': totalQuestionsAttempted,
      'rank': rank,
      'questionsAttempted': questionsAttempted.map((e) => e.toJson()).toList(),
      'questionsSolved': questionsSolved.map((e) => e.toJson()).toList(),
      'questionsUnsolved': questionsUnsolved.map((e) => e.toJson()).toList(),
      'courses': courses.map((e) => e.toJson()).toList(),
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : username = map['username'],
        email = map['email'],
        uid = map['uid'],
        currStreak = map['currStreak'],
        longestStreak = map['longestStreak'],
        totalPoints = map['totalPoints'],
        totalQuestionsSolved = map['totalQuestionsSolved'],
        averageTimePerQuestion = map['averageTimePerQuestion'],
        totalQuestionsAttempted = map['totalQuestionsAttempted'],
        rank = map['rank'],
        questionsAttempted = List<QuestionModel>.from(
          map['questionsAttempted'].map((e) => QuestionModel.fromJson(e)),
        ),
        questionsSolved = List<QuestionModel>.from(
          map['questionsSolved'].map((e) => QuestionModel.fromJson(e)),
        ),
        questionsUnsolved = List<QuestionModel>.from(
          map['questionsUnsolved'].map((e) => QuestionModel.fromJson(e)),
        ),
        courses = List<CourseModel>.from(
          map['courses'].map((e) => CourseModel.fromJson(e)),
        );
}
