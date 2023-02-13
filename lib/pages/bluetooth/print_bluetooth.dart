// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';

// class PrintBlueTooth extends StatefulWidget {
//   const PrintBlueTooth({super.key});

//   @override
//   State<PrintBlueTooth> createState() => _PrintBlueToothState();
// }

// class _PrintBlueToothState extends State<PrintBlueTooth> {
//   PrinterBluetoothManager _printerBluetoothManager = PrinterBluetoothManager();
//   List<PrinterBluetooth> _device =[];
//   String? _deviceMsg;
//   @override
//   void initState() {
    
//     super.initState();
//   }
//   void initPrinter(){
//     _printerBluetoothManager.startScan(Duration(seconds: 2));
//     _printerBluetoothManager.scanResults.listen((val) { 
//       if (!mounted) return;
//       setState(() => _device = val);
//       if (_device.isEmpty) {
//         setState(() {
//           _deviceMsg='No Device';
//         });
//       }
//     });
//   }

//   Future<void> _startPrint(PrinterBluetooth printer)async{
//     _printerBluetoothManager.selectPrinter(printer);
// //final result = await _printerBluetoothManager.printTicket(await _ticket(PaperSize.mm80));
// //print("res:$result");

//   }
//   // Future<Ticket> _ticket(PaperSize paperSize)async{
//   //   final ticket = Ticket

//   //   return ticket;
//   // } 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("ປິ່ນບູດທູດ"),),
//       body: _device.isEmpty?Center(child: Text(_deviceMsg??""),):ListView.builder(
//         itemCount: _device.length,
//         itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.print),
//           title: Text(_device[index].name!),
//           subtitle: Text(_device[index].address!),
//           onTap: (){
//             //todo
//           },
//         );
//       },)
//     );
//   }
// }