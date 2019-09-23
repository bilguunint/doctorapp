import 'package:flutter/material.dart';
import 'package:wallet/widgets/home_doctor_top.dart';
import 'package:wallet/widgets/home_header.dart';
import 'package:wallet/style/theme.dart' as Style;


class HomeTab extends StatefulWidget {

  createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 10.0, top: 15.0, bottom: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Та ямар эмч хайж байна?",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Бүх ангилал",
                  style: TextStyle(
                      color: Style.Colors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                )
              ],
            ),
          ),
          Container(
            height: 130,
            child: HomeHeader(),
          ),  
          Padding(
            padding: EdgeInsets.only(
                left: 10.0, top: 15.0, bottom: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Топ 10",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Бүх эмч",
                  style: TextStyle(
                      color: Style.Colors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                )
              ],
            ),
          ),
          Container(height: 235, child: TopDoctorList()),
          Padding(
            padding: EdgeInsets.only(
                left: 10.0, top: 15.0, bottom: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Эмчийн зөвлөгөө",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
