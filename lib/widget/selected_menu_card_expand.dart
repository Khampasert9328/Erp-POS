import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/sqlite_food_menu.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/utils/sqliteERP/sqlite_erp_pos.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/theme.dart';

class SelectedMenuCardExpand extends StatefulWidget {
  VoidCallback onNext;

  bool selectMenu = false;

  SelectedMenuCardExpand(
      {required this.onNext,
   
      required this.selectMenu});

  @override
  State<SelectedMenuCardExpand> createState() => _SelectedMenuCardExpandState();
}

class _SelectedMenuCardExpandState extends State<SelectedMenuCardExpand> {
  int count = 0;
  void setNumber(bool isAdd) {
    if (isAdd) {
      setState(() {
        count++;
      });
    } else {
      if (count > 0) {
        setState(() {
          count--;
        });
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: StatefulBuilder(
        builder: (context, setState) => Column(
          children: [ 
            Expanded(
              child: Consumer<GetFoodMenuProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                      itemCount: value.getFoodMenuModel.length,
                      itemBuilder: ((context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 20.w),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF4F5F6),
                                    borderRadius: BorderRadius.circular(7.r)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Column(
                                          children: [
                                            CachedNetworkImage(
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                        image: imageProvider)),
                                              ),
                                              height: 100.h,
                                              width: 100.w,
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                      Icons.image_outlined,
                                                      size: 70,
                                                      color:
                                                          AppTheme.GREY_COLOR),
                                              imageUrl: value
                                                  .getFoodMenuModel[index]
                                                  .data
                                                  .thumbnails!
                                                  .first
                                                  .uri!,
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppTheme.BASE_COLOR,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                value.getFoodMenuModel[index]
                                                    .data.name!,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppTheme.BASE_COLOR),
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    context
                                                        .read<
                                                            GetFoodMenuProvider>()
                                                        .deleteTotalAmount(value
                                                            .getFoodMenuModel[
                                                                index]
                                                            .totalAmount);
                                                    context
                                                        .read<
                                                            GetFoodMenuProvider>()
                                                        .deleteData(index);
                                                  },
                                                  icon: Image.asset(
                                                      ERPImages.icondelete)),
                                            ],
                                          ),
                                          Text.rich(
                                            TextSpan(
                                                text: 'ລາຄາ ',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: AppTheme.BASE_COLOR),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text:
                                                        '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(value.getFoodMenuModel[index].totalAmount)} ກີບ',
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                          ),
                                          AddAmount(),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 22.h,
                                                width: 22.w,
                                                decoration: BoxDecoration(
                                                    color: AppTheme.BASE_COLOR,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2)),
                                                child: Center(
                                                  child: Text(
                                                    "S",
                                                    style: TextStyle(
                                                        color: AppTheme
                                                            .WHITE_COLOR,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        );
                      }));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              decoration: BoxDecoration(color: Color(0xFFF4F5F6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_cart,
                            size: (30.w + 30.h) / 2,
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'ລວມລາຄາ: ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppTheme.BASE_COLOR,
                        ),
                      )
                    ],
                  ),
                  Text(
                    'ກີບ',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              context.read<GetFoodMenuProvider>().getFoodMenuModel.isEmpty?Text(""):  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        primary: AppTheme.BASE_COLOR),
                    onPressed: widget.onNext,
                    child: Text(
                      'ຕໍ່ໄປ',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w700),
                    )),
                SizedBox(
                  width: 20.w,
                )
              ],
            ) 
          ],
        ),
      ),
    );
  }
}
