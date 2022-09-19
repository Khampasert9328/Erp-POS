import 'package:devla_sunmi/flutter_sunmi_printer.dart';




Future<bool?> printerkitchen() async {
  final bool? result = await SunmiPrinter.bindingPrinter();
  return result;
}
