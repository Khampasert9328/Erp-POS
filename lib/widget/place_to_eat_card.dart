import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';

class PlaceToEatCard extends StatefulWidget {
  ScrollController scrollController;

  PlaceToEatCard({required this.scrollController});

  @override
  State<PlaceToEatCard> createState() => _PlaceToEatCardState();
}

class _PlaceToEatCardState extends State<PlaceToEatCard> {
  int? isRadio = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: ERPTheme.GREY_COLOR,
              border: Border.all(color: ERPTheme.BASE_COLOR),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: isRadio,
                  onChanged: (val) {
                    setState(() {
                      val = isRadio;
                    });
                  },
                ),
                Icon(Icons.person),
                Text("ກິນຢູ່ຮ້ານ")
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
