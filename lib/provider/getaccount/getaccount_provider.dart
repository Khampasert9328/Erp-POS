import 'package:erp_pos/model/getaccount/getaccount_models.dart';
import 'package:erp_pos/services/getaccount/getaccount_service.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';

class GetAccountProvider extends ChangeNotifier {
  GetAccountModels? _getAccount;
  GetAccountModels? get getAccount => getAccount;
  List<Payment>? _listaccount =[];
  List<Payment>? get listaccount => _listaccount;

  Future<List<Payment>?> getAccountProvider() async {
    String? idtoken = await CountPre().getToken();
    _getAccount = await getAccountService(-1, 0, idtoken!);
    if (_getAccount != null) {
      _listaccount = _getAccount!.payment!;
      for (var account in _listaccount!) {
        if (account.accounttype == 4) {
          CountPre().setMerchid(account.merchid!);
          CountPre().setMerchName(account.merchname!);
          CountPre().setAccountNumber(account.accountnumber!);
        }
      }
    }
    notifyListeners();
    return _listaccount;
  }
}