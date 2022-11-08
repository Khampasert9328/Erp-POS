import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {

  TextEditingController controller;

  String? Function(String?)? validator;
  String? hintText;
  Widget? prefixIcon;
  TextInputType? keyboardType;
  bool? obscureText;
  final Iterable<String> autofillHints;
  VoidCallback onEditing;
  
  
  

  
  AppTextField({
    required this.controller,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.obscureText,
    required this.autofillHints,
   required this.onEditing,
 
   
  
    
  });

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: TextFormField(
        onEditingComplete: onEditing,
          cursorColor: AppTheme.BASE_COLOR,
          obscureText: obscureText ?? false,
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.name,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffedebeb),
            border: InputBorder.none,
            hintText: hintText ?? '',
            prefixIcon: prefixIcon ?? Container(),
            hintStyle: TextStyle(
              fontFamily: 'Phetsarath-OT',
              fontSize: 18.sp,
            ),
          ),
        ),
    );
  
  }
}
