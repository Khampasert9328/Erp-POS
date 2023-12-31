

import 'dart:async';

import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/paymentcash/paymentcash_models.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/provider/offsession/create_off_session_provider.dart';
import 'package:erp_pos/provider/sessoin/get_session_provider.dart';
import 'package:erp_pos/services/paymentcash/paymentcash_service.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmPaymentByBCELONE extends ChangeNotifier {
  CreatePaymentCashModels? _createPaymentCashModels;
  CreatePaymentCashModels? get createPaymentCashModels =>
      _createPaymentCashModels;
  bool isload = false;
  bool get isloading => isload;

  Future<void> confirmbcelone(
      BuildContext context) async {

        Timer time;
    
    String? billid = context.read<SetData>().billid;
    String? sessionid = await CountPre().getSessionId();
    int paymenttype = 0;
    //////////////////////////////////////////////////////
    String? startDate = await CountPre().getDateSupscribe();
    var std = "$startDate";
    var stdS = std.split(' ');
    var stdSS = stdS[0].trim();
    var rStd = stdSS.replaceAll("-", "");
    /////////////////////////////////////////////
    String? endDate = await CountPre().getDateExpired();
    var ed = '$endDate';
    var edX = ed.split(' ');
    var edXX = edX[0].trim();
    var redX = edXX.replaceAll("-", "");
     String? totalamount =
        context.read<GetFoodMenuProvider>().totalamont.toString();
    int total = int.parse(totalamount);
    try {
      isload = true;
      _createPaymentCashModels = await createpaymentcash(
          billid, total, sessionid!, rStd, redX, paymenttype);

      if (_createPaymentCashModels != null) {
       
        showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                insetAnimationCurve: Curves.bounceOut,
                child: SizedBox(
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
                        "ຊຳລະເງິນສຳເລັດແລ້ວ",
                        style: TextStyle(
                            fontSize: 18.sp, color: AppTheme.BASE_COLOR),
                      ),
                    ],
                  )),
                ),
              );
            });
             await Future.delayed(Duration(seconds: 3));
             Navigator.pop(context);
          
      }
      
    } catch (e) {
      return showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              insetAnimationDuration: const Duration(milliseconds: 5),
              insetAnimationCurve: Curves.bounceOut,
              child: SizedBox(
                height: 200.h,
                width: 100.w,
                child: Center(
                    child: Column(
                  children: [
                    Image.asset(
                      ERPImages.iconerror,
                      height: 104.h,
                      width: 104.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "ກາລຸນາລອງໃໝ່ອີກຄັ້ງ",
                      style: TextStyle(
                          fontSize: 18.sp, color: AppTheme.BASE_COLOR),
                    ),
                  ],
                )),
              ),
            );
          });
    }
    isload = false;
    notifyListeners();
  }
}
