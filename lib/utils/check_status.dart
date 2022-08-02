import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String checkStatus(Color color){
  if (color == Colors.red) {
    return 'ບໍ່ວ່າງ';
  }else if(color == Color(0xFFFCE00D2)){
    return 'ຈອງແລ້ວ';
  }else{
    return 'ວ່າງ';
  }
}