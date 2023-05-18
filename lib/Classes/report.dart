import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:pirate_plus/pages/reportPicture.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/mysql.dart';

class report {
  late String? emotion;
  String? question;
  String? answer;
  String? response;
  DateTime? date;
  Uint8List? picture;

  copyReport(report old) {
    emotion = old.emotion;
    question = old.question;
    answer = old.answer;
    response = old.response;
    picture = old.picture;
  }

  //Func which gets a random question based on the submitted emotion
  Future<String?> getQuestion(mySql? db) async {
    print("Getting Repsonse Question");
    return await db?.getConnection().then((conn) {
      print('About to create sql');
      var sql = "select q.question ";
      sql +=
      "from emotionquestions as q join (emoque as eq join emotions as e on eq.euid = e.uid) on q.uid = eq.quid ";
      sql += "where e.emotion = ? ";
      sql += "order by rand();";
      print('Created SQL statement: $sql \n emotion: $emotion');

      return conn.query(sql, [emotion]).then((result) {
        print('returned: ${result}');
        question = result.first[0].toString();
        return result.first[0].toString();
      });
    });
  }

  //Func to submit a report
  Future<String> submitReport(mySql? db, int? userid) async {
    print("test");
    //get db connection
    await db?.getConnection().then((conn) {
      var sql =
          "INSERT INTO mhreports (`emotion`, `question`, `answer`, `response`, `userUid`, `date`, `photo`) ";
      sql += "VALUES (?, ?, ?, ?, ?, STR_TO_DATE(?, '%m/%d/%Y'), ?)"; //Create SQL statement

      conn.query(sql, [emotion, question, answer, response, userid, "${date?.month.toString()}/${date?.day.toString()}/${date?.year.toString()}", picture]).then(
          (result) {
              return "Report:\nEmotion: ${result.first[0]}\nQuestion: ${result.first[1]}\nResponse: ${result.first[2]}";
      });
      //Run the query
    });
    return "Error";
  }
}
