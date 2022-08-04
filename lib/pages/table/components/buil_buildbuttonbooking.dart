import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/table/components/info_booking_table.dart';
import 'package:flutter/material.dart';

class BuidlButtonBooking extends StatelessWidget {
  const BuidlButtonBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: ERPTheme.BASE_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InfoBookingTable(),
          ),
        );
      },
      label: const Text(
        "ຈອງໂຕະ",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
