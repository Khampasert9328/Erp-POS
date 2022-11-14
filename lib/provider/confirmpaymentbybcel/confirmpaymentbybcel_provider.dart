// ignore_for_file: use_build_context_synchronously

import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/paymentcash/paymentcash_models.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/provider/offsession/create_off_session_provider.dart';
import 'package:erp_pos/provider/sessoin/get_session_provider.dart';
import 'package:erp_pos/services/confirmpaymentbybcelone/confirmpaymentbcel_service.dart';
import 'package:erp_pos/services/paymentcash/paymentcash_service.dart';
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

  Future<void> confirmbcelone(BuildContext context) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    String? startDate = pre.getString(CountPre().dateSubscribe);
    String? endDate = pre.getString(CountPre().dateExpired);
    String? billid = context.read<GetOrderByIssueDateProvider>().billid;
    String? sessionid = pre.getString(CountPre().sessoinid);
    String? totalamount =
        context.read<GetFoodMenuProvider>().totalamont.toString();
    int total = int.parse(totalamount);
    int paymenttype = 1;

    try {
      isload = true;
      _createPaymentCashModels = await confirmpaymentbybcelone(
          context, billid!, sessionid!, startDate!, endDate!, paymenttype, 1);
      // print("create:$_createPaymentCashModels");
      if (_createPaymentCashModels != null) {
        showDialog(
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
                        ERPImages.success,
                        height: 104.h,
                        width: 104.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "ຢືນຢັນການຊຳລະ",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppTheme.BASE_COLOR,
                        ),
                      ),
                    ],
                  )),
                ),
              );
            });
      }
    } catch (e) {}
    isload = false;
    notifyListeners();
  }
}
