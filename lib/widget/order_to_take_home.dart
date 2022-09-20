import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderToTakeHome extends StatelessWidget {
  OrderToTakeHome({Key? key}) : super(key: key);

  String title = 'ອໍເດີທີ່ສັ່ງກັບບ້ານ';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<GetFoodMenuProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.getFoodMenuModel.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          
                          value.getFoodMenuModel[index].data.thumbnails!.first
                              .uri!,
                              height: 100.h,
                              width: 100.w,
                        ),
                        Text(value.getFoodMenuModel[index].data.name!),
                      ],
                    ),
                  )
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
