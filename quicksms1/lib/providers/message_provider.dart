import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MessageProvider {
  static Database db;
  static Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'messages.db'),
        version: 1, onCreate: (Database db, int version) async {
      db.execute('''
          create table Messages(
            id integer primary key autoincrement,
            title text not null,
            text text not null
          );
      ''');
    });
  }

  static Future<List<Map<String, dynamic>>> getMessageList() async {
    if (db == null) {
      await open();
    }
    return await db.query('Messages');
  }

  static Future insertMessage(Map<String, dynamic> message) async {
    await db.insert('Messages', message);
  }

  static Future updateMessage(Map<String, dynamic> message) async {
    await db
        .update('Messages', message, where: 'id=?', whereArgs: [message['id']]);
  }

  static Future deleteMessage(int id) async {
    await db.delete('Messages', where: 'id=?', whereArgs: [id]);
  }
}
