import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void _createProductTable(Batch batch) {
  batch.execute('drop table if exists product');
  batch.execute('''
    create table product (
      id integer primary key,
      name text,
      value integer,
      code string,
      stock integer
    );
  ''');
}

final _database = () async {
  return openDatabase(
    version: 1,
    join(await getDatabasesPath(), 'database.sqlite'),
    onCreate: (db, version) async {
      var batch = db.batch();
      _createProductTable(batch);
      await batch.commit();
    },
  );
}();
