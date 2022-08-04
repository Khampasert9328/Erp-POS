import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';

class InputDetail extends StatefulWidget {
  String hintext;
  String suffixIcon;
  InputDetail({required this.hintext, required this.suffixIcon});

  @override
  State<InputDetail> createState() => _InputDetailState();
}

class _InputDetailState extends State<InputDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 2,
      ),
      decoration: BoxDecoration(
        color: ERPTheme.GREY_COLOR,
        border: Border.all(color: ERPTheme.WHITE_COLOR),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
        ),
        child: TextField(
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.suffixIcon),
            ),
            border: InputBorder.none,
            hintText: widget.hintext,
          ),
        ),
      ),
    );
  }
}
