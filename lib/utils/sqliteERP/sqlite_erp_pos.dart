import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class SQLiteERPPOS {
  //ສຳລັບຊື່ Database
  final String nameDatabase = 'ERP_POS.db';
  //ສຳລັບຊື່ table
  final String nameTable = 'orderTABLE';

  //ສຳລັບເວີຊັນຂອງ Database
  int version = 1;

  //ສຳລັບ field ຂອງ Table
  final String id = 'id';
  final String uuid = 'uuid';
  final String name = 'name';
  final String categoryid = 'categoryid';
  final String thumbnails = 'thumbnails';
  final String size = 'size';
  final String pricesale = 'pricesale';
  final String priceimport = 'priceimport';
  final String status = 'status';
  final String postype = 'postype';
  final String selected = 'selected';
  final String sum = 'sum';

  SQLiteERPPOS() {
    //ເວລາທີ່ ທລສ ເຄື່ອງໃດບໍ່ມີ sqlite ໃຫ້ມັນສ້າງອັດຕະໂນມັດ
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) => db.execute('CREATE TABLE $nameTable ($id INTEGER PRIMARY KEY, $uuid TEXT, $name TEXT, $categoryid TEXT, $thumbnails TEXT, $size TEXT, $pricesale TEXT, $priceimport TEXT, $status TEXT, $postype TEXT, $selected TEXT, $sum TEXT)'),
      version: version,
    );
  }
}
