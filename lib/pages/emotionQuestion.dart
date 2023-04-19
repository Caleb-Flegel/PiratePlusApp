import 'package:flutter/material.dart';
import 'package:pirate_plus/pages/GPTEmotionRepsonse.dart';
import '../Classes/report.dart';

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);
  static const routeName = "/report/emotionQuestion";
  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  String? temp = 'Loading...';

  @override
  Widget build(BuildContext context) {

    report curReport = ModalRoute.of(context)!.settings.arguments as report;
    if (curReport.question == null) {
      curReport.getQuestion().then((value) {
        setState(() {
          temp = curReport.question;
        });
      });
    }
    else {
      setState(() {
        temp = curReport.question;
      });
    }

    TextEditingController emotionQuestion = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pirate "),
            Image.asset(
              "images/WhitworthUniversity-logo.png",
              height: 30,
            ),
            Text(" Plus"),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.red[700],
        elevation: 0,

        actions: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    "User"
                ),
                Text(
                    " Name"
                ),
              ]
          ),
          IconButton(
            onPressed: () {print("Go edit user settings");},
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Answer some questions about your feeling!'),
          Text('(If you\'d like)'),

          Text('$temp'),

          TextField(
            controller: emotionQuestion,
            maxLines: null,
          ),

          ElevatedButton(
            onPressed: () async {
              curReport.emotion = 'Relaxed';
              await Navigator.pushNamed(
                  context,
                  gptResponse.routeName,
                  arguments: curReport
              );
            },
              child: Text("Next ->"),
          ),
        ],
      ),
    );
  }
}
