import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_body.dart';
import 'package:erp_pos/pages/food_menu_detail/components/food_menu_detail_body.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:erp_pos/constant/routes.dart' as custom_route;
import 'package:provider/provider.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({Key? key}) : super(key: key);

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {

  @override
  void initState() {
    super.initState();
    context.read<GetFoodMenuProvider>().getProduct(true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FoodMenuBody(),
    );
  }
}