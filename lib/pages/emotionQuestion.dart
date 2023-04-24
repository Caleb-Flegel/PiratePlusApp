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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color.fromARGB(255, 106, 229, 198), Colors.cyan.shade700]))
        ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50.0),
            Text('Answer some questions about your emotion!',
              style: TextStyle(
                fontSize: 24.0,
              ),
              textAlign: TextAlign.center,
            ),
            Text('(If you\'d like)',
              style: TextStyle(fontSize: 16.0)
            ),
            SizedBox(height: 40.0),
      
            Text('$temp',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.0),
            
      
            TextField(
              controller: emotionQuestion,
              maxLines: null,
              decoration: InputDecoration(
                
                border: OutlineInputBorder(),
                hintText: 'Type here...',
              ),
            ),
            SizedBox(height: 100.0),
      
            ElevatedButton(
              onPressed: () async {
                curReport.response = emotionQuestion.text;
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
      ),
    );
  }
}
