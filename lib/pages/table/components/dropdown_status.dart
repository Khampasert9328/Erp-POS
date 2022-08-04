import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';

class ERPDropdownStatus extends StatefulWidget {
  const ERPDropdownStatus({Key? key}) : super(key: key);

  @override
  State<ERPDropdownStatus> createState() => _ERPDropdownStatusState();
}

class _ERPDropdownStatusState extends State<ERPDropdownStatus> {
  final item = [
    'ວ່າງ',
    'ບໍ່ວ່າງ',
    
  ];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ERPTheme.GREY_COLOR,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
          isExpanded: true,
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              ERPImages.ic_dropdown,
              color: ERPTheme.BLACK_COLOR,
              height: 18,
              width: 9,
            ),
          ),
          items: item.map(buildMenuItem).toList(),
          onChanged: (value) {
            setState(() {
              value = value;
            });
          }),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
