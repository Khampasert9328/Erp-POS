import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_pos/constant/enum.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/pages/food_menu/food_menu.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:erp_pos/widget/add_on_dialog.dart';
import 'package:erp_pos/widget/erp_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:erp_pos/constant/routes.dart' as custom_route;

class FoodMenuDetailBody extends StatefulWidget {
  Product? data;
  FoodMenuDetailBody({Key? key, required this.data}) : super(key: key);

  @override
  State<FoodMenuDetailBody> createState() => _FoodMenuDetailBodyState();
}

class _FoodMenuDetailBodyState extends State<FoodMenuDetailBody> {
  ERPFoodSize erpFoodSize = ERPFoodSize.Small;
  TextEditingController detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              CachedNetworkImage(
               errorWidget: (context, url, error) => Icon(Icons.image_outlined,size: 70,color: ERPTheme.GREY_COLOR),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300.h,
                imageUrl: widget.data!.thumbnails!.first.uri!,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: ERPTheme.BASE_COLOR,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          size: (30.w + 30.h) / 2,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, custom_route.Route.addFoodMenu);
                        },
                        icon: Icon(
                          Icons.edit,
                          size: (20.w + 20.h) / 2,
                          color: Colors.white,
                        )),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'ອາຫານມີພ້ອມເສີບ',
            style: TextStyle(color: Color(0xFF3CB95F), fontSize: 20.sp),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AddAmount(),
                    Row(
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
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  widget.data!.name!,
                  style: TextStyle(
                      color: ERPTheme.BASE_COLOR,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Non adipiscing diam volutpat cursus. A gravida at urna, sollicitudin aliquam arcu. ',
                  style: TextStyle(color: ERPTheme.BASE_COLOR, fontSize: 14.sp),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    Text(
                      'ເພີ່ມຕື່ມ',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    IconButton(
                      onPressed: () {
                        addOnDialog(context);
                      },
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                buildOtherMenu(),
                buildOtherMenu(),
                buildOtherMenu(),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'ລາຍລະອຽດອື່ນໆ',
                  style: TextStyle(fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Container(
                  decoration: BoxDecoration(color: Color(0xFFF4F5F6)),
                  child: ERPTextfield(
                    controller: detail,
                    hintText: '',
                    maxlines: 5,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Padding buildOtherMenu() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AddAmount(
            title: 'Cheese',
          ),
          Text(
            '15,000 Kip',
            style: TextStyle(fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
          )
        ],
      ),
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
}
