
import 'package:sqflite/sqflite.dart';

import '../models/response/list_restaurant_response_model.dart';

class RestaurantLocalDatasource {
  RestaurantLocalDatasource._init();
  static final RestaurantLocalDatasource instance =
      RestaurantLocalDatasource._init();

  final String tableRestaurant = 'restaurant';

  static Database? _database;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableRestaurant (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating REAL)
    ''');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('restaurant_1.db');
    return _database!;
  }

  //save order
  Future<Restaurants> insertRestaurant(Restaurants restaurants) async {
    final db = await instance.database;
    int id = await db.insert(tableRestaurant, restaurants.toMap());
    // String id = await db.insert(tableRestaurant, restaurants.toMap());
    return restaurants.copyWith(id: id.toString());
  }

  Future<List<Restaurants>> getAllRestaurant() async {
    final db = await instance.database;
    final result = await db.query(tableRestaurant);
    return result.map((e) => Restaurants.fromMap(e)).toList();
  }

  Future<bool> isRestaurantFavorite(String restaurantId) async {
    final db = await instance.database;
    final result = await db
        .query(tableRestaurant, where: 'id = ?', whereArgs: [restaurantId]);

    return result
        .isNotEmpty; // If the result is not empty, the restaurant is a favorite
  }

  Future<void> deleteNote(String id) async {
    final db = await database;

    await db.delete(
      tableRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
