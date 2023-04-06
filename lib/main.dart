import 'package:flutter/material.dart';
import 'models/mysql.dart';

void main() => runApp(MaterialApp(
    home: basic(),
));

class basic extends StatefulWidget {
  const basic({Key? key}) : super(key: key);

  @override
  State<basic> createState() => _basicState();
}

class _basicState extends State<basic> {

  var db = mySql();

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
        backgroundColor: Colors.red[700],

        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: (){
                  storeReports('Relaxed');
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
                onPressed: (){
                  storeReports('Happy');
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
                onPressed: () {
                  storeReports('Excited');
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
                onPressed: (){
                  storeReports('Drained');
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
                onPressed: (){
                  storeReports('Neutral');
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
                onPressed: () {
                  storeReports('Stressed');
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
                onPressed: (){
                  storeReports('Depressed');
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
                onPressed: (){},
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
                onPressed: () {}, 
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

