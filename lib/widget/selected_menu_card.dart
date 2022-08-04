import 'package:erp_pos/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:erp_pos/constant/routes.dart' as custom_route;
import '../constant/theme.dart';

class SelectedMenuCard extends StatelessWidget {
  const SelectedMenuCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, custom_route.Route.foodMenuDetail);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 5.w),
          decoration: BoxDecoration(
              color: Color(0xFFF4F5F6),
              borderRadius: BorderRadius.circular(7.r)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ERPImages.bcelone,
                width: 65.w,
                height: 65.h,
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hawaiian Pizza', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),),
                        IconButton(onPressed: (){}, icon: Icon(Icons.restore_from_trash_outlined, color: ERPTheme.BASE_COLOR, size: (20.h + 20.w) / 2,))
                      ],
                    ),
                    Text('ຈຳນວນ 01', style: TextStyle(fontSize: 15.sp),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(3.r),
                               color:  ERPTheme.BASE_COLOR,
                               border: Border.all(
                                   color:  ERPTheme.BASE_COLOR)),
                           child: Text(
                             'S',
                             style: TextStyle(
                                 fontSize: 14.sp,
                                 fontWeight: FontWeight.w700,
                                 color:  Colors.white),
                           ),
                         ),
                         Text('ລາຄາ 70,000 kip', style: TextStyle(fontSize: 15.sp, color: Color(0xFFFF0000)),)
                       ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
