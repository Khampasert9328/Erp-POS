
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/services/bill/print_bill_kitchen.dart';
import 'package:flutter/cupertino.dart';


class PrintBillKitchenProvider extends ChangeNotifier {

  PrinterMode? _printerMode;
  PrinterMode? get printerMode =>_printerMode;
  Future<void> getprint() async {
    bindingPrinter().then((bool isBool) async{
      if(isBool){
        getPrinterStatus();
        _printerMode = await getPrinterMode();
      }
    });
  }
}
