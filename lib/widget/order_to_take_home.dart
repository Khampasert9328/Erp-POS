import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_button.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/foodmenu_provider.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderToTakeHome extends StatefulWidget {
  OrderToTakeHome({Key? key}) : super(key: key);

  @override
  State<OrderToTakeHome> createState() => _OrderToTakeHomeState();
}

class _OrderToTakeHomeState extends State<OrderToTakeHome> {
  String title = 'ອໍເດີທີ່ສັ່ງກັບບ້ານ';

  int amountData = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetFoodMenuProvider>(
      builder: (context, value, child) {
        return ListView.builder(
            itemCount: value.getFoodMenuModel.length,
            itemBuilder: ((context, index) {
              int size = value.getFoodMenuModel[index].size;
              String numsize = setSize(size);
              int specialprice = value.getFoodMenuModel[index].specialprice;
              int count = value.getFoodMenuModel[index].amount;
              // void setNumber(bool isAdd) {
              //   if (isAdd) {
              //     setState(() {
              //       amountData = value.getFoodMenuModel[index].totalAmount;
              //       context
              //           .read<GetFoodMenuProvider>()
              //           .addTotalAmount(amountData);
              //     });
              //   } else {
              //     if (value.getFoodMenuModel[index].number > 1) {
              //       setState(() {
              //         amountData = value.getFoodMenuModel[index].totalAmount;

              //         context
              //             .read<GetFoodMenuProvider>()
              //             .deleteTotalAmount(amountData);
              //       });
              //     }
              //   }
              // }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
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
                              padding: const EdgeInsets.only(right: 30),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider)),
                                    ),
                                    height: 63.h,
                                    width: 69.w,
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
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value.getFoodMenuModel[index].data.name!,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.BASE_COLOR),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      context
                                          .read<GetFoodMenuProvider>()
                                          .deleteTotalAmount(value
                                              .getFoodMenuModel[index]
                                              .totalAmount);
                                      // context
                                      //     .read<GetFoodMenuProvider>()
                                      //     .deleteData(
                                      //         index,
                                      //         value.getFoodMenuModel[index]
                                      //             .totalAmount, value.getFoodMenuModel[index].number);
                                    },
                                    icon: Image.asset(
                                      ERPImages.icondelete,
                                    ),
                                  ),
                                ],
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
                                            '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(value.getFoodMenuModel[index].totalAmount)} ກີບ',
                                        style: TextStyle(
                                            fontFamily: 'Phetsarath-OT',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Column(
                                      children: [
                                        Text(
                                          count < 10 ? '0$count' : '$count',
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
                              ),
                              SizedBox(
                                height: 10.h,
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
                                        borderRadius: BorderRadius.circular(2)),
                                    child: Center(
                                      child: Text(
                                        numsize,
                                        style: TextStyle(
                                            color: AppTheme.WHITE_COLOR,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                ],
                              ),
                            ],
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
    );
  }
}
