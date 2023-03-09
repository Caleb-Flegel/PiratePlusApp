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

      body: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        color: Colors.grey[300],
        child: Column (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [

                    Container(
                      color: Colors.red[700],
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Text(
                          '*Inspirational Quote*',
                          style: TextStyle(
                            fontFamily: 'Questrial',
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                      ),
                    ),

                    Image.asset(
                      'images/ExampleSelfie.jpg',
                      height: 500,
                    ),

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
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          color: Colors.red[600],
                          child: Text(
                            '*Upcoming event*',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.red[700],
                  child: Row(
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
                ),
              ]
          ),
      ),
    );
  }
}

