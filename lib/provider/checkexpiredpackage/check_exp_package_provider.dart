// ignore_for_file: use_build_context_synchronously

import 'package:device_info_plus/device_info_plus.dart';
import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/checkexpiredpackage/check_expired_package.dart';
import 'package:erp_pos/model/createOrderMore/create_order_more.dart';
import 'package:erp_pos/model/createordermodel/create_order_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/model/getorderbylistid/get_order_by_list_id_models.dart';
import 'package:erp_pos/model/getpackage/package_models.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/model/updateorder/update_order_models.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/services/checkexpiredpackage/check_expired_package_service.dart';
import 'package:erp_pos/services/createroder/create_order_again.dart';
import 'package:erp_pos/services/createroder/create_order_service.dart';
import 'package:erp_pos/services/getcategory/get_category.dart';
import 'package:erp_pos/services/getpackage/getpackage.dart';
import 'package:erp_pos/services/updatestatus/updatestatus_service.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';

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
  GetCategoryModels? _category;
  GetCategoryModels? get category => _category;
  CreateOrderAgainModles? _updateOrderModels;
  CreateOrderAgainModles? get updateOrderModels => _updateOrderModels;

  Future<List<CheckExpiredPackageMedels>?> getCheckExpiredPackage(
      BuildContext context) async {
    try {
      CheckExpiredPackageMedels? package = await checkExpiredPackage();

      if (package != null) {
        CountPre().setPackageId(package.packageId.toString());
        CountPre().setDateExpired(package.dateExpired.toString());
        CountPre().setDateSupscribe(package.dateSubscribe.toString());
        GetPackageModels? getPackageModels = await getPackage();

        CountPre().setDateSupscribe(package.dateSubscribe.toString());
        if (getPackageModels != null) {
          _category = await getCategory();
          if (_category != null) {
            _createOrderModels = await createOrder(
                context,
                package.dateExpired.toString(),
                package.dateSubscribe.toString());
            if (_createOrderModels != null) {
              CountPre().setBillId(_createOrderModels!.billId!);
              CountPre().setBillNo(_createOrderModels!.billNo!);
            }
          }
        }
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> orderagain(BuildContext context) async {
    String? dateexpired = await CountPre().getDateExpired();
    String? datesup = await CountPre().getDateSupscribe();
    String? billid = await CountPre().getBillIdDetail();
    String? orderid = await CountPre().getOrderId();
    String? tableid = await CountPre().getTableId();

    _updateOrderModels = await createOrderAgain(context, dateexpired.toString(),
        datesup.toString(), tableid, billid.toString(), orderid.toString());

    notifyListeners();
  }
}
