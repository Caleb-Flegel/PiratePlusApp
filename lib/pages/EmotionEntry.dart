import 'package:flutter/material.dart';
import 'package:pirate_plus/pages/emotionQuestion.dart';
import '../models/mysql.dart';
import '../widgets/appBar.dart';
import '../Classes/report.dart';

class emotionSelect extends StatefulWidget {
  const emotionSelect({Key? key}) : super(key: key);
  static const routeName = "/report/emotionEntry";
  @override
  State<emotionSelect> createState() => _emotionSelectState();
}

class _emotionSelectState extends State<emotionSelect> {

  var db = mySql();
  var curReport = report(mySql(), 1);

  String recentResult = '';

  getRecentResult(){
    db.getConnection().then((conn) {
      String sql = 'Select uid, emotion From mhreports order by uid desc;';
      conn.query(sql).then((reports) {
        print (reports.first);
        return reports.first[1].toString();
        for (var row in reports.first) {
          print(row[1]);
          return row[1];
        }
      });
    });
  }

  void storeReports(emotion){
    db.getConnection().then((conn) {
      String sql = 'Insert into mhreports (`emotion`, `userUid`) ';
      sql += 'values (?, 1)';
      conn.query(sql, [emotion]).then((results) {
        for(var row in results) {
          print("Reported: " + row[1]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
        children: [
          Text(
            "Enter an Emotion:",
            style: TextStyle(fontSize: 36),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  curReport.emotion = 'Relaxed';
                  await Navigator.pushNamed(
                      context,
                      Question.routeName,
                      arguments: curReport
                  );
                  curReport.emotion = null;
                  curReport.question = null;
                },
                child: Column(
                    children: [
                      Icon(Icons.brightness_low_outlined,
                        color: Colors.amber,
                        size: 120.0,
                      ),
                      Text('Relaxed',
                        style: TextStyle (fontSize: 24.0),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () async {
                  curReport.emotion = 'Happy';
                  await Navigator.pushNamed(
                      context,
                      Question.routeName,
                      arguments: curReport
                  );
                  curReport.emotion = null;
                  curReport.question = null;
                },
                child: Column(
                    children: [
                      Icon(Icons.emoji_emotions_outlined,
                        color: Colors.yellow,
                        size: 120.0,
                      ),
                      Text('Happy',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () async {
                  curReport.emotion = 'Excited';
                  await Navigator.pushNamed(
                      context,
                      Question.routeName,
                      arguments: curReport
                  );
                  curReport.emotion = null;
                  curReport.question = null;
                },
                child: Column(
                  children: [
                    Icon(Icons.emoji_nature_outlined,
                      color: Colors.lime,
                      size: 120.0,
                    ),
                    Text('Excited',
                      style: TextStyle(fontSize: 24.0),
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
                onPressed: () async {
                  curReport.emotion = 'Drained';
                  await Navigator.pushNamed(
                      context,
                      Question.routeName,
                      arguments: curReport
                  );
                  curReport.emotion = null;
                  curReport.question = null;
                },
                child: Column(
                    children: [
                      Icon(Icons.battery_1_bar_outlined,
                        color: Colors.blueGrey,
                        size: 120.0,
                      ),
                      Text('Drained',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () async {
                  curReport.emotion = 'Neutral';
                  await Navigator.pushNamed(
                      context,
                      Question.routeName,
                      arguments: curReport
                  );
                  curReport.emotion = null;
                  curReport.question = null;
                },
                child: Column(
                    children: [
                      Icon(Icons.thumbs_up_down_outlined,
                        color: Colors.grey,
                        size: 120.0,
                      ),
                      Text('Neutral',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () async {
                  curReport.emotion = 'Stressed';
                  await Navigator.pushNamed(
                      context,
                      Question.routeName,
                      arguments: curReport
                  );
                  curReport.emotion = null;
                  curReport.question = null;
                },
                child: Column(
                  children: [
                    Icon(Icons.alarm_add_outlined,
                        color: Colors.indigoAccent,
                        size: 120.0
                    ),
                    Text('Stressed',
                      style: TextStyle(fontSize: 24.0),
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
                onPressed: () async {
                  curReport.emotion = 'Depressed';
                  await Navigator.pushNamed(
                      context,
                      Question.routeName,
                      arguments: curReport
                  );
                  curReport.emotion = null;
                  curReport.question = null;
                },
                child: Column(
                    children: [
                      Icon(Icons.anchor_outlined,
                          color: Colors.teal,
                          size: 120.0
                      ),
                      Text('Depressed',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () async {
                  curReport.emotion = 'Sad';
                  await Navigator.pushNamed(
                      context,
                      Question.routeName,
                      arguments: curReport
                  );
                  curReport.emotion = null;
                  curReport.question = null;
                },
                child: Column(
                    children: [
                      Icon(Icons.mood_bad_outlined,
                        color: Colors.cyan,
                        size: 120.0,
                      ),
                      Text('Sad',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () async {
                  curReport.emotion = 'Angry';
                  await Navigator.pushNamed(
                      context,
                      Question.routeName,
                      arguments: curReport
                  );
                  curReport.emotion = null;
                  curReport.question = null;
                },
                child: Column(
                  children: [
                    Icon(Icons.volcano_outlined,
                      color: Colors.redAccent,
                      size: 120.0,
                    ),
                    Text('Angry',
                      style: TextStyle(fontSize: 24.0),
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
