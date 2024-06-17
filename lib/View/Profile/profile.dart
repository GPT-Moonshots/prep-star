import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prepstar/Model/question_model.dart';
import 'package:prepstar/Model/user_model.dart';
import 'package:prepstar/Service/Database/user.dart';

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
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userModel!.profilePic == ''
                          ? 'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'
                          : userModel.profilePic),
                    ),
                    Column(
                      children: [
                        Text(userModel.username),
                        Text(userModel.email),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.green,
                          value: userModel.questionsSolved.length.toDouble(),
                          title:
                              'Solved ${userModel.questionsSolved.length} questions',
                        ),
                        PieChartSectionData(
                          color: Colors.red,
                          value: userModel.totalQuestionsAttempted.toDouble(),
                          title:
                              'Attempted ${userModel.totalQuestionsAttempted} questions',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
