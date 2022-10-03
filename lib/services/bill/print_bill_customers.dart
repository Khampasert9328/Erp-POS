import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';

PrinterStatus? printerStatus;
PrinterMode? printerMode;

Future<bool> buildbillcustomers() async {
  final bool resualt = await SunmiPrinter.bindingPrinter();
  return resualt;
}

Future<void> getPrinterStatusCustom(BuildContext context) async {
  try {
    final PrinterStatus resualt = await SunmiPrinter.getPrinterStatus();
    printerStatus = resualt;
  } catch (e) {
    Mystyle().showDialogCheckData(context, "ບໍ່ມີປິນເຕີ");
  }
}

Future<PrinterMode> getPrinterModeCustom() async {
  final PrinterMode mode = await SunmiPrinter.getPrinterMode();
  return mode;
}
