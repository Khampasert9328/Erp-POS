import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentMmoney extends StatefulWidget {
  final tablename;
  final qrdata;
  const PaymentMmoney({Key? key, required this.tablename, required this.qrdata}) : super(key: key);

  @override
  State<PaymentMmoney> createState() => _PaymentMmoneyState();
}

DateTime time = DateTime.now();
final timenow = DateFormat('HH:mm').format(time);

class _PaymentMmoneyState extends State<PaymentMmoney> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        title: Text(
          widget.tablename,
          style: TextStyle(color: AppTheme.BASE_COLOR),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                ERPImages.mmoney,
                height: 63.h,
                width: 63.w,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                "ສະແກນເພື່ອຊຳລະ",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppTheme.BASE_COLOR,
                  fontWeight: FontWeight.bold,
                   fontFamily: 'Phetsarath-OT',
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ກີບ",
                      style: TextStyle(
                          fontFamily: 'Phetsarath-OT',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.RED_COLOR),
                    ),
                  ),
                  //ສຳລັບ generate code
                  Container(
                    height: 228.h,
                    width: 228.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      widget.qrdata.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : QrImage(
                                data: widget.qrdata,
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                      ],
                    ),
                  ),
                  ///////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Text(
                      timenow,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
