class CourseModel {
  String courseId;
  String courseName;
  String courseDescription;
  String? courseImageUrl;
  int totalQuestions;
  List questions;

  CourseModel({
    required this.courseId,
    required this.courseName,
    required this.courseDescription,
    required this.courseImageUrl,
    required this.totalQuestions,
    required this.questions,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
        courseId: json['courseId'],
        courseName: json['courseName'],
        courseDescription: json['courseDescription'],
        courseImageUrl: json['courseImageUrl'],
        totalQuestions: json['totalQuestions'],
        questions: json['questions']);
  }

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
