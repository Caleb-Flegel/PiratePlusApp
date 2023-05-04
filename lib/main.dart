import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pirate_plus/pages/reportPicture.dart';
import 'package:pirate_plus/Classes/report.dart';
import 'models/mysql.dart';
import 'package:pirate_plus/pages/results.dart';
import 'package:pirate_plus/pages/EmotionEntry.dart';
import 'package:pirate_plus/pages/emotionQuestion.dart';
import 'package:pirate_plus/pages/GPTEmotionRepsonse.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final camera = cameras.first;

  runApp(MaterialApp(
    theme: ThemeData.dark(),
    routes: {
      '/': (context) => basic(camera: camera),
      '/results': (context) => results(),
      '/report/emotionEntry': (context) => emotionSelect(camera: camera),
      '/report/emotionQuestion': (context) => Question(camera: camera),
      '/report/reportPicture': (context) => reportPicture(camera: camera),
      '/report/gptResponse': (context) => gptResponse(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

class basic extends StatefulWidget {
  const basic({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  State<basic> createState() => _basicState();
}

class _basicState extends State<basic> {
  var db = mySql();
  var curReport = report(mySql(), 1);

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
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return emotionSelect(camera: widget.camera, curReport: curReport,);
                })
                );
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

