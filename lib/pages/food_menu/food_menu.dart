import 'package:backdrop/backdrop.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/theme.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({Key? key}) : super(key: key);

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackdropScaffold(
        backLayer: FoodMenuBody(),
        backLayerBackgroundColor: Colors.white,
        subHeader: Material(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 15.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.r),
                topLeft: Radius.circular(15.r),
              ),
            ),
            child: Column(
              children: [
                BackdropToggleButton(
                  icon: AnimatedIcons.list_view,
                  color: ERPTheme.BASE_COLOR,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'ລາຍການອາຫານ',
                          style: TextStyle(
                              fontSize: 16.sp, color: ERPTheme.BASE_COLOR),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text.rich(TextSpan(
                            style: TextStyle(
                                fontSize: 16.sp, color: ERPTheme.BASE_COLOR),
                            text: 'ລວມລາຄາ: ',
                            children: <InlineSpan>[
                              TextSpan(
                                text: ' 70.000 ກີບ',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ERPTheme.BASE_COLOR,
                                    fontWeight: FontWeight.bold),
                              )
                            ]))
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Icon(
                      Icons.shopping_cart,
                      size: 55,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        frontLayer: const Center(
          child: Text("Front Layer"),
        ),
      ),
    );
    // return Scaffold(
    //   body: FoodMenuBody(),
    // );
  }
}
