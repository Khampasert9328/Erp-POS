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
  final title;
  final color;
  const DetailTable({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  State<DetailTable> createState() => _DetailTableState();
}

class _DetailTableState extends State<DetailTable> {
  bool isWitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ERPTheme.WHITE_COLOR,
        centerTitle: true,
        title: Text(
          "TB00",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ERPTheme.BLACK_COLOR,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isWitch == false
          ? Text("")
          : Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 30.0),
              width: double.infinity,
              child: widget.color == Colors.pinkAccent
                  ? Text("")
                  : BuidlButtonBooking(),
            ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Switch(
                  activeColor: ERPTheme.GREEN_COLOR,
                  value: isWitch,
                  onChanged: (vale) {
                    if (isWitch == false) {
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
                    child: Center(child: Image.asset(POSImages.offtable)),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 100.w, left: 100.w),
                        child: Container(
                          padding: EdgeInsets.all(20.h),
                          child: const Center(
                            child: Text("TB00"),
                          ),
                          decoration: BoxDecoration(
                            color: ERPTheme.GREY_COLOR,
                            border: Border(
                              left: BorderSide(
                                color: widget.color,
                                width: 10.0,
                              ),
                            ),
                            //borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: widget.color,
                              radius: 15,
                              child: Image.asset(
                                POSImages.tableStatus,
                                height: 15.h,
                                width: 15.w,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(checkStatus(widget.color))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Mystyle().subtiTle1("ເລກໂຕະ"),
                            Mystyle().tiTle1("TB00")
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.w, left: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Mystyle().subtiTle1("ຊື່ໂຊນ ຫຼື ພື້ນທີ່"),
                            Mystyle().tiTle1("ຫ້ອງອາຫານຊັ້ນ 01")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      widget.color == Colors.pinkAccent
                          ? Padding(
                              padding: EdgeInsets.only(right: 15.w, left: 15.w),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Mystyle().tiTle1("ຂໍ້ມູນການຈອງ")
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Mystyle().subtiTle1("ຊື່ ແລະ ນາມສະກຸນ"),
                                      Text("Mr. Jay"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Mystyle().subtiTle1("ເບີໂທຕິດຕໍ່"),
                                      Text("02093286912"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Mystyle().subtiTle1("ຈຳນວນລູກຄ້າ"),
                                      Text("12"),
                                    ],
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
                              ),
                            )
                          : Text(""),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
