import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/table/components/buttom_dialog.dart';
import 'package:erp_pos/pages/table/components/dropdown.dart';
import 'package:erp_pos/pages/table/components/dropdown_status.dart';
import 'package:erp_pos/pages/table/components/textContainer.dart';
import 'package:erp_pos/pages/table/components/textdatetime.dart';
import 'package:erp_pos/provider/sessoin/get_session_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mystyle {
  Widget screen(String message) {
    return Text(
      message,
      style: const TextStyle(
        fontFamily: "Phetsarath-OT",
        fontSize: 23,
      ),
    );
  }

  Widget texttitle(String message) {
    return Text(
      message,
      style: const TextStyle(
        fontFamily: "Phetsarath-OT",
        fontSize: 18,
        color: Colors.red,
      ),
    );
  }

  Widget sent() {
    return Container(
      height: 2,
      width: 130,
      color: Colors.blue,
    );
  }

  Widget tiTle1(String message) {
    return Text(
      message,
      style: const TextStyle(
          fontFamily: "Phetsarath-OT",
          fontSize: 18,
          fontWeight: FontWeight.bold),
    );
  }

  Widget subtiTle1(String message) {
    return Text(
      message,
      style: const TextStyle(
        fontFamily: "Phetsarath-OT",
        fontSize: 16,
      ),
    );
  }

  Future dialogbuttom(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mystyle().tiTle1("ການກັ່ນຕອງ"),
                Mystyle().subtiTle1("ໂຊນ ຫຼື ພື້ນທີ່"),
                ERPDropdown(),
                SizedBox(
                  height: 10.h,
                ),
                Mystyle().subtiTle1("ສະຖານະໂຕະ"),
                ERPDropdownStatus()
              ],
            ),
            actions: [
              ButtomDialog(
                text: '',
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Future dialogOpen(BuildContext context) {
    TextEditingController? email = TextEditingController();
    TextEditingController? cash = TextEditingController();
    /////////////////////////////////////
    final fromkey = GlobalKey<FormState>();
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            child: StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: Form(
                  key: fromkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Mystyle().tiTle1("ເປີດກະ"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: AppTheme.BASE_COLOR,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Mystyle().subtiTle1("ຜູ້ເປີດກະ"),
                      TextContainer(
                        hintext: "Telbiz@gmail.com",
                        suffixIcon: "",
                        controller: email,
                        validator:
                            RequiredValidator(errorText: 'ກະລຸນາປ້ອນອີເມວກ່ອນ'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Mystyle().subtiTle1("ວັນທີ ແລະ ເວລາ"),
                      ERPdateTime(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Mystyle().subtiTle1("ເງິນເລີ່ມຕົ້ນ"),
                      TextContainer(
                        hintext: "ເງິນເລີ່ມຕົ້ນ",
                        suffixIcon: "ກີບ",
                        controller: cash,
                        validator:
                            RequiredValidator(errorText: 'ກະລຸນາປ້ອນຈຳນວນເງິນ'),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ButtomDialog(
                    text: 'ຕົກລົງ',
                    onPressed: () async {
                      if (fromkey.currentState!.validate()) {
                        SessionProvoder().getsessoinProvider(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future dialogOff(BuildContext context) {
    TextEditingController? emailclose;
    TextEditingController? cashStart;
    TextEditingController? totalSale;
    TextEditingController? countableMoney;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Mystyle().tiTle1("ປີດກະ"),
                  Mystyle().subtiTle1("ຜູ້ປີດກະ"),
                  TextContainer(
                    hintext: "Telbiz@gmail.com",
                    suffixIcon: "",
                    controller: emailclose,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Mystyle().subtiTle1("ວັນທີ ແລະ ເວລາ"),
                  ERPdateTime(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Mystyle().subtiTle1("ເງິນເລີ່ມຕົ້ນ"),
                  TextContainer(
                    hintext: "ເງິນເລີ່ມຕົ້ນ",
                    suffixIcon: "ກີບ",
                    controller: cashStart,
                  ),
                  Mystyle().subtiTle1("ຍອດຂາຍ"),
                  TextContainer(
                    hintext: "ຍອດຂາຍ",
                    suffixIcon: "ກີບ",
                    controller: totalSale,
                  ),
                  Mystyle().subtiTle1("ເງິນທີ່ນັບໄດ້"),
                  TextContainer(
                    hintext: "ເງິນທີ່ນັບໄດ້",
                    suffixIcon: "ກີບ",
                    controller: countableMoney,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Mystyle().tiTle1("ຜິດດ່ຽງ"),
                      Mystyle().texttitle(
                        "30,000 ກີບ",
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                ButtomDialog(
                  text: '',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future dialogAddTable(BuildContext context) {
    TextEditingController? inputInfo;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Mystyle().subtiTle1("ໂຊນ : "),
                    Mystyle().subtiTle1("ຊັ້ນ 1"),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Mystyle().tiTle1("ເລກໂຕະ"),
                TextContainer(
                  hintext: "ປ້ອນຂໍ້ມູນ",
                  suffixIcon: "",
                  controller: inputInfo,
                ),
              ],
            ),
            actions: [
              ButtomDialog(
                text: '',
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  showdialogsuccess(context, String title, String desc) {
    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(
      titleTextStyle: TextStyle(fontFamily: 'Phetsarath-OT', fontSize: 20.sp),
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
    )..show();
  }

  void dialogError(BuildContext context, String title, String content) {
    double screenWidth = MediaQuery.of(context).size.width;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: ListView(
                shrinkWrap: true,
                children: [
                  isLandscape == false
                      ? screenWidth < 600
                          ? Image.asset(
                              ERPImages.iconerror,
                              width: 50.w,
                              height: 50.w,
                            )
                          : Image.asset(
                              ERPImages.iconerror,
                              width: 37.w,
                              height: 37.w,
                            )
                      : screenWidth < 600
                          ? Image.asset(
                              ERPImages.iconerror,
                              width: 50.w,
                              height: 50.w,
                            )
                          : Image.asset(
                              ERPImages.iconerror,
                              width: 27.w,
                              height: 27.w,
                            ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: isLandscape == false
                            ? screenWidth < 600
                                ? 16.sp
                                : 10.sp
                            : screenWidth < 600
                                ? 16.sp
                                : 8.sp),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: isLandscape == false
                          ? screenWidth < 600
                              ? 14.sp
                              : 8.sp
                          : screenWidth < 600
                              ? 14.sp
                              : 7.sp,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppTheme.BASE_COLOR,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: screenWidth < 600
                              ? EdgeInsets.all(2.0)
                              : EdgeInsets.all(8.0),
                          child: Text(
                            'ປິດ',
                            style: TextStyle(
                              color: AppTheme.WHITE_COLOR,
                              fontSize: isLandscape == false
                                  ? screenWidth < 600
                                      ? 14.sp
                                      : 9.sp
                                  : screenWidth < 600
                                      ? 14.sp
                                      : 8.sp,
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }

  showAlertloading(BuildContext context, String title, String text) async {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      text: text,
      title: 'ກຳລັງສະໝັກສະມາຊິກ',
      autoCloseDuration: Duration(milliseconds: 10),
    );
  }

  showAlertloadingError(BuildContext context, String title, String text) async {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      text: text,
      title: 'ກາລຸນາລອງໃໝ່ອີກຄັ້ງ',
      autoCloseDuration: Duration(milliseconds: 5),
    );
  }

  showAlertloadingsuccess(
      BuildContext context, String title, String text) async {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: text,
      title: title,
      autoCloseDuration: Duration(milliseconds: 5),
    );
  }

  showDialogSignOut(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
              insetAnimationDuration: Duration(milliseconds: 5),
              insetAnimationCurve: Curves.bounceOut,
              child: Container(
                height: 250.h,
                width: 310.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 19.h,
                    ),
                    CircleAvatar(
                      radius: 51,
                      backgroundColor: AppTheme.GREY_COLOR,
                      backgroundImage: AssetImage(
                        ERPImages.iconlogout,
                      ),
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    Center(
                      child: Text(
                        "ທ່ານຕ້ອງການອອກຈາກລະບົບແທ້ບໍ?",
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "ຢູ່ໃນລະບົບຕໍ່",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppTheme.GREY_COLOR,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppTheme.BASE_COLOR,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              AuthenticationProvider().logout(context);
                            },
                            child: Text(
                              "ອອກຈາກລະບົບ",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppTheme.WHITE_COLOR,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }

  showDialogCheckData(BuildContext context, String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
              insetAnimationDuration: Duration(milliseconds: 5),
              insetAnimationCurve: Curves.bounceOut,
              child: Container(
                height: 250.h,
                width: 310.w,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 19.h,
                      ),
                      Image.asset(
                        ERPImages.iconerror,
                        height: 100.h,
                        width: 100.w,
                      ),
                      SizedBox(
                        height: 19.h,
                      ),
                      Center(
                        child: Text(
                          "$text",
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppTheme.BASE_COLOR,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "ຕົກລົງ",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: AppTheme.WHITE_COLOR,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
