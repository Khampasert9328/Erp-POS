import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/table/components/buttom_dialog.dart';
import 'package:erp_pos/pages/table/components/dropdown.dart';
import 'package:erp_pos/pages/table/components/dropdown_status.dart';
import 'package:erp_pos/pages/table/components/textContainer.dart';
import 'package:erp_pos/pages/table/components/textdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Mystyle {
  Widget screen(String message) {
    return Text(
      message,
      style: const TextStyle(
        fontFamily: "NotoSansLao-Regular",
        fontSize: 23,
      ),
    );
  }

  Widget texttitle(String message) {
    return Text(
      message,
      style: const TextStyle(
          fontFamily: "NotoSansLao-Regular", fontSize: 18, color: Colors.red),
    );
  }

  Widget sent() {
    return Container(
      height: 2,
      width: 130,
      color: Colors.blue,
    );
  }

  Widget tiTle1(String message) {
    return Text(
      message,
      style: const TextStyle(
          fontFamily: "Phetsarath-OT",
          fontSize: 18,
          fontWeight: FontWeight.bold),
    );
  }

  Widget subtiTle1(String message) {
    return Text(
      message,
      style: const TextStyle(
        fontFamily: "Phetsarath-OT",
        fontSize: 16,
      ),
    );
  }

  Future dialogbuttom(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mystyle().tiTle1("ການກັ່ນຕອງ"),
                Mystyle().subtiTle1("ໂຊນ ຫຼື ພື້ນທີ່"),
                ERPDropdown(),
                SizedBox(
                  height: 10.h,
                ),
                Mystyle().subtiTle1("ສະຖານະໂຕະ"),
                ERPDropdownStatus()
              ],
            ),
            actions: [ButtomDialog()],
          ),
        );
      },
    );
  }

  Future dialogOpen(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mystyle().tiTle1("ເປີດກະ"),
                Mystyle().subtiTle1("ຜູ້ເປີດກະ"),
                TextContainer(hintext: "Telbiz@gmail.com", suffixIcon: ""),
                SizedBox(
                  height: 10.h,
                ),
                Mystyle().subtiTle1("ວັນທີ ແລະ ເວລາ"),
                ERPdate(),
                SizedBox(
                  height: 10.h,
                ),
                Mystyle().subtiTle1("ເງິນເລີ່ມຕົ້ນ"),
                TextContainer(hintext: "ເງິນເລີ່ມຕົ້ນ", suffixIcon: "ກີບ"),
              ],
            ),
            actions: [ButtomDialog()],
          ),
        );
      },
    );
  }

  Future dialogOff(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mystyle().tiTle1("ປີດກະ"),
                Mystyle().subtiTle1("ຜູ້ປີດກະ"),
                TextContainer(hintext: "Telbiz@gmail.com", suffixIcon: ""),
                SizedBox(
                  height: 10.h,
                ),
                Mystyle().subtiTle1("ວັນທີ ແລະ ເວລາ"),
                ERPdate(),
                SizedBox(
                  height: 10.h,
                ),
                Mystyle().subtiTle1("ເງິນເລີ່ມຕົ້ນ"),
                TextContainer(hintext: "ເງິນເລີ່ມຕົ້ນ", suffixIcon: "ກີບ"),
                Mystyle().subtiTle1("ຍອດຂາຍ"),
                TextContainer(hintext: "ຍອດຂາຍ", suffixIcon: "ກີບ"),
                Mystyle().subtiTle1("ເງິນທີ່ນັບໄດ້"),
                TextContainer(hintext: "ເງິນທີ່ນັບໄດ້", suffixIcon: "ກີບ"),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Mystyle().tiTle1("ຜິດດ່ຽງ"),
                    Mystyle().texttitle(
                      "30,000 ກີບ",
                    ),
                  ],
                )
              ],
            ),
            actions: [ButtomDialog()],
          ),
        );
      },
    );
  }

  Future dialogAddTable(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Mystyle().subtiTle1("ໂຊນ:"),
                    Mystyle().subtiTle1("ຫ້ອງອາຫານຊັ້ນ 01"),
                  ],
                ),
                Mystyle().tiTle1("ເລກໂຕະ"),
                TextContainer(hintext: "ປ້ອນຂໍ້ມູນ", suffixIcon: ""),
              ],
            ),
            actions: [
              ButtomDialog(),
            ],
          ),
        );
      },
    );
  }

  showdialogsuccess(context) {
    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'ແຈ້ງເຕືອນ',
      desc: 'ຈອງໂຕະສຳແລ້ວ!...',
      btnOkOnPress: () {},
    )..show();
  }
}
