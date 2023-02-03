import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/checkexpiredpackage/check_expired_package.dart';
import 'package:erp_pos/model/createordermodel/create_order_models.dart';
import 'package:erp_pos/model/getpackage/package_models.dart';
import 'package:erp_pos/services/checkexpiredpackage/check_expired_package_service.dart';
import 'package:erp_pos/services/createroder/create_order_service.dart';
import 'package:erp_pos/services/getcategory/get_category.dart';
import 'package:erp_pos/services/getpackage/getpackage.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';

class CreateOrderToBackHomeProvider extends ChangeNotifier {
  GetCategoryModels? _category;
  GetCategoryModels? get category => _category;
  CreateOrderModels? _createOrderModels;
  CreateOrderModels? get createOrderModels => _createOrderModels;
  
 Future<List<CheckExpiredPackageMedels>?> getCheckExpiredPackagetobackhom(
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
        _createOrderModels = await createOrder(context,
            package.dateExpired.toString(), package.dateSubscribe.toString());

        if (_createOrderModels != null) {
          CountPre().setBillIdTobackHome(_createOrderModels!.billId!);
          CountPre().setBillNoTobackHome(_createOrderModels!.billNo!);
        }
      }
    }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

}