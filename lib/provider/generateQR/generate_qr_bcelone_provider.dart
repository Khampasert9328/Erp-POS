import 'package:codecamp_onepay/codecamp_onepay.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/services/generateqrBCEL/generate_qr_bcelone.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class GenerateQRBCELONE extends ChangeNotifier {
  String transaction = '';
  String mcid = 'mch5c2f0404102fb';
 
  String subScribeKey = 'sub-c-91489692-fa26-11e9-be22-ea7c5aada356';
  String uuID = 'BCELBANK';
  int expiredTime = 3; // ຕ້ອງເປັນນາທີ
  String terminalID = '0000';
  String dateTime = '';

  String get getdateTime => dateTime;
  String qrData = '';
  String get getqrData => qrData;
  String get getShopecode => shopcode;
   String shopcode = '12345678';

  Future<String> getGenerateQR(BuildContext context) async {
    transaction = DateTime.now().toString();
    qrData = CodecampOnepay.initQR(
      mcid,
      transaction,
      terminalID,
      context.read<GetFoodMenuProvider>().totalamont,
      'invoiceID-$transaction',
      "Codecamp-Payment",
      expiredTime,
      closeWhenPaySuccess: false,
    );
  
    CodecampOnepay.observe(subScribeKey, uuID, mcid, shopcode, (message) {
      print("sucess");
    });
    notifyListeners();
    return qrData;
  }
}
