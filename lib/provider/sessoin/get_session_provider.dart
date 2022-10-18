import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/createsessoin/create_sessoin_models.dart';
import 'package:erp_pos/model/getsesion/get_sessoin_models.dart';
import 'package:erp_pos/services/createsessoin/create_sessoin_service.dart';
import 'package:erp_pos/services/getsession/get_sesion.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionProvoder extends ChangeNotifier {
  List<SessionItem> _listsession = [];
  List<SessionItem> get listsession => _listsession;
  GetSessoin? _sessoin;
  GetSessoin? get sessoin => _sessoin;
  CreateSession? _createSession;
  CreateSession? get createSessionn => _createSession;
  String? _idsession;
  String? _cashopen;
  String? _sale;
  String? get sale => _sale;
  String? get cashopen => _cashopen;
  String? get idsession => _idsession;
  bool? _isload = false;
  bool? get isloading => _isload;

  Future<void> getsessoinProvider(BuildContext context) async {
    SharedPreferences pre = await SharedPreferences.getInstance();

    _isload = true;
    try {
      _sessoin = await getsessionservice();
      print('get session:$_sessoin');

      if (_sessoin != null) {
        _listsession = _sessoin!.sessionItems!;
        for (var item in _listsession) {
          _idsession = item.id;
          _cashopen = item.cashOpen.toString();
         pre.setString(CountPre().sessoinid, item.id!);
         
        }
        _createSession = await createSession(0);
        if (_createSession != null) {
          print("success");
        }
      }
      _isload = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
