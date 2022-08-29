// ignore_for_file: sort_child_properties_last

import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/table/components/textdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';

class TableDetail extends StatefulWidget {
  GetTable? data;
  TableDetail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<TableDetail> createState() => _TableDetailState();
}

class _TableDetailState extends State<TableDetail> {
  bool isWitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ERPTheme.WHITE_COLOR,
        elevation: 0,
        title: Text(
          "${widget.data!.name}",
          style: TextStyle(color: ERPTheme.BLACK_COLOR),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isWitch == true
                    ? const Text(
                        "ເປິດໂຕະ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                           ),
                      )
                    : const Text(
                        "ປິດໂຕະ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                Switch(
                  activeColor: ERPTheme.GREEN_COLOR,
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
            SizedBox(
              height: 25.h,
            ),
            isWitch == false
                ? Image.asset(ERPImages.offtable)
                : Column(
                    children: [
                      Center(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 14.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: ERPTheme.GREY_COLOR,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: ERPTheme.BASE_COLOR,
                                    width: 2,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 14.w,
                                    decoration: BoxDecoration(
                                      color: ERPTheme.GREY_COLOR,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: ERPTheme.BASE_COLOR,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                    width: 100.w,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: ERPTheme.BASE_COLOR,
                                            width: 2),
                                      ),
                                      color: ERPTheme.CARD_COLOR,
                                      child: ClipPath(
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            //  borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                                            border: Border(
                                              left: BorderSide(
                                                color: ERPTheme.GREEN_COLOR,
                                                width: 15,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              widget.data!.name!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 14.w,
                                    decoration: BoxDecoration(
                                      color: ERPTheme.GREY_COLOR,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: ERPTheme.BASE_COLOR,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 14.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: ERPTheme.GREY_COLOR,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: ERPTheme.BASE_COLOR,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "ເລກໂຕະ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.data!.name!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text(
                            "ໂຊນ ຫຼື ພື້ນທີ່",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: const [
                              ERPdate()
                            ],
                          )
                        ],
                      ),
              
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 49.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ERPTheme.BASE_COLOR,
                                borderRadius: BorderRadius.circular(5)),
                            child: TextButton(
                              style: const ButtonStyle(),
                              onPressed: () {},
                              child: Text(
                                "ສັ່ງອາຫານ",
                                style: TextStyle(
                                  color: ERPTheme.WHITE_COLOR,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
 
}
