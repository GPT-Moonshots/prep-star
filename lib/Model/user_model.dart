import 'package:prepstar/Model/course_model.dart';
import 'package:prepstar/Model/question_model.dart';

class UserModel {
  String username;
  String email;
  String profilePic;
  String uid;
  int currStreak;
  int longestStreak;
  int totalPoints;
  int totalQuestionsSolved;
  int averageTimePerQuestion;
  int totalQuestionsAttempted;
  List<QuestionModel> questionsAttempted;
  List<QuestionModel> questionsSolved;
  List<QuestionModel> questionsUnsolved;
  List<CourseModel> courses;

  UserModel({
    required this.email,
    required this.uid,
    this.username = "",
    this.profilePic = "",
    this.currStreak = 0,
    this.longestStreak = 0,
    this.totalPoints = 0,
    this.totalQuestionsSolved = 0,
    this.averageTimePerQuestion = 0,
    this.totalQuestionsAttempted = 0,
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
      'profilePic': profilePic,
      'currStreak': currStreak,
      'longestStreak': longestStreak,
      'totalPoints': totalPoints,
      'totalQuestionsSolved': totalQuestionsSolved,
      'averageTimePerQuestion': averageTimePerQuestion,
      'totalQuestionsAttempted': totalQuestionsAttempted,
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
        profilePic = map['profilePic'],
        currStreak = map['currStreak'],
        longestStreak = map['longestStreak'],
        totalPoints = map['totalPoints'],
        totalQuestionsSolved = map['totalQuestionsSolved'],
        averageTimePerQuestion = map['averageTimePerQuestion'],
        totalQuestionsAttempted = map['totalQuestionsAttempted'],
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
