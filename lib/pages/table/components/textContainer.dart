import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/createoffsession/createoffsession_models.dart';
import 'package:erp_pos/provider/offsession/create_off_session_provider.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';

class TextContainer extends StatefulWidget {
  String hintext;
  String suffixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  bool readOnly;
  TextInputType keyboardType;
  ThousandsFormatter inputFormatters;

  TextContainer({
    required this.hintext,
    required this.suffixIcon,
    required this.controller,
    this.validator,
    required this.readOnly,
    required this.keyboardType,
    required this.inputFormatters
  });

  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  TextEditingController controller = TextEditingController();
 
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
          inputFormatters: [ThousandsFormatter()],
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          controller: widget.controller,
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
