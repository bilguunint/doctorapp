import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:wallet/style/theme.dart' as Style;

class DoctorDetail extends StatefulWidget {
  final DocumentSnapshot document;
  DoctorDetail({Key key, @required this.document}) : super(key: key);
  @override
  _DoctorDetailState createState() => _DoctorDetailState(document);
}

class _DoctorDetailState extends State<DoctorDetail> {
  final DocumentSnapshot document;
  _DoctorDetailState(this.document);
  int currentyear;
  @override
  void initState() {
    super.initState();
    var currentdate = new DateTime.now();
    currentyear = currentdate.year.toInt();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                          tag: document.documentID,
                          child: Container(
                              width: 150.0,
                              height: 200.0,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(document["doctorPhoto"])),
                              )),
                        ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              document["doctorLastName"].toString().substring(0,1) +
                                  "." +
                                  document["doctorFirstName"],
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                  height: 2.0,
                                ),
                            Text(
                                  document["doctorHospitalName"],
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                            Row(
                              children: <Widget>[
                                Text(
                                  document["doctorSpec"],
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black26),
                                ),
                                
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                                getExp(document["doctorSinceYear"]) + "жил",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    ),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "4.5",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                SmoothStarRating(
                                    allowHalfRating: true,
                                    onRatingChanged: (v) {
                                      setState(() {});
                                    },
                                    starCount: 5,
                                    rating: 4.5,
                                    size: 14.0,
                                    color: Style.Colors.secondaryColor,
                                    borderColor: Style.Colors.secondaryColor,
                                    spacing: 0.0)
                              ],
                            ),
                          ],
                        ),
            ],
          )
        ],
      ),
      )
      
    );
  }
  getExp(String sinceYear) {
    var since = int.parse(sinceYear);
    var exp = currentyear - since;
    String totalExp = exp.toString();
    return totalExp;
  }
}