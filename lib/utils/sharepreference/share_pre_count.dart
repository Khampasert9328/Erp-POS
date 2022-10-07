
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
  String refreshToken = 'refreshToken';
  String connectToken = "connectToken";
  String prefshift = 'prefshift';
  String cashOpen = 'cashOpen';
  String sale = 'sale';
 


  Future<void> setsumall(int sum)async{
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(sumall, sum);

  }
  Future<String?> getsumall()async{
    preferences = await SharedPreferences.getInstance();
  return preferences.getString(sumall);
  }
  Future<void> setrefreshToken(String refresh)async{
    preferences = await SharedPreferences.getInstance();
    preferences.setString(refreshToken, refresh);
  }
  Future<String?> getconnectToken()async{
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(connectToken);
  }
}