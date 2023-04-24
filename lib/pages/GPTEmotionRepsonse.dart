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
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                Color.fromARGB(255, 106, 229, 198),
                Colors.cyan.shade700
              ]))),
          elevation: 0,
          actions: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("User"),
                  Text(" Name"),
                ]),
            IconButton(
              onPressed: () {
                print("Go edit user settings");
              },
              icon: Icon(
                Icons.person,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('GPT Response'),
                SizedBox(height: 50.0),
              Text(
                "*Here is where an eventual gpt response would go for the prompt:\n'How would you help me if to the question ${curReport.question}, I answered ${curReport.response}?",
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 400.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan.shade700),
                  onPressed: () {
                    setState(() {
                      if (temp == '') {
                        curReport.submitReport().then((reportTxt) {
                          setState(() {
                            temp = reportTxt;
                          });
                        });
                      } else {}
                    });
                  },
                  child: Text('Submit', style: TextStyle(fontWeight: FontWeight.bold))
                  ),
              Text('$temp'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent[400]),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: Text('Go Home',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        )
    );
  }
}
