import 'package:flutter/material.dart';
import 'package:prepstar/View/HomePage/Widgets/course_corousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),
      body: Column(
        children: [
          Container(
            // color: Colors.green,
            child: const Column(
              children: [
                Text(
                  'Announcements:',
                  style: TextStyle(fontSize: 25),
                ),
                CourseCorousel(
                  extent: 300,
                  height: 180,
                ),
                Text(
                  'Popular Courses:',
                  style: TextStyle(fontSize: 25),
                ),
                CourseCorousel(
                  extent: 150,
                  height: 200,
                ),
                Text(
                  'All Courses:',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text('Course $index'),
                        tileColor: Colors.blue,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
