import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:flutter/material.dart';

class SearchFoodMenu extends StatefulWidget {
  final List<Product> data;
  SearchFoodMenu({super.key, required this.data});
  @override
  State<SearchFoodMenu> createState() => _SearchFoodMenuState();
}

class _SearchFoodMenuState extends State<SearchFoodMenu> {
  List<Product> product = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (val) {
            setState(() {
              product =
                  widget.data.where((el) => el.name!.contains(val)).toList();
            });
          },
          decoration: InputDecoration(
              hintText: 'ຄົ້ນຫາລາຍການອາຫານ',
              hintStyle: TextStyle(
                color: AppTheme.WHITE_COLOR,
                fontFamily: 'Phetsarath-OT',
              ),
              border: InputBorder.none),
          style: TextStyle(
            color: AppTheme.WHITE_COLOR,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "${product.first.name}",
        ),
      ),
    );
  }
}
