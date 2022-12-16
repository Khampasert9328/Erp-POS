import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color checkStatus(int status){
  if (status == 0) {
    return Colors.green;
  }else if(status == 1){
    return Colors.red;
  }else{
    return AppTheme.PINK_COLOR;
  }
}