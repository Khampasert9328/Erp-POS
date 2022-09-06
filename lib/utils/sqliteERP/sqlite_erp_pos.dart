import 'package:erp_pos/model/category/category_models.dart';
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
  final String image = 'image';
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
      onCreate: (db, version) => db.execute('CREATE TABLE $nameTable ($id INTEGER PRIMARY KEY, $uuid TEXT, $name TEXT, $categoryid TEXT, $image TEXT, $size TEXT, $pricesale TEXT, $priceimport TEXT, $status TEXT, $postype TEXT, $selected TEXT, $sum TEXT)'),
      version: version,
    );
  }
  Future<Database> connectDatabase()async{
return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  //ສຳລັບການ insert data
  Future<Null> insertData(Category category)async{
    Database database = await connectDatabase();
    try {
      database.insert(nameTable, category.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print("error:$e");
    }

  }

  //ສຳລັບການດືງຂໍ້ມູນຈາກ SQLite
  Future<List<Category>> getData()async{
    Database database = await connectDatabase();
    List<Category> model = [];
    List<Map<String, dynamic>> maps = await database.query(nameTable);
    for (var item in maps) {
      Category category = Category.fromJson(item);
      model.add(category);
    }
    return model;
  }
  Future<Null> deleteData(String id1)async{
    Database database = await connectDatabase();
    try {
      await database.delete(nameTable, where: '$id = $id1');
    } catch (e) {
      print("error:$e");
    }
  }
}
