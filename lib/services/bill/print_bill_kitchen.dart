import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';



Future<bool?> printerkitchen() async {
  final bool? result = await SunmiPrinter.bindingPrinter();
  return result;
}
