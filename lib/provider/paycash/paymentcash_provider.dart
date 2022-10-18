import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/paymentcash/paymentcash_models.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/provider/offsession/create_off_session_provider.dart';
import 'package:erp_pos/provider/sessoin/get_session_provider.dart';
import 'package:erp_pos/services/paymentcash/paymentcash_service.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentCashProvider extends ChangeNotifier {
  CreatePaymentCashModels? _createPaymentCashModels;
  CreatePaymentCashModels? get createPaymentCashModels =>
      _createPaymentCashModels;
  bool isload = false;
  bool get isloading => isload;

  Future<void> createpaymentcashprovider(
      BuildContext context, int number) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    String? startDate = pre.getString(CountPre().dateSubscribe);
    String? endDate = pre.getString(CountPre().dateExpired);
    String? billid = context.read<GetOrderByIssueDateProvider>().billid;
    String? sessionid = pre.getString(CountPre().sessoinid);
    int paymenttype =0;

    try {
      isload = true;
      _createPaymentCashModels = await createpaymentcash(
          billid!, number, sessionid!, startDate!, endDate!, paymenttype);
      print("create:$_createPaymentCashModels");
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
                        "ຊຳລະເງິນສຳເລັດແລ້ວ",
                        style: TextStyle(
                            fontSize: 18.sp, color: AppTheme.BASE_COLOR),
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
