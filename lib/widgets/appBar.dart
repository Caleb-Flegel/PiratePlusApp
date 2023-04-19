import 'package:flutter/material.dart';



class appBarForNav extends StatelessWidget {
  const appBarForNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      elevation: 0,

      actions: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
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
          onPressed: () {
            print("Go edit user settings");
          },
          icon: Icon(
            Icons.person,
          ),
        ),
      ],
    );
  }
}
