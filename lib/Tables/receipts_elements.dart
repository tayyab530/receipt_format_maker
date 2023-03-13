

import 'package:sqflite/sqflite.dart';

import '../Shared/functions.dart';
class Elements{

  static const table = 'Elements';

  static const formatId = "FormatId";
  static const elementId = "ElementId";
  static const text = "ElementText";
  static const topLeftCoordinate = "TopLeftCoordinate";
  static const topLeftX = "TopLeftX";
  static const topLeftY = "TopLeftY";
  static const topRightCoordinate = "TopRightCoordinate";
  static const topRightX = "TopRightX";
  static const topRightY = "TopRightY";
  static const bottomRightCoordinate = "BottomRightCoordinate";
  static const bottomRightX = "BottomRightX";
  static const bottomRightY = "BottomRightY";
  static const bottomLeftCoordinate = "BottomLeftCoordinate";
  static const bottomLeftX = "BottomLeftX";
  static const bottomLeftY = "BottomLeftY";

  Elements._privateConstructor();
  static final Elements instance =
  Elements._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await createDB();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)

  // SQL code to create the database table
  Future onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE  $table(
$formatId nvarchar,
$elementId nvarchar,
$text nvarchar,
$topLeftCoordinate nvarchar,
$topLeftX REAL,
$topLeftY REAL,
$topRightCoordinate nvarchar,
$topRightX REAL,
$topRightY REAL,
$bottomRightCoordinate nvarchar,
$bottomRightX REAL,
$bottomRightY REAL,
$bottomLeftCoordinate nvarchar,
$bottomLeftX REAL,
$bottomLeftY REAL

  )
          ''');
  }

//  PositionID

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

//  EmployeeAbsenceCodeAssignment

  Future<List<Map<String, dynamic>>> queryonlyRows(data, String column) async {
    Database db = await instance.database;

    var res =
    await db.rawQuery("SELECT * FROM $table WHERE $column like '$data' ");

    return res;
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Future.value(Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table')));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row, id) async {
    Database db = await instance.database;
    return await db.update(table, row, where: '2=2');
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
//    Database db = await instance.database;
//    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
    return Future.value(0);
  }

  Future<int> deleteall() async {
    Database db = await instance.database;
    try {
      db.execute("delete from " + table);
      return Future.value(1);
    } catch (e) {
      print("Error no such table ");
      return Future.value(0);
    }
  }
}