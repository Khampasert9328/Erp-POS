import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_pos/constant/enum.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_size.dart';
import 'package:erp_pos/pages/food_menu_detail/components/food_menu_detail_body.dart';
import 'package:erp_pos/provider/category/category_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/foodmenu_provider.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/theme.dart';

class FoodMenuCard extends StatefulWidget {
  @override
  State<FoodMenuCard> createState() => _FoodMenuCardState();
}

class _FoodMenuCardState extends State<FoodMenuCard> {
  final _refresh = GlobalKey<RefreshIndicatorState>();
  void initState() {
    super.initState();
    context.read<GetFoodMenuProvider>().getProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 95),
      child: Consumer2<FoodMenuProvider, GetFoodMenuProvider>(
        builder: (context, foodModel, getFoodModel, child) {
          return getFoodModel.isloading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.BASE_COLOR,
                  ),
                )
              : getFoodModel.listProduct == null
                  ? const Center(
                      child: Text("ບໍ່ມີຂໍ້ມູນລາຍການອາຫານ"),
                    )
                  : Scrollbar(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 2)).then(
                            (value) {
                              setState(() {
                                context
                                    .read<GetFoodMenuProvider>()
                                    .getProduct(true);
                              });
                            },
                          );
                        },
                        key: _refresh,
                        child: ListView.builder(
                            itemCount: getFoodModel.listProduct.length,
                            itemBuilder: (context, index) {
                              final data = getFoodModel.listProduct[index];
                              int mainsize = data.size;
                              int counter = data.count;

                              int specialPrice =
                                  data.data.size![data.size].specialPrice!;
                              int pricesale = data.data.pricesale!;

                              String categoryname = '';
                              var category_models =
                                  context.read<GetFoodMenuProvider>().category;
                              for (var idcategory
                                  in category_models!.category!) {
                                if (data.data.categoryid == idcategory.id) {
                                  categoryname = idcategory.cate!;
                                }
                              }

                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 10.w),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF4F5F6),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: CachedNetworkImage(
                                                  memCacheHeight: 63,
                                                  memCacheWidth: 69,
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Icon(Icons.image_outlined,
                                                          size: 70,
                                                          color: AppTheme
                                                              .GREY_COLOR),
                                                  imageUrl: data.data
                                                      .thumbnails!.first.uri!,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color:
                                                          AppTheme.BASE_COLOR,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 11.w,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.data.name!,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Phetsarath-OT',
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            AppTheme.BASE_COLOR,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text.rich(TextSpan(
                                                        text: 'ລາຄາ ',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: AppTheme
                                                              .BASE_COLOR,
                                                          fontFamily:
                                                              'Phetsarath-OT',
                                                        ),
                                                        children: <InlineSpan>[
                                                          TextSpan(
                                                            text:
                                                                '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(pricesale + specialPrice)} ກີບ',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Phetsarath-OT',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        ])),
                                                    AddAmount(index: index),
                                                  ],
                                                ),
                                              ),
                                              //if(data.isaddtochart)
                                              data.isaddtochart
                                                  ? LikeButton(
                                                      size: 55,
                                                      animationDuration:
                                                          Duration(seconds: 1),
                                                      likeBuilder: ((isLiked) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                              color: AppTheme
                                                                  .YELLOW_COLOR,
                                                              shape: BoxShape
                                                                  .circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                    spreadRadius:
                                                                        5,
                                                                    blurRadius:
                                                                        7,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            3))
                                                              ]),
                                                          child: Image.asset(
                                                            ERPImages.categcory,
                                                            color: AppTheme
                                                                .WHITE_COLOR,
                                                            cacheHeight: 30,
                                                            cacheWidth: 30,
                                                          ),
                                                        );
                                                      }),
                                                      onTap: ((isLiked) async {
                                                        if (counter == 0) {
                                                          Mystyle()
                                                              .showDialogCheckData(
                                                                  context,
                                                                  "ກາລຸນາກົດເພື່ອເພີ່ມຈຳນວນອາຫານ");
                                                        } else {
                                                          int totalAmount =
                                                              (pricesale +
                                                                      specialPrice) *
                                                                  counter;
                                                          getFoodModel
                                                              .setFoodMenuData(
                                                                  data.data,
                                                                  counter,
                                                                  totalAmount,
                                                                  data.size,
                                                                  counter,
                                                                  pricesale +
                                                                      specialPrice,
                                                                  categoryname);

                                                          getFoodModel
                                                              .addTotalAmount(
                                                                  totalAmount);
                                                        }
                                                        return !isLiked;
                                                      }),
                                                    )
                                                  : LikeButton(
                                                      size: 55,
                                                      animationDuration:
                                                          Duration(seconds: 1),
                                                      likeBuilder: ((isLiked) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                              color: AppTheme
                                                                  .YELLOW_COLOR,
                                                              shape: BoxShape
                                                                  .circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                    spreadRadius:
                                                                        5,
                                                                    blurRadius:
                                                                        7,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            3))
                                                              ]),
                                                          child: Image.asset(
                                                            ERPImages.categcory,
                                                            color: AppTheme
                                                                .WHITE_COLOR,
                                                            cacheHeight: 30,
                                                            cacheWidth: 30,
                                                          ),
                                                        );
                                                      }),
                                                      onTap: ((isLiked) async {
                                                        if (counter == 0) {
                                                          Mystyle()
                                                              .showDialogCheckData(
                                                                  context,
                                                                  "ກາລຸນາກົດເພື່ອເພີ່ມຈຳນວນອາຫານ");
                                                        } else {
                                                          int totalAmount =
                                                              (pricesale +
                                                                      specialPrice) *
                                                                  counter;
                                                          getFoodModel
                                                              .setFoodMenuData(
                                                                  data.data,
                                                                  counter,
                                                                  totalAmount,
                                                                  data.size,
                                                                  counter,
                                                                  pricesale +
                                                                      specialPrice,
                                                                  categoryname);
                                                          getFoodModel
                                                              .addTotalAmount(
                                                                  totalAmount);

                                                          getFoodModel
                                                              .clearCount(
                                                                  index);
                                                        }
                                                        return !isLiked;
                                                      }),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        for (var i in data.data.size!)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: 7.w,
                                            ),
                                            child: FoodMenuSize(
                                              onPressed: (() {
                                                context
                                                    .read<GetFoodMenuProvider>()
                                                    .setProductSize(
                                                        i.size ?? 0, index);
                                              }),
                                              mainsize: mainsize,
                                              size: i.size ?? 0,
                                              title: setSize(i.size ?? 0),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    );
        },
      ),
    );
  }
}
