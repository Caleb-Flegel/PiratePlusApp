import 'package:flutter/cupertino.dart';

import 'report.dart';
import '../models/mysql.dart';

//Class that keeps track of session details like the current user
class Session {
  late int userID;
  report? curReport;
  mySql? db;
  bool? submittedToday;

  Session() {
    print("setting up mysql");
    db = mySql();

    print(db);
  }

  Future<void> setup() async {
    curReport = report();

    db!.getConnection().then((conn) {
      var sql = "select count(uid) ";
      sql += "from mhreports ";
      sql += "where date = STR_TO_DATE(?, '%m/%d/%Y') && userUid = ?";

      conn.query(sql, ["${DateTime.now().month.toString()}/${DateTime.now().day.toString()}/${DateTime.now().year.toString()}", userID]).then((result) {
        print(result.first);
        if (result.first[0] >= 1) {
          submittedToday = true;
          print("submitted today");
        }
        else {
          submittedToday = false;
          print("not submitted today");
        }
      });
    });
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

  Future<int?> loginAttempt(username, password) async {
    print ("in login");
    return db!.getConnection().then((conn) async {
      var sql = "select count(uid) from users where email = ? && password = ?";

      return await conn.query(sql, [username, password]).then((result) async {

        if (result.first[0] != 1)  {
          return -1;
        }

        else {
          sql = "select uid from users where email = ? && password = ?";

          return await conn.query(sql, [username, password]).then((result) {
            return result.first[0];
          });
        }
      });
    });
  }

  Future<int?> createUser(username, password, fname, lname) async {
    print("start create");
    db!.getConnection().then((conn) async {
      var sql =
          "INSERT INTO users (`fname`, `lname`, `email`, `password`) ";
      sql += "VALUES (?, ?, ?, ?)"; //Create SQL statement

      print("Start insert");
      await conn.query(sql, [fname, lname, username, password]).then((result) {
        print("Finished insert");
        print (result);
        if (result.insertId == null) {
          return -1;
        }
        else {
          return result.insertId!;
        }
      });
    });
    return -1;
  }
}

