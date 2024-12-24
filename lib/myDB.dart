import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Mydb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await startDb();
      return _db;
    }
    return _db;
  }

  startDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'my_db.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Users(
        uid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        pass TEXT,
        type INTEGER
      )''');
      await db.execute('''
        CREATE TABLE Pizza(
        pid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        desc TEXT,
        img TEXT,
        price TEXT,
        old_price TEXT,
        QteStock INTEGER, 
        isVeg INTEGER, 
        nature TEXT, 
        options TEXT, 
        archive INTEGER
      )''');
      await db.execute(
          'INSERT INTO Users(name,email,pass,type) VALUES("mekelleche mokhtar","mokhtar123@gmail.com","Password1",1)');
      await db.execute(
          'INSERT INTO Users(name,email,pass,type) VALUES("admin","admin@gmail.com","Password0",0)');
      await db.execute(
  'INSERT INTO Pizza(title, desc, img, price, old_price, QteStock, isVeg, nature, options, archive) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
  [
    "The Beast",
    "With this pizza, you won't be hungry for days...",
    "images/pizza.jpeg",
    "\$12.6",
    "\$14.00",
    2,
    0,
    "SPICY",
    '{"calories": 200, "protein": 15, "fat": 10, "carbs": 30}',  // JSON as string
    1
  ]
);

await db.execute(
  'INSERT INTO Pizza(title, desc, img, price, old_price, QteStock, isVeg, nature, options, archive) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
  [
    "Cheesy Marvel",
    "This is the best cheesy pizza you'll ever have!",
    "images/pizza.jpeg",
    "\$10.80",
    "\$12.00",
    2,
    0,
    "BLAND",
    '{"calories": 200, "protein": 15, "fat": 10, "carbs": 30}',  // JSON as string
    1
  ]
);

await db.execute(
  'INSERT INTO Pizza(title, desc, img, price, old_price, QteStock, isVeg, nature, options, archive) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
  [
    "The Classic",
    "Simple is sometimes the best..",
    "images/pizza.jpeg",
    "\$9.0",
    "\$10.00",
    2,
    1,
    "BALANCE",
    '{"calories": 200, "protein": 15, "fat": 10, "carbs": 30}',  // JSON as string
    1
  ]
);

await db.execute(
  'INSERT INTO Pizza(title, desc, img, price, old_price, QteStock, isVeg, nature, options, archive) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
  [
    "Peperoni Pizza",
    "With this pizza, you won't be hungry for days...",
    "images/pizza.jpeg",
    "\$9.80",
    "\$11.00",
    2,
    1,
    "BALANCE",
    '{"calories": 200, "protein": 15, "fat": 10, "carbs": 30}',  // JSON as string
    1
  ]
);


    });
    return database;
  }

  selectData(String query) async {
    Database? database = await db;
    List response = await database!.rawQuery(query);
    return response;
  }

  insertData(String query) async {
    Database? database = await db;
    int response = await database!.rawInsert(query);
    return response;
  }

  updateData(String query) async {
    Database? database = await db;
    int response = await database!.rawUpdate(query);
    return response;
  }

  Future<int?> validateUser(String email, String password) async {
    Database? database = await db;
    final List result = await database!.rawQuery(
      'SELECT * FROM Users WHERE email = ? AND pass = ?',
      [email, password],
    );

    if (result.isNotEmpty) {
      return result[0]['uid'] as int?;
    } else {
      return null;
    } 
  }

  Future<bool?> validatemail(String email) async {
    Database? database = await db;
    final List result = await database!.rawQuery(
      'SELECT * FROM Users WHERE email = ?',
      [email],
    );

    return result.isNotEmpty;
  }
}
