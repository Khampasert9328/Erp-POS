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

  Future<List<SessionItem>?> getsessoinProvider(BuildContext context) async {
   try {
      GetSessoin? sessoin = await getsessionservice();

      print("sessoin:$sessoin");

    if (sessoin != null) {
      _listsession = sessoin.sessionItems!;
      for (var item in sessoin.sessionItems!) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(CountPre().sessoinid, item.id!);
      }
      CreateSession? createsesion = await createSession();
      if (createsesion != null) {
        showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                insetAnimationDuration: Duration(milliseconds: 5),
                insetAnimationCurve: Curves.bounceOut,
                child: Container(
                  height: 200.h,
                  width: 100.w,
                  child: Center(
                      child: Column(
                    children: [
                      Image.asset(
                        ERPImages.success,
                        height: 104.h,
                        width: 104.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "ເປີດກະສຳເລັດແລ້ວ",
                        style: TextStyle(
                            fontSize: 18.sp, color: AppTheme.BASE_COLOR),
                      ),
                    ],
                  )),
                ),
              );
            });

        Navigator.pop(context);
      }
      notifyListeners();
    }
    return _listsession;
   } catch (e) {
    print("error:$e");
     
   }
  }
}
