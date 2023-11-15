import 'package:flutter/material.dart';
import 'package:share_watchlist/model/company_model.dart';
import 'package:share_watchlist/model/watctlist_item.dart';
import 'package:sqflite/sqflite.dart' as sql;

class WatchListProvider extends ChangeNotifier {
  List<Watchlistmodel> watchList = [];
  WatchListProvider() {
    refreshUi();
    // Call refreshUi when the provider is created.
  }

  static Future<void> createTables(sql.Database dataBase) async {
    await dataBase.execute("""CREATE TABLE watchlist(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, symbol TEXT, name TEXT, region TEXT, type TEXT
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('watchlist.db', version: 1,
        onCreate: (sql.Database dataBase, int version) async {
      await createTables(dataBase);
    });
  }

  Future<int> addData(CompanyModel details) async {
    final db = await WatchListProvider.db();
    final data = {
      'symbol': details.symbol,
      'name': details.name,
      'region': details.region,
      'type': details.type
    };
    final id = await db.insert('watchlist', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    refreshUi();

    return id;
  }

  Future<List<Map<String, dynamic>>> getList() async {
    final db = await WatchListProvider.db();

    final data = await db.query('watchlist', orderBy: "id");
    return data;
  }

  Future<void> deleteItem(int id) async {
    final db = await WatchListProvider.db();
    try {
      await db.delete("watchlist", where: "id = ?", whereArgs: [id]);
      refreshUi();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  void refreshUi() async {
    watchList.clear();
    var data = await getList();
    watchList.addAll(data.map((map) => Watchlistmodel.fromDb(map)).toList());
    notifyListeners();
  }
}
