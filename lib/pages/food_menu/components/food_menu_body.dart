import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/widget/add_food_type_dialog.dart';
import 'package:erp_pos/widget/erp_textfield.dart';
import 'package:erp_pos/widget/food_menu_card.dart';
import 'package:erp_pos/widget/selected_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:erp_pos/constant/routes.dart' as custom_route;

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
  double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

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
    _initFabHeight = MediaQuery.of(context).size.height * 0.14;
    _panelHeightClosed = MediaQuery.of(context).size.height * 0.12;
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.9;
    return Stack(
      children: [
        SlidingUpPanel(
          maxHeight: _panelHeightOpen,
          minHeight: _panelHeightClosed,
          parallaxEnabled: true,
          parallaxOffset: .5,
          body: buildBody(context),
          panelBuilder: (sc) => _panel(sc),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          onPanelSlide: (double pos) => setState(() {
            _fabHeight =
                pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
          }),
        ),
        Positioned(
          right: 20.0,
          bottom: _fabHeight,
          child: buildFloatingButton(context),
        ),
      ],
    );
  }

  ElevatedButton buildFloatingButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          primary: ERPTheme.BASE_COLOR,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r))),
      onPressed: () {
        Navigator.pushNamed(context, custom_route.Route.addFoodMenu);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            ERPImages.icSoup,
            width: 25.w,
            height: 25.h,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            'ເພີ່ມລາຍການ',
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          )
        ],
      ),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
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
                    onPressed: () {
                      addFoodTypeDialog(context);
                    },
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
                              color: Color(selectedFoodType == foodType[index]
                                  ? 0xFF283150
                                  : 0xFF999DAA),
                              fontSize: 18.sp,
                              decoration: selectedFoodType == foodType[index]
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
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: sc,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.h, vertical: 15.h),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ລາຍການອາຫານ',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: ERPTheme.BASE_COLOR),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text.rich(TextSpan(
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: ERPTheme.BASE_COLOR),
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
                            ),
                            Icon(
                              Icons.shopping_cart,
                              size: 55,
                            )
                          ],
                        ),
                      ),
                      SelectedMenuCard()
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              decoration: BoxDecoration(color: Color(0xFFF4F5F6)),
              child: Row(
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
                        'ລວມລາຄາ:',
                        style: TextStyle(
                            fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
