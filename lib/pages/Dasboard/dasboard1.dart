import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Dasboard1 extends StatefulWidget {
  const Dasboard1({Key? key}) : super(key: key);

  @override
  State<Dasboard1> createState() => _Dasboard1State();
}

class _Dasboard1State extends State<Dasboard1> {
  Map<String, double> listName = {
    "ອາຫານ": 5,
    "ເຄື່ອງດື່ມ": 3,
    "ແລະ ອື່ນໆ": 2,
  };
  List<Color> colorList = [
    Color(0xfffffffEC6524),
    Color(0xfff08a37f),
    Color(0xffffffFFA300)
  ];
  int key = 0;
  Widget pichart() {
    return PieChart(
      dataMap: listName,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 20,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 30,
      centerText: "",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: true,
        decimalPlaces: 1,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
      showTrackOnHover: true,
      isAlwaysShown: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            top: 20,
            right: 25,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 195,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "ຍອດຂາຍ/ກີບ",
                            style: TextStyle(
                                fontFamily: 'NotoSansLao-Regular',
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    "500,000 ກີບ",
                                    style: TextStyle(
                                        fontFamily: 'NotoSansLao-Regular',
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Icon(
                                    Icons.trending_up,
                                    color: Color(0xffffffff2CAE31),
                                  ),
                                  Text(
                                    "+10%",
                                    style: TextStyle(
                                      color: Color(0xffffffff2CAE31),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: pichart(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          height: 95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200]),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "ຍອດອໍເດີ",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansLao-Regular',
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "79 ອໍເດີ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'NotoSansLao-Regular',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.trending_up,
                                      color: Color(0xffffffff2CAE31),
                                    ),
                                    Text(
                                      "+10%",
                                      style: TextStyle(
                                        color: Color(0xffffffff2CAE31),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 150,
                          height: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200]),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "ຍອດການຈອງໂຕະ",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansLao-Regular',
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "24 ໂຕະ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'NotoSansLao-Regular',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.trending_down,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "-25%",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 250,
                width: 358,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "ລາຍການຍອດນິຍົມ",
                        style: TextStyle(
                          fontFamily: 'NotoSansLao-Regular',
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "ລາຍການ",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'NotoSansLao-Regular',
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "ອໍເດີ",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'NotoSansLao-Regular',
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            child: Image.asset(
                              "images/Rectangle 4598.png",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "ພັດກະເພົາໄຂ່ດາວ",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'NotoSansLao-Regular',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        child: Image.asset(
                                          "images/Ellipse 71.png",
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "ອາຫານ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'NotoSansLao-Regular',
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "18",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NotoSansLao-Regular',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            child: Image.asset(
                              "images/Rectangle 4599.png",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "ເຝີ",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'NotoSansLao-Regular',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        child: Image.asset(
                                          "images/Ellipse 71.png",
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "ອາຫານ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'NotoSansLao-Regular',
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "12",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NotoSansLao-Regular',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            child: Image.asset(
                              "images/Rectangle 4598.png",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Coca Cola",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'NotoSansLao-Regular',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        child: Image.asset(
                                          "images/Ellipse 74.png",
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "ເຄື່ອງດື່ມ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'NotoSansLao-Regular',
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "09",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NotoSansLao-Regular',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 350,
                width: 358,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "ຊ່ອງທາງການຊຳລະທີ່ນິຍົມ",
                        style: TextStyle(
                          fontFamily: 'NotoSansLao-Regular',
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 65,
                              width: 65,
                              child: Image.asset(
                                'images/Rectangle 4598.png',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "ເງິນສົດ",
                                style: TextStyle(
                                  fontFamily: 'NotoSansLao-Regular',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: const [
                                        Text(
                                          "5,000,000",
                                          style: TextStyle(
                                            fontFamily: 'NotoSansLao-Regular',
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "ກີບ",
                                          style: TextStyle(
                                            fontFamily: 'NotoSansLao-Regular',
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "50%",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansLao-Regular',
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 65,
                              width: 65,
                              child: Image.asset(
                                'images/unnamed 7.png',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "BCEL ONE",
                                style: TextStyle(
                                  fontFamily: 'NotoSansLao-Regular',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: const [
                                        Text(
                                          "5,000,000",
                                          style: TextStyle(
                                            fontFamily: 'NotoSansLao-Regular',
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "ກີບ",
                                          style: TextStyle(
                                            fontFamily: 'NotoSansLao-Regular',
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "50%",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansLao-Regular',
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 65,
                              width: 65,
                              child: Image.asset(
                                'images/1200x600wa 2.png',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "M money",
                                style: TextStyle(
                                  fontFamily: 'NotoSansLao-Regular',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: const [
                                        Text(
                                          "2,500,000",
                                          style: TextStyle(
                                            fontFamily: 'NotoSansLao-Regular',
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "ກີບ",
                                          style: TextStyle(
                                            fontFamily: 'NotoSansLao-Regular',
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "50%",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansLao-Regular',
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 65,
                              width: 65,
                              child: Image.asset(
                                'images/unnamed 8.png',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "U money",
                                style: TextStyle(
                                  fontFamily: 'NotoSansLao-Regular',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: const [
                                        Text(
                                          "2,500,000",
                                          style: TextStyle(
                                            fontFamily: 'NotoSansLao-Regular',
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "ກີບ",
                                          style: TextStyle(
                                            fontFamily: 'NotoSansLao-Regular',
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "50%",
                                      style: TextStyle(
                                        fontFamily: 'NotoSansLao-Regular',
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
