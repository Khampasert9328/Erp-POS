
import 'package:device_info_plus/device_info_plus.dart';
import 'package:erp_pos/model/checkexpiredpackage/check_expired_package.dart';
import 'package:erp_pos/model/createordermodel/create_order_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/model/getpackage/package_models.dart';
import 'package:erp_pos/services/checkexpiredpackage/check_expired_package_service.dart';
import 'package:erp_pos/services/createroder/create_order_service.dart';
import 'package:erp_pos/services/getpackage/getpackage.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckExpiredPackage extends ChangeNotifier {
  List<CheckExpiredPackageMedels> checkList = [];
  List<CheckExpiredPackageMedels> get getchecklist => checkList;

  Future<List<CheckExpiredPackageMedels>?> getCheckExpiredPackage(
    
      BuildContext context) async {
    CheckExpiredPackageMedels? package = await checkExpiredPackage();

    if (package != null) {
      SharedPreferences packageid = await SharedPreferences.getInstance();
      packageid.setString(CountPre().packageId, package.packageId.toString());

      SharedPreferences dataexpired = await SharedPreferences.getInstance();
      dataexpired.setString(
          CountPre().dateExpired, package.dateExpired.toString());

      SharedPreferences datesups = await SharedPreferences.getInstance();
      datesups.setString(
          CountPre().dateSubscribe, package.dateSubscribe.toString());

      GetPackageModels? getPackageModels = await getPackage();
      



      if (getPackageModels != null) {
        CreateOrderModels? createOrderModels = await createOrder(context);
        if (createOrderModels != null) {
          String billid = createOrderModels.billNo!;
          SharedPreferences pre = await SharedPreferences.getInstance();
          pre.setString(CountPre().billNo, billid);
          String? billNo = pre.getString(CountPre().billNo);
          
        }
      }
    }
  }
}
