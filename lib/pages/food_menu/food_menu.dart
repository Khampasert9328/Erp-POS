import 'package:erp_pos/pages/food_menu/components/food_menu_body.dart';
import 'package:flutter/material.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({Key? key}) : super(key: key);

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FoodMenuBody()
    );
  }
}