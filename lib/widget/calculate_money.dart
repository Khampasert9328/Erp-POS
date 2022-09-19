// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/paymentmethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CalculateMoney extends StatelessWidget {
  final tablename;
  const CalculateMoney({
    Key? key,
    required this.tablename,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        title: Text(
          tablename,
          style: TextStyle(color: AppTheme.BASE_COLOR),
        ),
      ),
      bottomNavigationBar: Container(
        height: 145.h,
        child: BottomAppBar(
          notchMargin: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.GREY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Badge(
                        badgeContent: Text(
                          context
                              .watch<GetFoodMenuProvider>()
                              .getFoodMenuModel
                              .length
                              .toString(),
                          style: TextStyle(
                            color: AppTheme.WHITE_COLOR,
                          ),
                        ),
                        child: Image.asset(
                          ERPImages.cart,
                          height: 45.h,
                          width: 45.w,
                          color: Colors.grey[200],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "ລາຄາລວມ:",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppTheme.BASE_COLOR,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "700000",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppTheme.BASE_COLOR,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppTheme.BASE_COLOR,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ERPImages.printbill),
                          SizedBox(
                            width: 10.w,
                          ),
                          Center(
                            child: Text(
                              "ພິມໃບບິນ",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppTheme.BASE_COLOR,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppTheme.BASE_COLOR,
                          border: Border.all(
                            color: AppTheme.BASE_COLOR,
                          )),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PayMentMethod(
                                  tablename: tablename,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "ຄິດໄລ່ເງິນ",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppTheme.WHITE_COLOR,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: context.read<GetFoodMenuProvider>().getFoodMenuModel.length,
        itemBuilder: ((context, index) {
          return SizedBox();
        }),
      ),
    );
  }
}
