// import 'package:erp_pos/model/table/table_models.dart';
// import 'package:erp_pos/pages/onboardingscreen/models/content_models.dart';
// import 'package:erp_pos/services/gettable/get_table.dart';
// import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GetTableProvider extends ChangeNotifier {
//   GetTableModels? _tablelist;
//   GetTableModels? get gettablelist => _tablelist;
//   bool isloading = false;
//   bool get  isload => isloading;

//   Future<void> gettablebyid(BuildContext context) async {
//     isloading = true;
//     _tablelist = await getTable(context);
//     if (_tablelist != null) {
//       for (var item in _tablelist!.table!) {
//         CountPre().setTableId(item.id!);
//         CountPre().setStatusTable(item.status!);
//       }
//       isloading = false;
//       notifyListeners();
//     }
//   }
// }
