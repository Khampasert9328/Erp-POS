import 'package:device_info_plus/device_info_plus.dart';
import 'package:erp_pos/model/checkexpiredpackage/check_expired_package.dart';
import 'package:erp_pos/model/createordermodel/create_order_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/model/getpackage/package_models.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/services/checkexpiredpackage/check_expired_package_service.dart';
import 'package:erp_pos/services/createroder/create_order_service.dart';
import 'package:erp_pos/services/getpackage/getpackage.dart';
import 'package:erp_pos/services/updatestatus/updatestatus_service.dart';
import 'package:erp_pos/utils/setdata/id_table_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class CheckExpiredPackage extends ChangeNotifier {
  List<CheckExpiredPackageMedels> checkList = [];
  List<CheckExpiredPackageMedels> get getchecklist => checkList;
  CreateOrderModels? _createOrderModels;
  CreateOrderModels? get createOrderModels => _createOrderModels;

  Future<List<CheckExpiredPackageMedels>?> getCheckExpiredPackage(
      BuildContext context, String idarea, String area, String idtable, String tablename) async {
    CheckExpiredPackageMedels? package = await checkExpiredPackage();

    if (package != null) {
      CountPre().setPackageId(package.packageId.toString());
      CountPre().setDateExpired(package.dateExpired.toString());
      CountPre().setDateSupscribe(package.dateSubscribe.toString());
      GetPackageModels? getPackageModels = await getPackage();

      CountPre().setDateSupscribe(package.dateSubscribe.toString());
      if (getPackageModels != null) {
        _createOrderModels = await createOrder(context,
            package.dateExpired.toString(), package.dateSubscribe.toString(), idtable);

        if (_createOrderModels != null) {
          updateStatus(context, idarea, area, idtable, tablename);
          CountPre().setBillId(_createOrderModels!.billId!);
          CountPre().setBillNo(_createOrderModels!.billNo!);
        }
      }
    }
  }
}
