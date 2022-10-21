import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderToTakeHome extends StatelessWidget {
  OrderToTakeHome({Key? key}) : super(key: key);

  String title = 'ອໍເດີທີ່ສັ່ງກັບບ້ານ';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<GetFoodMenuProvider>(
        builder: (context, value, child) {
          return ListView.builder(
              itemCount: value.getFoodMenuModel.length,
              itemBuilder: ((context, index) {
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: imageProvider)),
                                      ),
                                      height: 100.h,
                                      width: 100.w,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.image_outlined,
                                              size: 70,
                                              color: AppTheme.GREY_COLOR),
                                      imageUrl: value.getFoodMenuModel[index]
                                          .data.thumbnails!.first.uri!,
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        value
                                            .getFoodMenuModel[index].data.name!,
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
                                            context
                                                .read<GetFoodMenuProvider>()
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
                                                fontFamily: 'Phetsarath-OT',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
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
                                                BorderRadius.circular(2)),
                                        child: Center(
                                          child: Text(
                                            "S",
                                            style: TextStyle(
                                                color: AppTheme.WHITE_COLOR,
                                                fontWeight: FontWeight.bold),
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
    );
  }
}
