//File will handle the chatGPT emotion reponse
import 'package:flutter/material.dart';
import 'package:pirate_plus/Classes/session.dart';
import '../Classes/report.dart';
import '../Classes/GPT.dart';
import 'Account.dart';

class gptResponse extends StatefulWidget {
  const gptResponse({Key? key, this.curSession}) : super(key: key);

  final Session? curSession;
  static const routeName = '/report/gptResponse';

  @override
  State<gptResponse> createState() => _gptResponseState();
}

class _gptResponseState extends State<gptResponse> {
  String? gptResponse = "Loading...";

  var submitReport = false;

  @override
  void initState() {
    print(widget.curSession?.curReport?.emotion);
    GPT gpt = GPT();

    super.initState();

    if (widget.curSession?.curReport?.answer == null) {
      setState(() {
        gptResponse = "Question not answered!";
      });
    } else {
      gpt.getResponse(widget.curSession?.curReport).then((value) {
        setState(() {
          gptResponse = widget.curSession?.curReport?.response ;
        });
      });
    }
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
                        "$gptResponse",
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
                    (submitReport == false) ?
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan.shade700),
                        onPressed: () {
                          print(widget.curSession?.curReport?.answer);
                          widget.curSession?.curReport?.submitReport(widget.curSession?.db, widget.curSession?.userID).then((value) => {
                            setState(() {
                              submitReport = true;
                            })
                          });
                        },
                        child: Text('Submit',
                            style: TextStyle(fontWeight: FontWeight.bold)))
                    :
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade800),
                        onPressed: () {},
                        child: Text('Report Submitted',
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
