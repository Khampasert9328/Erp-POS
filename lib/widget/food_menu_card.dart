import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_pos/constant/enum.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_size.dart';
import 'package:erp_pos/pages/food_menu_detail/components/food_menu_detail_body.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/sqlite_food_menu.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/theme.dart';

class FoodMenuCard extends StatelessWidget {
  int? number;
  Product data = Product();
  ERPFoodSize erpFoodSize = ERPFoodSize.Small;
  List<Product> listdata = [];
  final _refresh = GlobalKey<ScaffoldState>();

  int add = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer2<FoodMenuProvider, GetFoodMenuProvider>(
      builder: (context, foodModel, getFoodModel, child) {
        return Scrollbar(
          child: RefreshIndicator(
            onRefresh: () async{
              await Future.delayed(Duration(seconds: 2));
               GetFoodMenuProvider().getProduct(false);

            },
            key: _refresh,
            child: ListView.builder(
                itemCount: getFoodModel.listProduct.length,
                itemBuilder: (context, index) {
                  final data = getFoodModel.listProduct[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FoodMenuDetailBody(
                                  data: data.data,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                                color: Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Container(
                                      child: CachedNetworkImage(
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.image_outlined,
                                                size: 70,
                                                color: AppTheme.GREY_COLOR),
                                        imageUrl:
                                            data.data.thumbnails!.first.uri!,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            color: AppTheme.BASE_COLOR,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.data.name!,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.BASE_COLOR,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text.rich(TextSpan(
                                          text: 'ລາຄາ ',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppTheme.BASE_COLOR,
                                          ),
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(data.data.pricesale)} ກີບ',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ])),
                                      AddAmount()
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppTheme.BASE_COLOR,
                                        shape: BoxShape.circle),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 2.h),
                                    child: IconButton(
                                      onPressed: () async {
                                        SharedPreferences? preferences =
                                            await SharedPreferences.getInstance();
                                        int? amount = await preferences
                                            .getInt(CountPre().namkey);
                                        int? totalAmount =
                                            data.data.pricesale! * amount!;
                                        //addOrder(index);
                                        getFoodModel.setFoodMenuData(
                                            data.data, amount, totalAmount);
                                        foodModel.increment(add);
          
                                        getFoodModel.addTotalAmount(totalAmount);
                                      },
                                      icon: const Icon(
                                        Icons.add_shopping_cart_sharp,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FoodMenuSize(size: 0, title: 'S', index: index),
                            SizedBox(
                              width: 7.w,
                            ),
                            FoodMenuSize(size: 1, title: 'M', index: index),
                            SizedBox(
                              width: 7.w,
                            ),
                            FoodMenuSize(size: 2, title: 'L', index: index),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
