import 'package:flutter/material.dart';
import 'package:pirate_plus/pages/reportPicture.dart';
import 'models/mysql.dart';
import 'package:pirate_plus/pages/results.dart';
import 'package:pirate_plus/pages/EmotionEntry.dart';
import 'package:pirate_plus/pages/emotionQuestion.dart';
import 'package:pirate_plus/pages/GPTEmotionRepsonse.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => basic(),
    '/results': (context) => results(),
    '/report/emotionEntry': (context) => emotionSelect(),
    '/report/emotionQuestion': (context) => Question(),
    '/report/reportPicture': (context) => reportPicture(),
    '/report/gptResponse': (context) => gptResponse(),
  },
  debugShowCheckedModeBanner: false,
));

class basic extends StatefulWidget {
  const basic({Key? key}) : super(key: key);

  @override
  State<basic> createState() => _basicState();
}

class _basicState extends State<basic> {
  var results = "See Most Recent Report";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          onPressed: () {
            print('You opened the side menu!');
          },
          icon: Icon(
            Icons.menu,
          ),
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pirate Plus"),
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
              onPressed: () {},
              icon: Icon(
                  Icons.person,
              ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "Welcome!",
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/report/emotionEntry');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan[700],
              ),
              child: Text(
                  'Enter an emotion',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

