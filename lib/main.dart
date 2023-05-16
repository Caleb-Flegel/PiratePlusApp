import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pirate_plus/pages/reportPicture.dart';
import 'package:pirate_plus/Classes/report.dart';
import 'package:pirate_plus/Classes/session.dart';
import 'models/mysql.dart';
import 'package:pirate_plus/pages/results.dart';
import 'package:pirate_plus/pages/EmotionEntry.dart';
import 'package:pirate_plus/pages/emotionQuestion.dart';
import 'package:pirate_plus/pages/GPTEmotionRepsonse.dart';
import 'package:pirate_plus/pages/login.dart';
import 'package:pirate_plus/pages/Account.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    theme: ThemeData.light(),
    initialRoute: '/login',
    routes: {
      '/': (context) => basic(),
      '/login': (context) => login(),
      '/account': (context) => AccountViewer(),
      '/report/reports': (context) => results(),
      '/report/emotionEntry': (context) => emotionSelect(),
      '/report/emotionQuestion': (context) => Question(),
      '/report/reportPicture': (context) => reportPicture(),
      '/report/gptResponse': (context) => gptResponse(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

class basic extends StatefulWidget {
  const basic({Key? key, this.curSession}) : super(key: key);

  final Session? curSession;

  @override
  State<basic> createState() => _basicState();
}

class _basicState extends State<basic> {

  late CameraDescription camera;

  var results = "See Most Recent Report";

  List QuoteSelection = ["null", "null"];

   @override
  void initState() {
    super.initState();
    setQuote();
    widget.curSession?.curReport?.date = DateTime.now();
    setCameras();
  }

  Future<void> setCameras() async {
    final cameras = await availableCameras();
    camera = cameras.last;
    print(camera);
  }

  Future<void> setQuote() async {
    widget.curSession?.getQuote().then((quote) {
      print("gotQuote");
      setState(() {
        QuoteSelection = quote;
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
                  "${widget.curSession?.firstname}"
              ),
              Text(
                  " ${widget.curSession?.lastname}"
              ),
            ]
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return AccountViewer(curSession: widget.curSession,);
                })
                );
              },
              icon: Icon(
                  Icons.person,
              ),
          ),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                    "Welcome, ${widget.curSession?.firstname}!",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 50,),

              Expanded(
                flex: 16,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Colors.cyan.shade700,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QuoteSelection[0] == "null"?
                        CircularProgressIndicator()
                          :
                        Text(
                            "${QuoteSelection [0]}\n~${QuoteSelection [1]}",
                          style: TextStyle(
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 50,),

              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                      return emotionSelect(camera: camera, curSession: widget.curSession,);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

