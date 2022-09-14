import 'package:erp_pos/services/bill/print_bill_kitchen.dart';
import 'package:flutter/cupertino.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class PrintBillKitchenProvider extends ChangeNotifier {
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";

  Future<void> getprint() async {
    printerkitchen().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        paperSize = size;
      });
      SunmiPrinter.printerVersion().then((String version) {
        printerVersion = version;
      });
      SunmiPrinter.serialNumber()
          .then((String serial) => {serialNumber = serial});
      printBinded = isBind!;
    });
  }
}
