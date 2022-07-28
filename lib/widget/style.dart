
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
  Widget tiTle1(String message) {
    return Text(
      message,
      style: const TextStyle(
        fontFamily: "Phetsarath-OT",
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
    );
  }
  Widget subtiTle1(String message) {
    return Text(
      message,
      style: const TextStyle(
        fontFamily: "Phetsarath-OT",
        fontSize: 15,
      ),
    );
  }
}
