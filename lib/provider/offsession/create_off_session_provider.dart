import 'package:erp_pos/model/createoffsession/createoffsession_models.dart';
import 'package:erp_pos/model/getsesion/get_sessoin_models.dart';
import 'package:erp_pos/services/getsession/get_sesion.dart';

import 'package:erp_pos/services/offsession/off_session_service.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';

class CreateOffSessionProvider extends ChangeNotifier {
  GetSessoin? _sessoin;
  GetSessoin? get session => _sessoin;
CreateOffSessionModels? _createOffSessionModels;
CreateOffSessionModels? get createOffSessionModels => _createOffSessionModels;
  String? _idsession;
  String? get idsession => _idsession;
  String? _openDate;
  String? get openDate => _openDate;
  String? _userOpenName;
  String? get userOpenName => _userOpenName;
  int _cashOpen =0 ;
  int get cashOpen => _cashOpen;
  int _cashCount=0;
  int? get cashCount => _cashCount;
  int _total = 0;
  int get total => _total;

  Future<void> getoffsession(BuildContext context) async {
    try {
      _sessoin = await getsessionservice();
      if (_sessoin != null) {
        for (var item in _sessoin!.sessionItems!) {
          _idsession = item.id;
          _openDate = item.openDate!;
          _userOpenName = item.userOpenName!;
          _cashOpen = item.cashOpen??0;
          _cashCount = item.cashCount??0;
          CountPre().setStatus(item.status!);
          CountPre().setSessionId(item.id!);

          for (var item1 in item.bills!) {
            _total += item1.total ?? 0;
          }
        }
        _createOffSessionModels = await createoffsession(context, _idsession!, _openDate!, cashCount!, _userOpenName!, _userOpenName!);
        

        notifyListeners();
      }
    } catch (e) {}
  }
}
