import 'package:flutter/material.dart';
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
    '/report/gptResponse': (context) => gptResponse(),
    //'/report/pictureEntry': (context) => ,
  },
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

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/report/emotionEntry');
              },
              color: Colors.grey[400],
              child: Text(
                  'Enter an emotion'
              ),
            ),
            MaterialButton(
              onPressed: (){
                setState(() {
                  results = "You are def seeing results";
                });
              },
              color: Colors.grey[400],
              child: Text(
                  results
              ),
            ),
          ],
        ),
      ),
    );
  }
}

