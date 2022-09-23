
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:flutter/material.dart';

PrinterStatus? printerStatus;
PrinterMode? printerMode;

Future<bool> bindingPrinter() async {
  final bool resualt = await SunmiPrinter.bindingPrinter();
  return resualt;
}

Future<void> getPrinterStatus() async {
  final PrinterStatus resualt = await SunmiPrinter.getPrinterStatus();
  printerStatus = resualt;
}

Future<PrinterMode> getPrinterMode()async{
  final PrinterMode mode = await SunmiPrinter.getPrinterMode();
  return mode;
}
