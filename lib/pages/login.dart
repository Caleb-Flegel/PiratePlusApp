import 'package:flutter/material.dart';
import 'package:pirate_plus/Classes/session.dart';
import 'package:pirate_plus/main.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String? status;
  Session newSession = Session();

  @override
  void initState() {
    super.initState();
    print(newSession);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
              Color.fromARGB(255, 106, 229, 198),
              Colors.cyan.shade700
            ])),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Hello there!",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (status == null) ? SizedBox(height: 0) : Text(status!),
                    TextField(
                      controller: username,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'email',
                         filled: true, //<-- SEE HERE
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: password,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'password',
                        filled: true, //<-- SEE HERE
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => signUp(
                            newSession: newSession,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (username.text.isNotEmpty && password.text.isNotEmpty) {
                        print("try login");
                        newSession.userID = (await newSession.loginAttempt(
                            username.text, password.text));
      
                        if (newSession.userID == -1) {
                          print("login error");
                          setState(() {
                            status = "Incorrect email or password";
                          });
                        } else {
                          print("login success");
      
                          await newSession.setup().then((value) {
                            //Go home
                            Navigator.pushReplacement<void, void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => basic(
                                  curSession: newSession,
                                ),
                              ),
                            );
                          });
                        }
                      } else {
                        setState(() {
                          status = "Enter an email and password!";
                        });
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class signUp extends StatefulWidget {
  const signUp({Key? key, required this.newSession}) : super(key: key);

  final Session newSession;

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();

  String? status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
              Color.fromARGB(255, 106, 229, 198),
              Colors.cyan.shade700
            ])),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sign up for Nexus",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
                ),
              Column(
                children: [
                  (status == null) ? SizedBox(height: 0) : Text(status!),
                  TextField(
                    controller: fName,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'first name',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                    ),
                  ),
                  TextField(
                    controller: lName,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'last name',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                    ),
                  ),
                  TextField(
                    controller: username,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'email',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                    ),
                  ),
                  TextField(
                    controller: password,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'password',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (username.text.isNotEmpty &&
                          password.text.isNotEmpty &&
                          fName.text.isNotEmpty &&
                          lName.text.isNotEmpty) {
                        widget.newSession.userID = (await widget.newSession
                            .createUser(username.text, password.text, fName.text,
                                lName.text))!;
      
                        print(widget.newSession.userID);
      
                        if (widget.newSession.userID == -1) {
                          setState(() {
                            status = "Email or password already used";
                          });
                        } else {
                          await widget.newSession.setup().then((value) {
                            //Go home
                            Navigator.pushReplacement<void, void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => basic(
                                    curSession: widget.newSession,
                                  ),
                                ));
                          });
                        }
                      } else {
                        print("no info");
                        setState(() {
                          status = "Enter all information!";
                        });
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
