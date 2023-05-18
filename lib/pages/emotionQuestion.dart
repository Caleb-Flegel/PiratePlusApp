import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pirate_plus/Classes/session.dart';
import 'package:pirate_plus/pages/GPTEmotionRepsonse.dart';
import 'package:pirate_plus/pages/reportPicture.dart';
import '../Classes/report.dart';
import 'Account.dart';

class Question extends StatefulWidget {
  const Question({Key? key, this.curSession, this.camera}) : super(key: key);

  static const routeName = "/report/emotionQuestion";
  final CameraDescription? camera;
  final Session? curSession;

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  String questionTxt = "Loading...";

  @override
  void initState() {
    super.initState();
    print(widget.camera);
    setQuestion();
  }

  Future<void> setQuestion() async {
    print ("setting question");
    await widget.curSession?.curReport!.getQuestion(widget.curSession?.db).then((question) {
      print("got question");
      setState(() {
        questionTxt = question!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emotionQuestion = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nexus"),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
              Color.fromARGB(255, 106, 229, 198),
              Colors.cyan.shade700
            ]))),
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
              ]),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Answer some questions about your emotion!',
                style: TextStyle(
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '(If you\'d like)',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 40.0),
              Text(
                questionTxt,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: emotionQuestion,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type here...',
                ),
              ),
              SizedBox(height: 100.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[700],
                ),
                onPressed: () async {
                  widget.curSession?.curReport?.answer = emotionQuestion.text;
                  if (widget.curSession?.curReport?.answer == "") {
                    widget.curSession?.curReport?.answer = null;
                  }
                  await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return reportPicture(
                      curSession: widget.curSession,
                      camera: widget.camera,
                    );
                  }));
                },
                child: Text(
                  "Next ->",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
