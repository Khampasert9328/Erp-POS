// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_button.dart';
import 'package:erp_pos/pages/food_menu/models/food_menu_data_model.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';

import 'package:erp_pos/provider/checkexpiredpackage/check_exp_package_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/foodmenu_provider.dart';
import 'package:erp_pos/provider/tableprovider/click_table_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/utils/loading.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:erp_pos/widget/calculate_money.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/theme.dart';

class SelectedMenuCardExpand extends StatefulWidget {
  VoidCallback onNext;
  GetTable? data;
  bool selectMenu = false;
  SelectedMenuCardExpand({
    required this.onNext,
    required this.selectMenu,
    required this.data,
  });

  @override
  State<SelectedMenuCardExpand> createState() => _SelectedMenuCardExpandState();
}

class _SelectedMenuCardExpandState extends State<SelectedMenuCardExpand> {
  //int sumData = 0;
  bool checkerror = false;
  Widget build(BuildContext context) {
    bool showClickTable = context.read<ClickTableProvider>().click;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 10.h,
            width: 50.w,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
          ),
          showClickTable
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ລາຍການອໍເດີ",
                      style: TextStyle(
                          fontFamily: 'Phetsarath-OT',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.BASE_COLOR),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "ໂຕະ:",
                            style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.BASE_COLOR),
                          ),
                          Text(
                            "${widget.data!.name}",
                            style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.BASE_COLOR),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Consumer<GetFoodMenuProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.getFoodMenuModel.length,
                  itemBuilder: ((context, index) {
                    int size = value.getFoodMenuModel[index].size;
                    int count = value.getFoodMenuModel[index].amount;
                    String numsize = setSize(size);
                    int specialprice =value.getFoodMenuModel[index].specialprice;
                  
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          height: 85.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  height: 63.h,
                                  width: 69.w,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: imageProvider)),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.image_outlined,
                                      size: 70,
                                      color: AppTheme.GREY_COLOR),
                                  imageUrl: value.getFoodMenuModel[index].data
                                      .thumbnails!.first.uri!,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: AppTheme.BASE_COLOR,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.getFoodMenuModel[index].data.name!,
                                      style: TextStyle(
                                          fontFamily: 'Phetsarath-OT',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.BASE_COLOR),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                          text: 'ລາຄາ ',
                                          style: TextStyle(
                                              fontFamily: 'Phetsarath-OT',
                                              fontSize: 14.sp,
                                              color: AppTheme.BASE_COLOR),
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(specialprice)} ກີບ',
                                              style: TextStyle(
                                                fontFamily: 'Phetsarath-OT',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ]),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'ຈຳນວນ',
                                          style: TextStyle(
                                            fontFamily: 'Phetsarath-OT',
                                            fontSize: 14.sp,
                                            color: AppTheme.BASE_COLOR,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            value.deletecountdetail(index);
                                            value.deleteTotalAmount(specialprice);
                                          },
                                          child: FoodMenuButton(
                                            title: '-',
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: Column(
                                            children: [
                                              Text(
                                                count <10 ? '0$count':'$count',
                                                style: TextStyle(
                                                    color: AppTheme.BASE_COLOR,
                                                    fontSize: 14.sp),
                                              ),
                                              Container(
                                                width: 20.w,
                                                height: 3.h,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFD9D9D9)),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            context
                                                .read<GetFoodMenuProvider>()
                                                .addcountdetailproduct(index);
                                             value.addTotalAmount(specialprice);
                                          },
                                          child: FoodMenuButton(
                                            title: '+',
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              //////////////////////ປຸ່ມລົບຂໍ້ມູນ
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        context
                                            .read<GetFoodMenuProvider>()
                                            .deleteData(
                                                index,
                                                specialprice*count,
                                                );
                                      }),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Image.asset(
                                          ERPImages.icondelete,
                                          width: 16.w,
                                          height: 20.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 28.h,
                          width: 28.w,
                          child: Badge(
                            badgeContent: Center(
                              child: Text(
                                "$numsize",
                                style: TextStyle(
                                    color: AppTheme.WHITE_COLOR,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            badgeColor: AppTheme.GREEN_COLOR,
                          ),
                        ),
                      ],
                    );
                  }),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            decoration: const BoxDecoration(color: Color(0xFFF4F5F6)),
            child: Row(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shopping_cart,
                        size: (30.w + 30.h) / 2,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ລວມລາຄາ:',
                          style: TextStyle(
                            fontFamily: 'Phetsarath-OT',
                            fontSize: 15.sp,
                            color: AppTheme.BASE_COLOR,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                ' ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ',
                                style: TextStyle(
                                  fontFamily: 'Phetsarath-OT',
                                  fontSize: 15.sp,
                                  color: AppTheme.BASE_COLOR,
                                ),
                              ),
                              Text(
                                'ກີບ',
                                style: TextStyle(
                                    fontFamily: 'Phetsarath-OT',
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          showClickTable
              ? sendingtokitchen()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    context.read<GetFoodMenuProvider>().getFoodMenuModel.isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    primary: AppTheme.BASE_COLOR),
                                onPressed: widget.onNext,
                                child: Text(
                                  'ຕໍ່ໄປ',
                                  style: TextStyle(
                                    fontFamily: 'Phetsarath-OT',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                          ),
                    SizedBox(
                      width: 5.w,
                    )
                  ],
                ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }

  sendingtokitchen() => Padding(
        padding: const EdgeInsets.only(right: 18, left: 18, bottom: 10),
        child: SizedBox(
          height: 39.h,
          width: double.infinity,
          child: context.read<GetFoodMenuProvider>().getFoodMenuModel.isEmpty
              ? const Text("")
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    primary: AppTheme.BASE_COLOR,
                  ),
                  onPressed: () async {
                    if (context
                        .read<GetFoodMenuProvider>()
                        .getFoodMenuModel
                        .isEmpty) {
                      Mystyle().showDialogCheckData(
                          context, "ກາລຸນາກວດສອບອໍເດີຂອງທ່ານກ່ອນ");
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: ShowLoading(
                              title: "ກຳລັງສົ່ງອໍເດີໄປຫ້ອງຄົວ...",
                            ),
                          );
                        },
                      );
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.of(context).pop();
                      //provider ໃນການສັ່ງອໍເດີ
                      context
                          .read<CheckExpiredPackage>()
                          .getCheckExpiredPackage(
                              context,
                              widget.data!.tablearea!.id!,
                              widget.data!.tablearea!.area!,
                              widget.data!.id!,
                              widget.data!.name!);

                      String? tablename = await CountPre().getTableName();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CalculateMoney(
                            tablename: widget.data!.name!,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'ສົ່ງຫ້ອງຄົວ',
                    style: TextStyle(
                      fontFamily: 'Phetsarath-OT',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
        ),
      );
}
