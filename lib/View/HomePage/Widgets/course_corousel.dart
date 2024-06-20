import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:prepstar/Model/course_model.dart';
import 'package:prepstar/Service/Database/course.dart';

class CourseCorousel extends StatefulWidget {
  final double extent;
  final double height;
  final bool owned;
  const CourseCorousel(
      {super.key,
      required this.extent,
      required this.height,
      this.owned = false});

  @override
  State<CourseCorousel> createState() => _CourseCorouselState();
}

class _CourseCorouselState extends State<CourseCorousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: !widget.owned ? widget.height : null,
      child: FutureBuilder(
        future: !widget.owned
            ? CourseDatabase.getCourses()
            : CourseDatabase.getCoursesByUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching courses!'),
            );
          }
          List<CourseModel> courses = snapshot.data as List<CourseModel>;
          return courses.isNotEmpty
              ? InfiniteCarousel.builder(
                  itemCount: courses.length,
                  itemExtent: widget.extent,
                  center: true,
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          String courseId = courses[index].courseId;
                          context.goNamed("CoursePage",
                              pathParameters: {'courseId': courseId});
                        },
                        child: Container(
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              courses[index].courseName,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : const Column(
                  children: [
                    Text('No course owned yet'),
                  ],
                );
        },
      ),
    );
  }
}
