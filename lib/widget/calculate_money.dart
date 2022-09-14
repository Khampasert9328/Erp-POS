// // ignore_for_file: prefer_const_literals_to_create_immutables

// import 'package:erp_pos/constant/images.dart';
// import 'package:erp_pos/constant/theme.dart';
// import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
// import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// class CalculateMoney extends StatelessWidget {
//   final tablename;
//   final name;
//   final size;
//   final number;
//   final amount;
//   const CalculateMoney(
//       {Key? key,
//       required this.tablename,
//       required this.name,
//       required this.size,
//       required this.number,
//       required this.amount})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: ERPTheme.WHITE_COLOR,
//         elevation: 0,
//         title: Text(
//           tablename,
//           style: TextStyle(color: ERPTheme.BASE_COLOR),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 150.h,
//         child: BottomAppBar(
//           notchMargin: 5,
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 height: 30.h,
//                 width: 30.w,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                   color: ERPTheme.BASE_COLOR,
//                 )),
//               ),
//               Container(
//                 height: 30.h,
//                 width: 30.w,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                   color: ERPTheme.BASE_COLOR,
//                 )),
//                 child: Text("ຄິດໄລ່ເງິນ"),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: context.read<GetFoodMenuProvider>().getFoodMenuModel.length,
//       itemBuilder: ((context, index) {
//         for (var element in collection) {
//           return Row(children: [],);
          
//         }
        
//       }))
//     );
//   }
// }
