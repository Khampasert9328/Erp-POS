import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';

class ERPDropdown extends StatefulWidget {
  const ERPDropdown({Key? key}) : super(key: key);

  @override
  State<ERPDropdown> createState() => _ERPDropdownState();
}

class _ERPDropdownState extends State<ERPDropdown> {
  final item = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
  ];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.GREY_COLOR,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
          isExpanded: true,
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "images/ic-dropdown.png",
              color: AppTheme.BLACK_COLOR,
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
