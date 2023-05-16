import 'package:flutter/material.dart';
import 'package:pirate_plus/Classes/session.dart';

class AccountViewer extends StatefulWidget {
  const AccountViewer({Key? key, this.curSession}) : super(key: key);

  final Session? curSession;

  @override
  State<AccountViewer> createState() => _AccountViewerState();
}

class _AccountViewerState extends State<AccountViewer> {
  TextEditingController fname = TextEditingController();
  var fnameChange;

  TextEditingController lname = TextEditingController();
  var lnameChange;

  TextEditingController email = TextEditingController();
  var emailChange;

  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  var passChange;

  Map accountInfo = {};

  @override
  void initState() {
    super.initState();

    fnameChange = false;
    lnameChange = false;
    emailChange = false;
    passChange = false;

    getInfo();
  }

  void getInfo () async {
    Map newInfo = (await widget.curSession?.getAccountInfo())!;
    setState(() {
      accountInfo = newInfo;
    });
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
      ),

      body: Padding(
        padding: EdgeInsets.all(30.0),
        child:
        accountInfo.isEmpty?
            Text("Loading...")
            :
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Here is some info about yourself"),

                      Text('First Name: ${accountInfo['fname']}'),
                      fnameChange == false?
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  fnameChange = true;
                                });
                              },
                              child: Text("Edit First Name")
                          )
                          :
                          Row(
                            children: [
                              TextField(
                                controller: fname,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'new first name...',
                               ),
                              ),

                              ElevatedButton(
                                  onPressed: () async {
                                      int? track = await widget.curSession?.setAccountInfo("fname", fname.text);

                                      if (track == 0) {
                                        Map newinfo = (await widget.curSession?.getAccountInfo())!;

                                        setState(() {
                                          fnameChange = false;
                                          accountInfo = newinfo;
                                        });
                                    }
                                  },
                                  child: Text("Submit")
                              ),
                            ],
                          ),

                      Text('Last Name: ${accountInfo['lname']}'),
                      lnameChange == false?
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              lnameChange = true;
                            });
                          },
                          child: Text("Edit Last Name")
                      )
                          :
                      Row(
                        children: [
                          TextField(
                            controller: lname,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'new last name...',
                            ),
                          ),

                          ElevatedButton(
                              onPressed: () async {
                                int? track = await widget.curSession?.setAccountInfo("lname", lname.text);

                                if (track == 0) {
                                  Map newinfo = (await widget.curSession?.getAccountInfo())!;

                                  setState(() {
                                    lnameChange = false;
                                    accountInfo = newinfo;
                                  });
                                }
                              },
                              child: Text("Submit")
                          ),
                        ],
                      ),

                      Text('Email: ${accountInfo['email']}'),
                      emailChange == false?
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              emailChange = true;
                            });
                          },
                          child: Text("Edit Email")
                      )
                          :
                      Row(
                        children: [
                          TextField(
                            controller: email,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'new email...',
                            ),
                          ),

                          ElevatedButton(
                              onPressed: () async {
                                int? track = await widget.curSession?.setAccountInfo("email", email.text);

                                if (track == 0) {
                                  Map newinfo = (await widget.curSession?.getAccountInfo())!;

                                  setState(() {
                                    emailChange = false;
                                    accountInfo = newinfo;
                                  });
                                }
                              },
                              child: Text("Submit")
                          ),
                        ],
                      ),

                      fnameChange == false?
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              fnameChange = true;
                            });
                          },
                          child: Text("Edit Password")
                      )
                          :
                      Row(
                        children: [
                          TextField(
                            controller: oldPass,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'enter old password...',
                            ),
                          ),

                          TextField(
                            controller: newPass,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'enter new password...',
                            ),
                          ),

                          ElevatedButton(
                              onPressed: () async {
                                bool? oldPassCheck = await widget.curSession?.checkPassword(oldPass.text);
                                if (oldPassCheck!) {

                                  int? track = await widget.curSession?.setAccountInfo("password", newPass.text);

                                  if (track == 0) {
                                    Map newinfo = (await widget.curSession?.getAccountInfo())!;

                                    setState(() {
                                      passChange = false;
                                      accountInfo = newinfo;
                                    });
                                  }
                                }
                              },
                              child: Text("Submit")
                          ),
                        ],
                      ),
                  ],
        ),
                ),
              ),
            ),
      ),
    );
  }
}
