import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/provider/listtable/list_table_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int selectTable = 0;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          "ລາຍການອໍເດີ",
          style: TextStyle(
            fontFamily: "Phetsarath-OT",
            color: AppTheme.BASE_COLOR,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: isloading
          ? CircularProgressIndicator()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<ListTableProvider>(
                    builder: (context, value, child) {
                      return GridView.count(
                        crossAxisCount: 2,
                        physics: ScrollPhysics(),
                        childAspectRatio: (0.8.w / .5.h),
                        shrinkWrap: true,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 10.0,
                        children:
                            List.generate(value.itemtable.length, (index) {
                          return GestureDetector(
                            onTap: (() {
                              bool clicktable = true;

                              setState(() {
                                selectTable = index;
                              });
                            }),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppTheme.BASE_COLOR,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 50.h,
                                        width: 10.w,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          border: Border.all(
                                              color: AppTheme.BASE_COLOR),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Container(
                                          height: 70.h,
                                          width: 130.w,
                                          decoration: BoxDecoration(
                                              color: selectTable == index
                                                  ? AppTheme.BASE_COLOR
                                                  : AppTheme.GREY_COLOR,
                                              border: Border.all(
                                                  color: AppTheme.BASE_COLOR),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              selectTable == index
                                                  ? Icon(
                                                      Icons.check_circle,
                                                      color:
                                                          AppTheme.WHITE_COLOR,
                                                    )
                                                  : SizedBox(),
                                              Center(
                                                child: Text(
                                                  value.itemtable[index],
                                                  style: TextStyle(
                                                    color: selectTable == index
                                                        ? AppTheme.WHITE_COLOR
                                                        : AppTheme.BASE_COLOR,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Container(
                                        height: 50.h,
                                        width: 10.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppTheme.BASE_COLOR),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    height: 10.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppTheme.BASE_COLOR),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
