// ignore_for_file: avoid_unnecessary_containers

import 'package:erp_pos/pages/table/components/buttom_dialog.dart';
import 'package:erp_pos/pages/table/components/dropdown.dart';
import 'package:erp_pos/pages/table/components/dropdown_status.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/theme.dart';

class ListViewTable extends StatefulWidget {
  const ListViewTable({Key? key}) : super(key: key);

  @override
  State<ListViewTable> createState() => _ListViewTableState();
}

bool changScreenTabBar = false;

List<String> item = [
  'ຫ້ອງອາຫານຊັ້ນ01',
  'ຫ້ອງອາຫານຊັ້ນ02',
  'ຫ້ອງອາຫານຊັ້ນ03',
];

class _ListViewTableState extends State<ListViewTable> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            dialogbuttom();
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: const Icon(
              Icons.add,
              color: Color(0xFFF2B9348),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            height: 20.h,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        changScreenTabBar = false;
                      });
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(left: 8.w, right: 8.w),
                      child: Text(
                        item[index],
                        style: TextStyle(
                          color: !changScreenTabBar
                              ? ERPTheme.BASE_COLOR
                              : ERPTheme.GREY_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  Future dialogbuttom() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mystyle().tiTle1("ຊື່ໂຊນ ຫຼື ພື້ນທີ່"),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ERPTheme.GREY_COLOR,
                    border: Border.all(color: ERPTheme.WHITE_COLOR),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ປ້ອນຂໍ້ມູນ',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: const [
              ButtomDialog(),
            ],
          ),
        );
      },
    );
  }
}
