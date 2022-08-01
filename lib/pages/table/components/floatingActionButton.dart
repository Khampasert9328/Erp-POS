import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';

class BuildFloatingActionButton extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: ERPTheme.BASE_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {
        Mystyle().dialogAddTable(context);
      },
      icon: Image.asset(
        POSImages.tableStatus,
        height: 30,
        width: 30,
      ),
      label: const Text(
        "ເພີ່ມໂຕະ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
