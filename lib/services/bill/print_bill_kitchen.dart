import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:flutter/material.dart';

PrinterStatus? printerStatus;
Future<bool> bindingPrinter() async {
  final bool resualt = await SunmiPrinter.bindingPrinter();
  return resualt;
}

Future<void> getPrinterStatus() async {
   PrinterStatus resualt = await SunmiPrinter.getPrinterStatus();
  printerStatus = resualt;
}

Future<PrinterMode> getPrinterMode() async {
  PrinterMode? mode = await SunmiPrinter.getPrinterMode();
  return mode;
}
