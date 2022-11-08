// ignore_for_file: use_build_context_synchronously

import 'package:erp_pos/model/generateqrmmoney/generateqrmmoney.dart';
import 'package:erp_pos/services/gerneratem-money/generate_m_money.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/paymentbymoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenerateQrMmoneyProvider extends ChangeNotifier {
  GenerateQrMmoney? _generateQrMmoney;
  GenerateQrMmoney? get generateQrMmoney => _generateQrMmoney;

  Future<void> getqrmmoney(BuildContext context) async {
    String? tablename = await CountPre().getTableName();
    _generateQrMmoney = await generatemmneyservice(context);
    if (_generateQrMmoney != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentMmoney(
            qrdata: _generateQrMmoney!.qrcodeStr,
            tablename: tablename,
          ),
        ),
      );
    }
  }
}
