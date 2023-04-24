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
                      Text('relaxed',
                        style: TextStyle (fontSize: 24.0, color: Colors.black),
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
                      Text('happy',
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () async {
                  curReport.emotion = 'excited';
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
                    Text('excited',
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
                onPressed: () async {
                  curReport.emotion = 'drained';
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
                      Text('drained',
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                      ),
                    ]
                ),
              ),
              TextButton(
                onPressed: () async {
                  curReport.emotion = 'calm';
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
                      Text('calm',
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
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
                    Text('stressed',
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
                      Text('depressed',
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
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
                      Text('sad',
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
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
                    Text('angry',
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
