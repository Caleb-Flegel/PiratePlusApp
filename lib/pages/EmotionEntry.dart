import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pirate_plus/pages/emotionQuestion.dart';
import '../models/mysql.dart';
import '../widgets/appBar.dart';
import '../Classes/report.dart';

class emotionSelect extends StatefulWidget {
  const emotionSelect({Key? key, this.curReport, this.camera}) : super(key: key);

  static const routeName = "/report/emotionEntry";
  final report? curReport;
  final CameraDescription? camera;

  @override
  State<emotionSelect> createState() => _emotionSelectState();
}

class _emotionSelectState extends State<emotionSelect> {

  String recentResult = '';

  Future<void> goToQuestion(String emotion, BuildContext context) async {
    widget.curReport?.emotion = emotion;
    await Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return Question(curReport: widget.curReport, camera: widget.camera,);
      })
    );
    widget.curReport?.question = null;
    widget.curReport?.emotion = null;
    print("Reset curReport");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pirate Plus"),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "How are you feeling?",
            style: TextStyle(fontSize: 36),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  goToQuestion('Relaxed', context);
                },
                child: Column(
                    children: [
                      Icon(Icons.brightness_low_outlined,
                        color: Colors.amber,
                        size: 120.0,
                      ),
                      Text('Relaxed',
                        style: TextStyle (fontSize: 24.0, color: Colors.black),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () {
                  goToQuestion('Happy', context);
                },
                child: Column(
                    children: [
                      Icon(Icons.emoji_emotions_outlined,
                        color: Colors.yellow,
                        size: 120.0,
                      ),
                      Text('Happy',
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () {
                  goToQuestion('Excited', context);
                },
                child: Column(
                  children: [
                    Icon(Icons.emoji_nature_outlined,
                      color: Colors.lime,
                      size: 120.0,
                    ),
                    Text('Excited',
                      style: TextStyle(fontSize: 24.0, color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  goToQuestion('Drained', context);
                },
                child: Column(
                    children: [
                      Icon(Icons.battery_1_bar_outlined,
                        color: Colors.blueGrey,
                        size: 120.0,
                      ),
                      Text('Drained',
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () {
                  goToQuestion('Neutral', context);
                },
                child: Column(
                    children: [
                      Icon(Icons.thumbs_up_down_outlined,
                        color: Colors.grey,
                        size: 120.0,
                      ),
                      Text('Calm',
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () {
                  goToQuestion('Stressed', context);
                },
                child: Column(
                  children: [
                    Icon(Icons.alarm_add_outlined,
                        color: Colors.indigoAccent,
                        size: 120.0
                    ),
                    Text('Stressed',
                      style: TextStyle(fontSize: 24.0, color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  goToQuestion('Depressed', context);
                },
                child: Column(
                    children: [
                      Icon(Icons.anchor_outlined,
                          color: Colors.teal,
                          size: 120.0
                      ),
                      Text('Depressed',
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () {
                  goToQuestion('Sad', context);
                },
                child: Column(
                    children: [
                      Icon(Icons.mood_bad_outlined,
                        color: Colors.cyan,
                        size: 120.0,
                      ),
                      Text('Sad',
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () {
                  goToQuestion('Angry', context);
                },
                child: Column(
                  children: [
                    Icon(Icons.volcano_outlined,
                      color: Colors.redAccent,
                      size: 120.0,
                    ),
                    Text('Angry',
                      style: TextStyle(fontSize: 24.0, color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
