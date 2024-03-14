import 'package:path/path.dart';
import 'package:shopping/model/list_items.dart';
import 'package:shopping/model/shopping_list.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 1;
  Database? db;

  Future openDb() async {
    db ??= await openDatabase(join(await getDatabasesPath(), 'shopping'),
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE lists(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, priority INTEGER)');
      await database.execute(
          'CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT, idList INTEGER, name TEXT, quantity TEXT, note TEXT, '
          'FOREIGN KEY(idList) REFERENCES lists(id))');
    }, version: version);

    // Ensure tables are created
    await createTablesIfNeeded();

    return db;
  }

  Future<void> createTablesIfNeeded() async {
    // Ensure the 'lists' table exists
    await db!.execute(
        'CREATE TABLE IF NOT EXISTS lists(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, priority INTEGER)');

    // Ensure the 'items' table exists
    await db!.execute(
        'CREATE TABLE IF NOT EXISTS items(id INTEGER PRIMARY KEY AUTOINCREMENT, idList INTEGER, name TEXT, quantity TEXT, note TEXT, FOREIGN KEY(idList) REFERENCES lists(id))');
  }

  Future testDb() async {
    db = await openDb();
    await db!.execute('INSERT INTO lists(name, priority) VALUES ("Fruit", 2)');
    String query =
        'INSERT INTO items(idList, name, quantity, note) VALUES (1, "Apples","2 Kg","Better if they are green")';
    await db!.execute(query.toString());
    List<Map<String, dynamic>> lists = await db!.query('lists');
    return lists;
  }

  Future insertList(ShoppingList list) async {
    int id = await db!.insert('lists', list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future insertItem(ListItem items) async {
    int id = await db!.insert('items', items.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<ShoppingList>> getLists() async {
    final List<Map<String, dynamic>> maps = await db!.query('lists');
    return List.generate(maps.length, (i) {
      return ShoppingList(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['priority'],
      );
    });
  }
}
