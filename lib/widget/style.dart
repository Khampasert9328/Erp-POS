import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mystyle {
  Widget screen(String message) {
    return Text(
      message,
      style: const TextStyle(
        fontFamily: "NotoSansLao-Regular",
        fontSize: 23,
      ),
    );
  }

  Widget sent(){
    return Container(
      height: 2,
      width: 130,
      color: Colors.blue,
    );
  }
}
