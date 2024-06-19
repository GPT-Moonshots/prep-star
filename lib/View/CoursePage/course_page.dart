import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepstar/Controller/controller.dart';
import 'package:prepstar/Model/course_model.dart';
import 'package:prepstar/Service/Database/course.dart';

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
    return await CourseDatabase.getCourse(courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Course Page'),
        ),
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.courseName),
                      Text(snapshot.data!.courseDescription),
                      Text(snapshot.data!.totalQuestions.toString()),
                      ElevatedButton(
                          onPressed: () {
                            context.goNamed('Questions',
                                pathParameters: {'courseId': widget.courseId},
                                extra: snapshot.data!.questions);
                          },
                          child: const Text('Start Course')),
                      ElevatedButton(
                        onPressed: () async {
                          String? userId = await AppController.getUid();
                          await CourseDatabase.buyCourse(
                              widget.courseId, userId);
                        },
                        child: const Text('Own Course'),
                      ),
                    ],
                  ),
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
