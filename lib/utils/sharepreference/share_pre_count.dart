import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:erp_pos/model/createordermodel/create_order_models.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/pages/table/components/listview_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountPre {
  late SharedPreferences preferences;
  String idToken = 'idToken';
  String rememberpass = 'rememberpass';
  String namkey = 'namekey';
  String sumall = 'sum';
  String tableid = 'idtable';
  String tablename = 'tablename';
  String packageId = 'packageId';
  String dateExpired = 'dateExpired';
  String dateSubscribe = "dateSubscribe";
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
  String firstTime = 'firstTime';
  String status = 'status';
  String nametable = 'nametable';
  String clicktable = 'clicktable';
  String count = "count";
  String merchid = 'merchid';
  String merchname = 'merchname';
  String accountnumber = 'accountnumber';
  String password = 'password';
  String statusTable = 'statusTable';
  String area = 'area';
  String connectTokenResponse = 'connectTokenResponse';
  String clickradio = 'clickradio';
  String dateTime = 'DateTime';

  String firstOrderMore = 'firsOrderMore';
  String billidDetail = 'billidDetail';
  String orderid = 'orderid';

  String updateorder = 'updateorder';
  String money_received = 'money_received';
  String money_change = 'money_change';

  Future<void> moneyReceived(String money) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(money_received, money);
  }

  Future<String?> getmoneyReceived() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(money_received);
  }

  Future<void> moneyChange(int money) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(money_change, money);
  }

  Future<int?> getmoneyChange() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getInt(money_change);
  }

  Future<void> setUpdateOrder(Order orderModels) async {
    try {
      preferences = await SharedPreferences.getInstance();
      List<String> orderData = preferences.getStringList(updateorder) ?? [];
      List<Order> create = [];
      for (var i in orderData) {
        create.add(Order.fromJson(jsonDecode(i)));
      }
      bool isthereData =
          create.any((element) => element.tableid == orderModels.tableid);
      if (isthereData) {
        for (var i in create) {
          if (i.tableid == orderModels.tableid) {
      
            for (var j in i.product!) {
              orderModels.product!.add(j);
            }
            create.removeWhere((element) => element.tableid == i.tableid);
            create.add(orderModels);
          }
        }
      } else {
        create.add(orderModels);
      }
      List<String> list = [];
      for (var i in create) {
        list.add(jsonEncode(i));
      }
      await preferences.setStringList(updateorder, list);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Order>> getUpdateOrder() async {
    preferences = await SharedPreferences.getInstance();
    List<String> orderData = preferences.getStringList(updateorder) ?? [];
    List<Order> create = [];
    for (var i in orderData) {
      create.add(Order.fromJson(jsonDecode(i)));
    }
    return create;
  }

  Future<void> removeOrderUpdate(String tableid) async {
    preferences = await SharedPreferences.getInstance();
    List<String> orderData = preferences.getStringList(updateorder) ?? [];
    List<Order> create = [];
    for (var i in orderData) {
      create.add(Order.fromJson(jsonDecode(i)));
    }
    create.removeWhere((element) => element.tableid == tableid);
    List<String> list = [];
    for (var i in create) {
      list.add(jsonEncode(i));
    }
    await preferences.setStringList(updateorder, list);
  }

  Future<void> setOrderId(String id) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(orderid, id);
  }

  Future<String?> getOrderId() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(orderid);
  }

  Future<void> setBillDetail(String id) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(billidDetail, id);
  }

  Future<String?> getBillIdDetail() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(billidDetail);
  }

  Future<void> setFirstOrderMore(bool val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(firstOrderMore, val);
  }

  Future<bool?> getFirstOrderMore() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool(firstOrderMore);
  }

  Future<void> setDateTime(String date) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(dateTime, date);
  }

  Future<String?> getDateTimebill() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(dateTime);
  }

  Future<void> setRadioRememberPassword(bool val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(clickradio, val);
  }

  Future<bool?> getRadioRememberPassword() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool(clickradio);
  }

  Future<void> setArea(String areaname) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(area, areaname);
  }

  Future<String?> getArea() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(area);
  }

  Future<void> setStatusTable(int val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(statusTable, val);
  }

  Future<int?> getStatusTable() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getInt(statusTable);
  }

  String sumnumber = 'sumnumber';
  Future<void> setSumnumber(int val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(sumnumber, val);
  }

  Future<int?> getSumnumber() async {
    preferences = await SharedPreferences.getInstance();
    preferences.getInt(sumnumber);
  }

  Future<void> setAccountNumber(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(accountnumber, val);
  }

  Future<String?> getAccountNumber() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(accountnumber);
  }

  Future<void> setMerchid(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(merchid, val);
  }

  Future<String?> getMerchid() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(merchid);
  }

  Future<void> setMerchName(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(merchname, val);
  }

  Future<String?> getMerchName() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(merchname);
  }

  Future<void> setCount(int val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(count, val);
  }

  Future<int?> getCount() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getInt(count);
  }

  Future<void> setBillId(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(billid, val);
  }

  Future<String?> getBillId() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(billid);
  }

  Future<void> setClickTable(bool val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(clicktable, val);
  }

  Future<bool?> getClickTable() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool(clicktable);
  }

  Future<void> setNameTable(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(nametable, val);
  }

  Future<String?> getNameTable() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(nametable);
  }

  Future<void> setStatus(int val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(status, val);
  }

  Future<int?> getStatus() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getInt(status);
  }

  Future<void> setSessionId(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(sessoinid, val);
  }

  Future<String?> getSessionId() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(sessoinid);
  }

  Future<void> setamount(int val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(namkey, val);
  }

  Future<int?> getamount() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getInt(namkey);
  }

  Future<void> setLogin(bool val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(firstTime, val);
  }

  Future<bool?> getLogin() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool(firstTime);
  }

  Future<void> setPassword(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(password, val);
  }

  Future<String?> getPassword() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(password);
  }

  Future<void> setEmail(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(email, val);
  }

  Future<String?> getemail() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(email);
  }

  Future<void> setModelsToken(String token) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(idToken, token);
  }

  Future<String?> getToken() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(idToken);
  }

  Future<void> setConnectTokenResponse(String tokenresponse) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(connectTokenResponse, tokenresponse);
  }

  Future<String?> getConnectTokenResponse() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(connectTokenResponse);
  }

  Future<void> setTableId(String idTable) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(tableid, idTable);
  }

  Future<String?> getTableId() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(tableid);
  }

  Future<void> setTableName(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(tablename, val);
  }

  Future<String?> getTableName() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(tablename);
  }

  Future<void> setBillNo(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(billNo, val);
  }

  Future<String?> getBillNo() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(billNo);
  }

  Future<void> setsumall(int sum) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(sumall, sum);
  }

  Future<String?> getsumall() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(sumall);
  }

  Future<void> setrefreshToken(String refresh) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(refreshToken, refresh);
  }

  Future<String?> getconnectToken() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(connectToken);
  }

  Future<void> setRememberPassword(bool val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(rememberpass, val);
  }

  Future<bool?> getRememberPass() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool(rememberpass);
  }

  Future<void> setPackageId(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(packageId, val);
  }

  Future<String?> getPackageId() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(packageId);
  }

  Future<void> setDateExpired(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(dateExpired, val);
  }

  Future<String?> getDateExpired() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(dateExpired);
  }

  Future<void> setDateSupscribe(String val) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(dateSubscribe, val);
  }

  Future<String?> getDateSupscribe() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(dateSubscribe);
  }
}
