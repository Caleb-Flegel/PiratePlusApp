//File will handle the chatGPT emotion reponse
import 'package:flutter/material.dart';
import '../Classes/report.dart';

class gptResponse extends StatefulWidget {
  static const routeName = '/report/gptResponse';
  @override
  State<gptResponse> createState() => _gptResponseState();
}

class _gptResponseState extends State<gptResponse> {
  @override
  Widget build(BuildContext context) {

    report curReport = ModalRoute.of(context)?.settings.arguments as report;

    var temp = "";

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Text('GPT Response'),

          Text("*Here is where an eventual gpt response would go for the prompt:\n'How would you help me if to the question ${curReport.question}, I answered ${curReport.response}?"),

          ElevatedButton(
              onPressed: (){
                setState(() {
                  curReport.submitReport().then((reportTxt) {
                    temp = reportTxt;
                  });
                });
              },
              child: Text('Submit Report')
          ),

          Text('$temp'),

          ElevatedButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('Go Home')
          ),
        ],
      ),
    );
  }
}
