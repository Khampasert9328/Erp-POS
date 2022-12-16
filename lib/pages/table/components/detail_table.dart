// ignore_for_file: sort_child_properties_last

import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/main.dart';
import 'package:erp_pos/pages/table/components/buil_buildbuttonbooking.dart';
import 'package:erp_pos/pages/table/components/floatingActionButton.dart';
import 'package:erp_pos/utils/check_status.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DetailTable extends StatefulWidget {
  final id;
  final title;
  final color;
  const DetailTable({
    Key? key,
    required this.title,
    required this.color,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailTable> createState() => _DetailTableState();
}

class _DetailTableState extends State<DetailTable> {
  bool isWitch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.WHITE_COLOR,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.BLACK_COLOR,
              ),
            ),
            Text(
              widget.id,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.BLACK_COLOR,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isWitch == false
          ? Text("")
          : Container(
              padding: EdgeInsets.symmetric(
                vertical: 7.w,
                horizontal: 30.0.h,
              ),
              width: double.infinity,
              child: widget.color == Color(0xFFFCE00D2)
                  ? Text("")
                  : Container(
                      child: widget.color == Colors.red
                          ? Text("")
                          : BuidlButtonBooking()),
            ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: 15.w,
            left: 15.w,
            top: 20.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Switch(
                    activeColor: AppTheme.GREEN_COLOR,
                    value: isWitch,
                    onChanged: (vale) {
                      if (isWitch == true) {
                        setState(() {
                          isWitch = vale;
                        });
                      } else {
                        setState(() {
                          isWitch = vale;
                        });
                      }
                    },
                  ),
                ],
              ),
              isWitch == false
                  ? Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Image.asset(ERPImages.offtable)),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 100.w, left: 100.w),
                          child: Container(
                            padding: EdgeInsets.only(left: 12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: widget.color,
                            ),
                            height: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                color: AppTheme.GREY_COLOR,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      widget.id,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: widget.color,
                              radius: 17.h,
                              child: Image.asset(
                                ERPImages.tableStatus,
                                height: 15.h,
                                width: 15.w,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            // Text(
                            //   checkStatus(
                            //     widget.color,
                            //   ),
                            //   style: TextStyle(
                            //     fontFamily: 'Phetsarath-OT',
                            //     fontSize: 15.sp,
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Mystyle().subtiTle1("ເລກໂຕະ"),
                            Row(
                              children: [
                                Mystyle().tiTle1(widget.title),
                                Mystyle().tiTle1(widget.id),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Mystyle().subtiTle1("ຊື່ໂຊນ ຫຼື ພື້ນທີ່"),
                            Mystyle().tiTle1("ຊັ້ນ 1")
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        widget.color == Color(0xFFFCE00D2)
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Mystyle().tiTle1("ຂໍ້ມູນການຈອງ")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Mystyle().subtiTle1("ຊື່ ແລະ ນາມສະກຸນ"),
                                      Text(
                                        "Mr. Jay",
                                        style: TextStyle(
                                          fontFamily: 'Phetsarath-OT',
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Mystyle().subtiTle1("ເບີໂທຕິດຕໍ່"),
                                      Text("02093286912"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Mystyle().subtiTle1("ຈຳນວນລູກຄ້າ"),
                                      Text("12"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Mystyle().subtiTle1("ວັນທີ ແລະ ເວລາ"),
                                      Text(DateFormat('yyy-MM-dd kk:mm:ss a')
                                          .format(DateTime.now())),
                                    ],
                                  ),
                                ],
                              )
                            : const Text(""),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
