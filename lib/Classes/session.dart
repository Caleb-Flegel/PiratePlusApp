import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pirate_plus/pages/results.dart';

import 'report.dart';
import '../models/mysql.dart';

//Class that keeps track of session details like the current user
class Session {
  late int userID;
  report? curReport;
  mySql? db;
  bool? submittedToday;
  String? firstname;
  String? lastname;

  Session() {
    print("setting up mysql");
    db = mySql();

    print(db);
  }

  Future<void> setup() async {
    curReport = report();

    db!.getConnection().then((conn) async {
      print("Getting named");

      var sql = "select `fname`, `lname` from users where uid = ?";
      await conn.query(sql, [userID]).then((result) {
        print(result);
        firstname = result.first['fname'];
        lastname = result.first['lname'];
        print(firstname);
        print(lastname);
      });

      sql = "select count(uid) ";
      sql += "from mhreports ";
      sql += "where date = STR_TO_DATE(?, '%m/%d/%Y') && userUid = ?";

      await conn.query(sql, [
        "${DateTime.now().month.toString()}/${DateTime.now().day.toString()}/${DateTime.now().year.toString()}",
        userID
      ]).then((result) {
        print(result.first);
        if (result.first[0] >= 1) {
          submittedToday = true;
          print("submitted today");
        } else {
          submittedToday = false;
          print("not submitted today");
        }
      });
    });
  }

  //Checks if the entered info would be a unique username or password
  Future<bool> checkUniqueness(String info) async {
    return db!.getConnection().then((conn) {
      var sql = "select count(uid) from users where password = ? or email = ?";

      return conn.query(sql, [info, info]).then((result) {
        if (result.first[0] == 0) {
          return true;
        } else {
          return false;
        }
      });
    });
    return false;
  }

  //Checks if the entered password is correct for the current user
  Future<bool> checkPassword(String password) async {
    return db!.getConnection().then((conn) {
      var sql = "select password from users where uid = ?";

      return conn.query(sql, [userID]).then((result) {
        if (result.first[0] == password) {
          return true;
        } else {
          return false;
        }
      });
    });
    return false;
  }

  Future<Map> getAccountInfo() async {
    return db!.getConnection().then((conn) {
      var sql = "select * from users where uid = ?";

      return conn.query(sql, [userID]).then((result) {
        return {
          'fname': result.first[1],
          'lname': result.first[2],
          'email': result.first[3]
        };
      });
    });
  }

  Future<int> setAccountInfo(String infoType, String info) async {
    //Preform uniqueness check if sensitive info
    if (infoType == "email" || infoType == "password") {
      if (!(await checkUniqueness(info))) {
        return -1;
      }
    }

    return db!.getConnection().then((conn) {
      print("vars: ${infoType}, ${info}, ${userID}");
      var sql = "update users set ? = ? ";
      sql += "where uid = ?";
      print(sql);

      return conn.query(sql, [infoType, info, userID]).then((result) {

        return 0;
      });
    });

    return -2;
  }

  //Func which gets a random quote on the home page
  Future<List> getQuote() async {
    return db!.getConnection().then((conn) {
      //print('About to create sql');
      var sql = "select i.`quote text`, i.`quote author` ";
      sql += "from inspirationquotes as i ";
      sql += "order by rand();";
      //print('Created SQL statement: $sql \n emotion: $emotion');

      return conn.query(sql).then((result) {
        return [result.first[0], result.first[1]];
      });
    });
  }

  Future<Map> getHomeReport() {
    return db!.getConnection().then((conn) async {
      var sql = "select emotion, date_format(`date`, '%d %M %y'), photo from mhreports ";
      sql += "where userUid = ? and (emotion = 'Happy' or emotion = 'Excited' or emotion = 'Relaxed' or emotion = 'Neutral') ";
      sql += "order by rand()";

      return await conn.query(sql, [userID]).then((result) async {
        Blob? img;

        if(result.first[2] != null) {
         img = result.first[2];
        }

        return {
          'emotion': result.first[0],
          'date': result.first[1],
          'picture': img?.toBytes()
        };
      });
    });
  }

  Future<Map> getDetailedReport(int reportId) {
    return db!.getConnection().then((conn) async {
      var sql = "select emotion, question, answer, response, date_format(`date`, '%d %M %y'), photo from mhreports ";
      sql += "where userUid = ? and uid = ?";

      return await conn.query(sql, [userID, reportId]).then((result) async {
        Blob? img;

        if(result.first[5] != null) {
          img = result.first[5];
        }

        return {
          'emotion': result.first[0],
          'question': result.first[1],
          'answer': result.first[2],
          'response': result.first[3],
          'date': result.first[4],
          'picture': img?.toBytes()
        };
      });
    });
  }

  Future<List<Map>> getAllReports () async {
    return db!.getConnection().then((conn) async {
      var sql = "select uid, emotion, date_format(`date`, '%d %M %y'), answer ";
      sql += "from mhreports where userUid = ? ";
      sql += "order by `date` desc";

      return await conn.query(sql, [userID]).then((result) async {
        List<Map> reports = [];

        for (int i = 0; i < result.length; i++) {
          reports.add({
            'uid': result.elementAt(i)[0],
            'emotion': result.elementAt(i)[1],
            'date': result.elementAt(i)[2],
            'answer': result.elementAt(i)[3],
          });
        }

        return reports;
      });
    });
  }

  Future<int> loginAttempt(username, password) async {
    print("in login");
    return db!.getConnection().then((conn) async {
      var sql = "select count(uid) from users where email = ? && password = ?";

      return await conn.query(sql, [username, password]).then((result) async {
        if (result.first[0] != 1) {
          return -1;
        } else {
          sql = "select uid from users where email = ? && password = ?";

          return await conn.query(sql, [username, password]).then((result) {
            return result.first[0];
          });
        }
      });
    });
    return -2;
  }

  Future<int?> createUser(username, password, fname, lname) async {
    //Check for uniqueness
    if ((await checkUniqueness(username)) ||
        (await checkUniqueness(password))) {
      //If here, the username and password are unique
      return db!.getConnection().then((conn) async {
        var sql = "INSERT INTO users (`fname`, `lname`, `email`, `password`) ";
        sql += "VALUES (?, ?, ?, ?)"; //Create SQL statement

        print("Start insert");
        return await conn
            .query(sql, [fname, lname, username, password]).then((result) {
          return result.insertId!;
        });
      });
    }
    return -1;
  }
}
