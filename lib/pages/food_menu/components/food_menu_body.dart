import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/widget/erp_textfield.dart';
import 'package:erp_pos/widget/food_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodMenuBody extends StatefulWidget {
  @override
  State<FoodMenuBody> createState() => _FoodMenuBodyState();
}

class _FoodMenuBodyState extends State<FoodMenuBody> {
  TextEditingController searchMenu = TextEditingController();

  List<String> foodType = [
    'ເຂົ້າລາດໜ້າ',
    'ເຄື່ອງດື່ມ',
    'ນ້ຳ',
  ];

  String selectedFoodType = '';
  int amount = 50000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedFoodType = foodType.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Text(
                'ລາຍການອາຫານ',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: ERPTextfield(
                          controller: searchMenu, hintText: 'ຄົ້ນຫາອາຫານ')),
                  SizedBox(
                    width: 15.w,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        size: 45,
                      ))
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 30.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        color: Colors.red,
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: ERPTheme.BASE_COLOR,
                          size: 30,
                        )),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: foodType.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFoodType = foodType[index];
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              foodType[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(
                                      selectedFoodType == foodType[index]
                                          ? 0xFF283150
                                          : 0xFF999DAA),
                                  fontSize: 18.sp,
                                  decoration:
                                      selectedFoodType == foodType[index]
                                          ? TextDecoration.underline
                                          : TextDecoration.none),
                            ),
                          ),
                        );
                      },
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  int number = 0;
                  return FoodMenuCard(
                    image: ERPImages.bcelone,
                    title: 'HamBurger $index',
                    amount: amount,
                  );
                },
              ))
            ],
          ),
        )),
        Material(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 15.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.r),
                topLeft: Radius.circular(15.r),
              ),
            ),
            child: Row(
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
          ),
        )
      ],
    );
  }
}
