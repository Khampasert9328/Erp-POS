import 'package:flutter/material.dart';

Color checkcolor(int status){
  if (status == 0) {
    return Colors.green;
  }else{
    return Colors.grey;
  }
}