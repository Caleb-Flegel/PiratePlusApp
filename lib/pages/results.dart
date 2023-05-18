import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pirate_plus/Classes/session.dart';
import 'package:pirate_plus/pages/Account.dart';
import 'package:pirate_plus/pages/reportPicture.dart';

class allReportList extends StatefulWidget {
  allReportList({Key? key, this.curSession}) : super(key: key);

  Session? curSession;

  @override
  State<allReportList> createState() => _allReportListState();
}

class _allReportListState extends State<allReportList> {
  List<Map>? reports = [];

  @override
  void initState() {
    super.initState();
    getReports();
  }

  Future<void> getReports () async {
    print("getting reports");

    List<Map>? temp = await widget.curSession?.getAllReports();
    setState(() {
      reports = temp;
    });

    print("got reports");
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
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
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
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 1,
                child: Center(
                    child: Text("Here are your reports:")
                )
            ),

            Expanded(
                flex: 9,
                child: reports!.isEmpty?
                Text("Nothing yet...")
                    :
                ListView.builder(
                  itemCount: reports?.length,
                  itemBuilder: (context, index){
                    return Card(
                        child: ListTile(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => indReport(
                                  reportID: reports?.elementAt(index)['uid'],
                                  curSession: widget.curSession,
                                ),
                              ),
                            );
                          },
                          title: Text("You felt ${reports?.elementAt(index)['emotion']} on ${reports?.elementAt(index)['date']}"),
                          subtitle: Text("Answered question: ${reports?.elementAt(index)['answer'] != null? "yes" : "no"}"),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.cyan.shade700, width: 1),
                            borderRadius: BorderRadius.circular(3)
                          ),
                        )
                    );
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}

class indReport extends StatefulWidget {
  indReport({Key? key, this.curSession, required this.reportID}) : super(key: key);

  Session? curSession;
  int reportID;

  @override
  State<indReport> createState() => _indReportState();
}

class _indReportState extends State<indReport> {
  Map? report = {};

  @override
  void initState() {
    super.initState();
    getReport();
  }

  Future<void> getReport () async {
    Map? temp = await widget.curSession?.getDetailedReport(widget.reportID);
    setState(() {
      report = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pirate Plus"),
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
        padding: EdgeInsets.all(30.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Your Report:",
                  style: TextStyle(
                    fontSize: 35.0
                  )
                ),

                SizedBox(
                  height: 30.0,),

                report == {}?
                    Text("Loading...")
                    :
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Report submitted on ${report?['date']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                            )
                            ),

                          SizedBox(
                            height: 10.0,),

                          Text('You were feeling ${report?['emotion']}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18.0,
                            )
                            ),

                          SizedBox(
                            height: 10.0,),

                          report?['answer'] == null?
                              Text("You didn't answer the question: ${report?['question']}",
                                textAlign: TextAlign.center,
                                )

                              :
                              Column(
                                children: [
                                  Text("Question aksed: ${report?['question']}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18.0
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10.0
                                  ),

                                  Text("You answered: ${report?['answer']}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18.0
                                    )
                                  ),


                                    SizedBox(
                                      height: 15.0,),

                                  report?['repsone'] == null?
                                  Text("ChatGPT didn't repsond",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    )
                                  )
                                      :
                                  Text("ChatGPT gave you this advice: ${report?['response']}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    )
                                  ),
                                ],
                            ),

                          SizedBox(
                            height: 10.0,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            width: 2,
                            color: Colors.cyan.shade700,
                          ),
                        ),
                        child: report?['picture'] == null?
                          Text("You didn't take a picture")
                          :
                        Image.memory(Uint8List.fromList(report?['picture'])),
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
