//File will handle the chatGPT emotion reponse
import 'package:flutter/material.dart';
import '../Classes/report.dart';
import '../Classes/GPT.dart';

class gptResponse extends StatefulWidget {
  const gptResponse({Key? key, this.curReport}) : super(key: key);

  final report? curReport;
  static const routeName = '/report/gptResponse';

  @override
  State<gptResponse> createState() => _gptResponseState();
}

class _gptResponseState extends State<gptResponse> {
  String gptResponse = "Loading...";

  @override
  void initState() {
    print(widget.curReport?.emotion);
    GPT gpt = GPT();

    super.initState();

    if (widget.curReport?.answer == null) {
      setState(() {
        gptResponse = "Question not answered!";
      });
    } else {
      gpt.getResponse(widget.curReport).then((value) {
        setState(() {
          gptResponse = widget.curReport!.response!;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var temp = "";

    return Scaffold(
      appBar: AppBar(
        title: Text("Pirate Plus"),
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
                Text("User"),
                Text(" Name"),
              ]),
          IconButton(
            onPressed: () {
              print("Go edit user settings");
            },
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                  child: Text(
                      'GPT Response',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
              ),
              Expanded(
                flex: 7,
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
                  child: SingleChildScrollView(
                    child: Text(
                        gptResponse,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan.shade700),
                        onPressed: () {
                          print(widget.curReport?.answer);
                          widget.curReport?.submitReport();
                        },
                        child: Text('Submit',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent[400]),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: Text('Go Home',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
