import 'package:flutter/material.dart';
import 'package:prepstar/Model/question_model.dart';
import 'package:prepstar/Model/user_model.dart';
import 'package:prepstar/Service/Database/user.dart';
import 'package:prepstar/View/HomePage/Widgets/course_corousel.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserModel? userModel;
  @override
  void initState() {
    getUserDetais().then((value) {
      setState(() {
        userModel = value;
      });
    });
    super.initState();
  }

  Future<UserModel> getUserDetais() async {
    UserModel? userModel = await UserDatabase.getUser();
    print(userModel!.toMap());
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: FutureBuilder(
          future: getUserDetais(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            UserModel? userModel = snapshot.data;
            userModel?.totalQuestionsAttempted = 100;
            userModel?.questionsSolved = List.generate(
                50,
                (index) => QuestionModel(
                      question: 'Question $index',
                      options: [],
                      questionId: '',
                    ));
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(userModel!.profilePic ==
                                ''
                            ? 'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'
                            : userModel.profilePic),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Text(userModel.username),
                          Text(userModel.email),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Owned Courses',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CourseCorousel(
                        extent: 300,
                        height: 200,
                        // owned: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Material(
                            elevation: 5,
                            child: ListTile(
                              splashColor: Colors.blue.shade100,
                              onTap: () {},
                              title: const Text('Edit Profile'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Material(
                            elevation: 5,
                            child: ListTile(
                              splashColor: Colors.blue.shade100,
                              onTap: () {},
                              title: const Text('Privacy Policy'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Material(
                            elevation: 5,
                            child: ListTile(
                              splashColor: Colors.blue.shade100,
                              onTap: () {},
                              title: const Text('Log out'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Material(
                            elevation: 5,
                            child: ListTile(
                              splashColor: Colors.blue.shade100,
                              onTap: () {},
                              title: const Text('Delete Account'),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text('Made with love  by LogicLab'),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
