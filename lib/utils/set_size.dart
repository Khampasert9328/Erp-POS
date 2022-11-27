import 'package:flutter/cupertino.dart';
String setSize(int size) {
  if (size == 0) {
    return 'S';
  } else if (size == 1) {
    return 'M';
  } else {
    return 'L';
  }
}
