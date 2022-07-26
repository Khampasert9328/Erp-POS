// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TabBarDasboard extends StatefulWidget {
  @override
  State<TabBarDasboard> createState() => _TabBarDasboardState();
}

class _TabBarDasboardState extends State<TabBarDasboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('images/Ellipse 69.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "ສະບາຍດີ!",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "ວິລະພົງ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                "images/setting.png",
              ),
            ),
          )
        ],
        bottom: const TabBar(
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          indicatorWeight: 5,
          labelStyle: TextStyle(
            fontSize: 18,
            fontFamily: 'NotoSansLao-Regular',
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(
              text: "ວັນ",
            ),
            Tab(
              text: "ອາທິດ",
            ),
            Tab(
              text: "ເດືອນ",
            ),
            Tab(
              text: "ປີ",
            ),
            Tab(
              text: "ທັງໝົດ",
            ),
          ],
        ),
      ),
    );
  }
}
