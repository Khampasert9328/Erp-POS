
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/services/bill/print_bill_customers.dart';
import 'package:erp_pos/services/bill/print_bill_kitchen.dart';
import 'package:flutter/cupertino.dart';


class PrintBillCustomers extends ChangeNotifier {

  PrinterMode? _printerMode;
  

  Future<void> getbillCustomers() async {
    buildbillcustomers().then((bool isBool) async{
      if(isBool){
        getPrinterStatusCustom();
        _printerMode = await getPrinterModeCustom();

      }

    });
  }
}
