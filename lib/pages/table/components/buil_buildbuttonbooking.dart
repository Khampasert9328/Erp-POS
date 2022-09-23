import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/table/components/info_booking_table.dart';
import 'package:flutter/material.dart';

class BuidlButtonBooking extends StatelessWidget {
  const BuidlButtonBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: AppTheme.BASE_COLOR,
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
        style: TextStyle(
            fontFamily: 'Phetsarath-OT',
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }
}
