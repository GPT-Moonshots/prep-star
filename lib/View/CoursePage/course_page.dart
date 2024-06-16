import 'package:flutter/material.dart';
import 'package:prepstar/Model/course_model.dart';

class CoursePage extends StatefulWidget {
  final String courseId;
  const CoursePage({super.key, required this.courseId});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  void initState() {
    fetchCourseData(widget.courseId);
    super.initState();
  }

  Future<CourseModel?> fetchCourseData(String courseId) async {
    CourseModel course =
        await Future.delayed(const Duration(seconds: 2)).then((value) {
      return CourseModel(
          courseId: '123456789',
          courseName: 'Course 1',
          courseDescription: 'The is a demo course',
          courseImageUrl: '123456789',
          totalQuestions: 3,
          questions: []);
    });
    return course;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.courseId);
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder<CourseModel?>(
        future: fetchCourseData(widget.courseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Text(snapshot.data!.courseName),
                Text(snapshot.data!.courseDescription),
                Text(snapshot.data!.totalQuestions.toString()),
              ],
            );
          } else {
            return const Center(
              child: Text('No data found'),
            );
          }
        },
      ),
    ));
  }
}
