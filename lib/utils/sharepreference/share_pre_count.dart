
import 'package:erp_pos/pages/table/components/listview_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountPre {
  late SharedPreferences preferences;
  String idToken = 'idToken';
  String rememberpass='rememberpass';
  String namkey = 'namekey';
  String sumall = 'sum';
  String tableid = 'idtable';
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
  String billid = 'billid';
  String email = "email";
  String firstTime ='firstTime';


  Future<void> setamount(int val)async{
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(namkey, val);
  }
  Future<int?> getamount()async{
    preferences = await SharedPreferences.getInstance();
    return preferences.getInt(namkey);
  }


Future<void> setLogin(bool val)async{
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(firstTime, val);

  }
  Future<bool?> getLogin()async{
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool(firstTime);
  }

  Future<void> setEmail(String val)async{
    preferences = await SharedPreferences.getInstance();
    preferences.setString(email, val);

  }
  Future<String?> getemail()async{
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(email);
  }

  Future<void> setToken(String token)async{
    preferences = await SharedPreferences.getInstance();
    preferences.setString(idToken, token);
  }
  Future<String?> getToken()async{
    preferences = await SharedPreferences.getInstance();
   return preferences.getString(idToken);
  }

  Future<void> setTableId(String idTable)async{
    preferences = await SharedPreferences.getInstance();
    preferences.setString(tableid, idTable);
  }
  Future<String?> getTableId()async{
    preferences = await SharedPreferences.getInstance();
   return preferences.getString(tableid);
  }

  Future<void> setBillNo(String val)async{
    preferences = await SharedPreferences.getInstance();
    preferences.setString(billNo, val);
  }
  Future<String?> getBillNo()async{
    preferences = await SharedPreferences.getInstance();
   return preferences.getString(billNo);
  }
 


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
  Future<void> setRememberPassword(bool val)async{
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(rememberpass, val);
  }
  Future<bool?> getRememberPass()async{
    preferences = await SharedPreferences.getInstance();
   return preferences.getBool(rememberpass);
  }

  Future<void> setPackageId(String val)async{
     preferences = await SharedPreferences.getInstance();
     preferences.setString(packageId, val);
  }
  Future<String?> getPackageId()async{
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(packageId);
  }

  Future<void> setDateExpired(String val)async{
     preferences = await SharedPreferences.getInstance();
     preferences.setString(dateExpired, val);
  }
  Future<String?> getDateExpired()async{
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(dateExpired);
  }

  Future<void> setDateSupscribe(String val)async{
     preferences = await SharedPreferences.getInstance();
     preferences.setString(dateSubscribe, val);
  }
  Future<String?> getDateSupscribe()async{
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(dateSubscribe);
  }
}