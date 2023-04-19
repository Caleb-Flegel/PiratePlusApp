import '../models/mysql.dart';

class report {
  mySql? db;
  int? userid;
  String? emotion;
  String? question;
  String? response;

  report(this.db, this.userid);

  copyReport(report old){
    db = old.db;
    userid = old.userid;
    emotion = old.emotion;
    question = old.question;
    response = old.response;
  }

  //Func to submit a report
  Future<String> submitReport() async {
    //get db connection
    await db?.getConnection().then((conn) {
      var sql = "INSERT INTO mhreports (`emotion`, `question`, `response`, `userUid`) ";
      sql += "VALUES (?, ?, ?, ?)"; //Create SQL statement

      conn.query(sql, [emotion, question, response, userid]).then((result) {
        return "Report:\nEmotion: ${result.first[0]}\nQuestion: ${result.first[1]}\nResponse: ${result.first[2]}";
      });
      //Run the query
    });
    return "Error";
  }

  //Func which gets a random question based on the submitted emotion
  Future<void> getQuestion() async {
    await db?.getConnection().then((conn) {
        print('About to create sql');
        var sql = "select q.question ";
        sql +=
        "from emotionquestions as q join (emoque as eq join emotions as e on eq.euid = e.uid) on q.uid = eq.quid ";
        sql += "where e.emotion = ? ";
        sql += "order by rand();";
        print('Created SQL statement: $sql \n emotion: $emotion');

        conn.query(sql, [emotion]).then((result) {
          print('returned: ${result}');
          question = result.first[0];
        });
      });
  }
}