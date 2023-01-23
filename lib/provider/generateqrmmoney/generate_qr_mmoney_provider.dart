// ignore_for_file: use_build_context_synchronously

import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/generateqrmmoney/generateqrmmoney.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/services/gerneratem-money/generate_m_money.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/paymentbymoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GenerateQrMmoneyProvider extends ChangeNotifier {
  GenerateQrMmoney? _generateQrMmoney;
  GenerateQrMmoney? get generateQrMmoney => _generateQrMmoney;

  Future<void> getqrmmoney(
      BuildContext context,
      String username,
      String walletid,
      String idtable,
      String tablename,
      String idarea,
      String area) async {
    _generateQrMmoney = await generatemmneyservice(context, username, walletid);

    if (_generateQrMmoney != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentMmoney(
            areaname: area,
            id: idarea,
            
            qrdata: _generateQrMmoney!.qrcodeStr,
            idtable: idtable,
            tablename: tablename,
            username: username,
            walletid: walletid,
          ),
        ),
      );
    }
    notifyListeners();
  }
}
