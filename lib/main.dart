import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    home: basic(),
));

class basic extends StatelessWidget {
  const basic({Key? key}) : super(key: key);

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
        title: Text("PiratePlus"),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        color: Colors.redAccent[100],
        child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [

                    Image.asset('images/IMG_20181006_204914.jpg'),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text (
                            '*Date Taken*',
                            style: TextStyle(
                              fontFamily: 'Questrial',
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              color: Colors.red[700],
                            ),
                          ),
                        ]
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      color: Colors.blueGrey[200],
                      child: Text('This is an upcoming event or something'),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          print('Go get a ride');
                        },
                        child: Text(
                          'Rideshare',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.red[700],
                      ),
                      MaterialButton(
                        onPressed: () {
                          print('See your favorite events');
                        },
                        child: Text(
                          'Events',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.grey,
                      ),
                      MaterialButton(
                        onPressed: () {
                          print('Food recommendations');
                        },
                        child: Text(
                          'Food',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.red[700],
                      ),
                      MaterialButton(
                        onPressed: () {
                          print('Check in on yourself');
                        },
                        child: Text(
                          'Mental Health',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.grey,
                      ),
                    ]
                ),
              ]
          ),
      ),
    );
  }
}

