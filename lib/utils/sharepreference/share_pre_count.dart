
import 'package:shared_preferences/shared_preferences.dart';

class CountPre {
  late SharedPreferences preferences;
  String namkey = 'namekey';
  String sumall = 'sum';
  String tableid = 'id';
   String tablename = 'tablename';
  String packageId ='packageId';
  String dateExpired = 'dateExpired';
  String dateSubscribe="dateSubscribe";
  String idzone = "zone";
  String billNo = "billNo";
  String sessoinid = 'sessionId';

  Future<void> setsumall(int sum)async{
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(sumall, sum);

  }
  Future<String?> getsumall()async{
    preferences = await SharedPreferences.getInstance();
  return preferences.getString(sumall);
  }
}