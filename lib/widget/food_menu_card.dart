// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_pos/constant/enum.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/pages/food_menu_detail/components/food_menu_detail_body.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/sqlite_food_menu.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_services.dart';
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
import 'package:erp_pos/constant/routes.dart' as custom_route;

class FoodMenuCard extends StatefulWidget {
  @override
  State<FoodMenuCard> createState() => _FoodMenuCardState();
}

class _FoodMenuCardState extends State<FoodMenuCard> {
  int? number;
  Product data = Product();
  ERPFoodSize erpFoodSize = ERPFoodSize.Small;
  List<Product> listdata = [];

  int add = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>?>(
      future: GETFoodMenuProvider().getProduct(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Consumer<FoodMenuProvider>(
            builder: ((context, models, child) {
              return SizedBox(
                height: 350.h,
                child: Scrollbar(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final index1 = snapshot.data![index];
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
                                        data: snapshot.data![index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 10.w),
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
                                          child: Container(
                                            child: CachedNetworkImage(
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                      Icons.image_outlined,
                                                      size: 70,
                                                      color:
                                                          ERPTheme.GREY_COLOR),
                                              imageUrl: snapshot.data![index]
                                                  .thumbnails!.first.uri!,
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: ERPTheme.BASE_COLOR,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].name!,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: ERPTheme.BASE_COLOR),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text.rich(TextSpan(
                                                text: 'ລາຄາ ',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: ERPTheme.BASE_COLOR),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text:
                                                        '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(snapshot.data![index].pricesale)} ກີບ',
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ])),
                                            AddAmount()
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ERPTheme.BASE_COLOR,
                                              shape: BoxShape.circle),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w, vertical: 3.h),
                                          child: IconButton(
                                            onPressed: () async {
                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              int? amount = preferences
                                                  .getInt(CountPre().namkey);
                                              int totalAmount = snapshot.data![index].pricesale! * amount!;
                                              //addOrder(index);
                                              context.read<GETFoodMenuProvider>().setFoodMenuData(snapshot.data![index], amount, totalAmount);
                                              context
                                                  .read<FoodMenuProvider>()
                                                  .increment(add);

                                                 context.read<GETFoodMenuProvider>().addTotalAmount(totalAmount);
                                                 print("amount:$totalAmount");
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
                                  buildSize('S', ERPFoodSize.Small),
                                  SizedBox(
                                    width: 7.w,
                                  ),
                                  buildSize('M', ERPFoodSize.Medium),
                                  SizedBox(
                                    width: 7.w,
                                  ),
                                  buildSize('L', ERPFoodSize.Large),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ),
              );
            }),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: ERPTheme.BASE_COLOR,
            ),
          );
        }
      }),
    );
  }

  GestureDetector buildSize(String title, ERPFoodSize size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          erpFoodSize = size;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
            color: erpFoodSize == size ? ERPTheme.BASE_COLOR : Colors.white,
            border: Border.all(
                color: erpFoodSize == size
                    ? ERPTheme.BASE_COLOR
                    : Color(0xFFD9D9D9))),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: erpFoodSize == size ? Colors.white : Color(0xFFD9D9D9)),
        ),
      ),
    );
  }

  Future<List<Product>?> addOrder(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? amount = preferences.getInt(CountPre().namkey);
    int? price;
    String? name,
        image,
        categoryid,
        size,
        priceimport,
        status,
        uuid,
        id,
        postype,
        selected;

    GetFoodMenuModels? modelsProduct = await getfoodmenu();
    if (modelsProduct != null) {
      listdata = modelsProduct.product!;
      name = listdata[index].name;
      price = listdata[index].pricesale;
      image = listdata[index].thumbnails!.first.uri!;
      categoryid = listdata[index].categoryid.toString();
      size = listdata[index].size!.first.size!.toString();
      priceimport = listdata[index].priceimport.toString();
      status = listdata[index].status!.toString();
      uuid = listdata[index].uuid.toString();
      id = listdata[index].id.toString();
      postype = listdata[index].postype.toString();
      selected = listdata[index].selected.toString();
    }
    int sum = int.parse(price.toString()) * amount!;

    //ເກັບລາຄາລວມໄປ provider
    context.read<FoodMenuProvider>().addTotalamount(sum);

    Map<String, dynamic> map = Map();
    map['id'] = id.toString();
    map['uuid'] = uuid.toString();
    map['name'] = name.toString();
    map['categoryid'] = categoryid.toString();
    map['image'] = image.toString();
    map['size'] = size.toString();
    map['pricesale'] = price;
    map['priceimport'] = priceimport.toString();
    map['status'] = status.toString();
    map['postype'] = postype.toString();
    map['selected'] = selected.toString();
    map['sum'] = sum.toString();
    Category? model = Category.fromJson(map);
    try {
      await SQLiteERPPOS().insertData(model).then((value) {
        // FoodSlite().addCount();
      });
    } catch (e) {
      print("error:$e");
    }
  }

  Container buildButton(IconData iconData, String title) {
    return Container(
      height: 30.h,
      width: 20.w,
      decoration: BoxDecoration(
          border: Border.all(color: ERPTheme.BASE_COLOR),
          shape: BoxShape.circle),
      child: Center(child: Text(title)),
    );
  }
}
