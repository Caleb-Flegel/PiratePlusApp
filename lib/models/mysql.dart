import 'package:mysql1/mysql1.dart';

class mySql {
    static String host = 'pirateplusdata.mysql.database.azure.com',
                  user = 'plusmaster',
                  password = 'S\'goBucs',
                  db = 'plusdata';

    static int port = 3306;

    mySql();

    Future<MySqlConnection> getConnection() async {
        var settings = new ConnectionSettings(
            host: host,
            port: port,
            user: user,
            password: password,
            db: db
        );
        return await MySqlConnection.connect(settings);
    }
}