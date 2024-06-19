import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prepstar/Model/course_model.dart';
import 'package:prepstar/Model/user_courses_model.dart';
import 'package:uuid/uuid.dart';

class CourseDatabase {
  // GetCourse from firebase
  static Future<CourseModel?> getCourse(String courseId) async {
    try {
      CourseModel? course;
      await FirebaseFirestore.instance
          .collection('JEE')
          .doc(courseId)
          .get()
          .then((value) {
        course = CourseModel.fromJson(value.data()!);
      });
      return course!;
    } catch (e) {
      print('Error: $e');
      return null;
    }
    // return Future.delayed(const Duration(seconds: 1)).then((value) {
    //   return CourseModel(
    //       courseId: '123456789',
    //       courseName: 'Course 1',
    //       courseDescription: 'The is a demo course',
    //       courseImageUrl: '123456789',
    //       totalQuestions: 3,
    //       questions: ['Question 1', 'Question 2', 'Question 3']);
    // });
  }

  // BuyCourse from firebase
  static Future<bool> buyCourse(String courseId, String userId) async {
    UserCoursesModel userCourse;
    try {
      CourseModel? course = await getCourse(courseId);
      userCourse = UserCoursesModel.fromCourseModel(course!);
    } catch (e) {
      print('Error: $e');
      return false;
    }
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('Courses')
          .doc(courseId)
          .set(userCourse.toJson());
      print('Course bought successfully!');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // GetCourses from firebase
  static Future<List<CourseModel>> getCourses() async {
    try {
      List<CourseModel> courses = [];
      await FirebaseFirestore.instance.collection('JEE').get().then((value) {
        value.docs.forEach((element) {
          courses.add(CourseModel.fromJson(element.data()));
        });
      });
      return courses;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  // GetCoursesByUser from firebase
  static Future<List<CourseModel>> getCoursesByUser(String userId) async {
    try {
      List<CourseModel> courses = [];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) {
        value.data()!['courses'].forEach((element) async {
          await getCourse(element).then((value) {
            courses.add(value!);
          });
        });
      });
      return courses;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  //uploadCourse to firebase
  static Future<void> uploadCourse() async {
    try {
      List<List<Map<String, dynamic>>> data = [];
      int k = 0;
      for (var element in data) {
        List<String> questions = [];
        for (var question in element) {
          // Generate a unique ID for each question
          String questionId = Uuid().v4();
          questions.add(questionId);

          // Create a modifiable copy of the question map and add the questionId
          Map<String, dynamic> modifiableQuestion =
              Map<String, dynamic>.from(question);
          modifiableQuestion['questionId'] = questionId;

          // Upload each question with its unique ID
          await FirebaseFirestore.instance
              .collection('questions')
              .doc(questionId)
              .set(modifiableQuestion);
        }

        // Generate a course ID
        String courseId = Uuid().v4();

        // Create a reference to the 'JEE' collection with the courseId as the document ID
        DocumentReference docRef =
            FirebaseFirestore.instance.collection('JEE').doc(courseId);

        // Set the document with the course details
        await docRef.set({
          'courseId': courseId,
          'courseName': 'Chemistry${k++}',
          'courseDescription': 'This is a Chemistry course',
          'totalQuestions': element.length,
          'questions': questions,
        });
      }
      print('Course uploaded successfully!');
    } catch (e) {
      print('Error: $e');
    }
  }
}
