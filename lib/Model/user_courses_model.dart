import 'package:prepstar/Model/course_model.dart';

class UserCoursesModel extends CourseModel {
  final int totalQuestionsSolved;
  final List<String> questionsSolved;
  UserCoursesModel(
      {this.totalQuestionsSolved = 0,
      this.questionsSolved = const [],
      required super.courseId,
      required super.courseName,
      required super.courseDescription,
      required super.courseImageUrl,
      required super.totalQuestions,
      required super.questions});

  //usercoursemodel from coursemodel
  factory UserCoursesModel.fromCourseModel(CourseModel course) {
    return UserCoursesModel(
        totalQuestionsSolved: 0,
        courseId: course.courseId,
        courseName: course.courseName,
        courseDescription: course.courseDescription,
        courseImageUrl: course.courseImageUrl,
        totalQuestions: course.totalQuestions,
        questions: course.questions);
  }

  factory UserCoursesModel.fromJson(Map<String, dynamic> json) {
    return UserCoursesModel(
        courseId: json['courseId'],
        courseName: json['courseName'],
        courseDescription: json['courseDescription'],
        courseImageUrl: json['courseImageUrl'],
        totalQuestions: json['totalQuestions'],
        questions: json['questions']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'courseName': courseName,
      'courseDescription': courseDescription,
      'courseImageUrl': courseImageUrl,
      'totalQuestions': totalQuestions,
      'questions': questions,
    };
  }
}
