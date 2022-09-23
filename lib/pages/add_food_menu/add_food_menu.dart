import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/add_food_menu/components/add_food_menu_body.dart';
import 'package:flutter/material.dart';

class AddFoodMenu extends StatelessWidget {
  const AddFoodMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.BASE_COLOR),
        backgroundColor: Colors.white,
        title: Text('ເພີ່ມລາຍການ',
            style: TextStyle(
                color: AppTheme.BASE_COLOR, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: AddFoodMenuBody(),
    );
  }
}
