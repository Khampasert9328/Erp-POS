import 'dart:ui';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/table/components/buil_buildbuttonbooking.dart';
import 'package:erp_pos/pages/table/components/input_detail.dart';
import 'package:erp_pos/pages/table/components/style/textfield.dart';
import 'package:erp_pos/pages/table/components/textdate.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoBookingTable extends StatefulWidget {
  @override
  State<InfoBookingTable> createState() => _InfoBookingTableState();
}

class _InfoBookingTableState extends State<InfoBookingTable> {
  final fromkey = GlobalKey<FormState>();
  int selectindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ERPTheme.WHITE_COLOR,
        centerTitle: true,
        title: Text(
          "ປ້ອນຂໍ້ມູນການຈອງ",
          style: TextStyle(
            color: ERPTheme.BLACK_COLOR,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 7,
          horizontal: 30.0,
        ),
        width: double.infinity,
        child: FloatingActionButton.extended(
      backgroundColor: ERPTheme.BASE_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {
       if (fromkey.currentState!.validate()) {
        Mystyle().showdialogsuccess(context);
         
       }
      },
      label: const Text(
        "ຈອງໂຕະ",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Form(
              key: fromkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ຊື່ ແລະ ນາມສະກຸນ *",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "ກາລຸນາໃສ່ຊື່ໃຫ້ຖືກຕ້ອງ";
                      } else {
                        return null;
                      }
                    }),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffedebeb),
                      border: InputBorder.none,
                      hintText: "ປ້ອນຂໍ້ມູນ",
                      hintStyle: TextStyle(
                        fontFamily: "NotoSansLao-Regular",
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "ເບີໂທຕິດຕໍ່ *",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: ((value) {
                      if (value!.isEmpty ) {
                        return "ກາລຸນາໃສ່ເບີໂທໃຫ້ຖືກຕ້ອງ";
                      } else {
                        return null;
                      }
                    }),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffedebeb),
                      border: InputBorder.none,
                      hintText: "ປ້ອນຂໍ້ມູນ",
                      hintStyle: TextStyle(
                        fontFamily: "NotoSansLao-Regular",
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "ຈຳນວນລູກຄ້າ *",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: ((value) {
                      if (value!.isEmpty ) {
                        return "ກາລຸນາໃສ່ຈຳນວນລູກຄ້າ";
                      } else {
                        return null;
                      }
                    }),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffedebeb),
                      border: InputBorder.none,
                      hintText: "ປ້ອນຂໍ້ມູນ",
                      hintStyle: TextStyle(
                        fontFamily: "NotoSansLao-Regular",
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "ວັນທີ ແລະ ເວລາ *",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      ERPdate(),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "ລາຍລະອຽດ ແລະອື່ນໆ *",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  InputDetail(hintext: "", suffixIcon: "")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
}
