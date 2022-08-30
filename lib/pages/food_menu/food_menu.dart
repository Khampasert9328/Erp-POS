import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_body.dart';
import 'package:erp_pos/pages/food_menu_detail/components/food_menu_detail_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:erp_pos/constant/routes.dart' as custom_route;

class FoodMenu extends StatefulWidget {
  const FoodMenu({Key? key}) : super(key: key);

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FoodMenuBody(),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Material(
      //       elevation: 10,
      //       child: Container(
      //         padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 15.h),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.only(
      //             topRight: Radius.circular(15.r),
      //             topLeft: Radius.circular(15.r),
      //           ),
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Column(
      //               children: [
      //                 Text(
      //                   'ລາຍການອາຫານ',
      //                   style: TextStyle(
      //                       fontSize: 16.sp, color: ERPTheme.BASE_COLOR),
      //                 ),
      //                 SizedBox(
      //                   height: 5.h,
      //                 ),
      //                 Text.rich(TextSpan(
      //                     style: TextStyle(
      //                         fontSize: 16.sp, color: ERPTheme.BASE_COLOR),
      //                     text: 'ລວມລາຄາ: ',
      //                     children: <InlineSpan>[
      //                       TextSpan(
      //                         text: ' 70.000 ກີບ',
      //                         style: TextStyle(
      //                             fontSize: 16.sp,
      //                             color: ERPTheme.BASE_COLOR,
      //                             fontWeight: FontWeight.bold),
      //                       )
      //                     ]))
      //               ],
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //             ),
      //             Icon(
      //               Icons.shopping_cart,
      //               size: 55,
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      // floatingActionButton: ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      //     primary: ERPTheme.BASE_COLOR,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10.r)
      //     )
      //   ),
      //   onPressed: () {
      //     Navigator.pushNamed(context, custom_route.Route.addfoodmenu);
      //   },
      //   child: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Image.asset(ERPImages.icSoup, width: 25.w, height: 25.h,),
      //       SizedBox(
      //         width: 10.w,
      //       ),
      //       Text(
      //         'ເພີ່ມລາຍການ',
      //         style: TextStyle(
      //             fontSize: 14.sp,
      //             fontWeight: FontWeight.w600,
      //             color: Colors.white),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
