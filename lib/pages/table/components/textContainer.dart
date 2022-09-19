import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';

class TextContainer extends StatefulWidget {
  String hintext;
  String suffixIcon; 
  TextContainer({required this.hintext,required this.suffixIcon});
  
  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppTheme.GREY_COLOR,
          border: Border.all(color: AppTheme.WHITE_COLOR),
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