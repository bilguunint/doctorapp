import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  int currentyear;
  @override
  void initState() {
    super.initState();
    var currentdate = new DateTime.now();
    currentyear = currentdate.year.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Doctors").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return new Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.black45),
                      strokeWidth: 2.0,
                    ))
              ],
            ));
          return new Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                  scrollDirection: Axis.vertical,
                  children: getExpenseItems(snapshot)));
        });
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: doc.documentID,
                          child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(doc["doctorPhoto"])),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              doc["doctorFirstName"] +
                                  " " +
                                  doc["doctorLastName"],
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                  height: 2.0,
                                ),
                            Text(
                                  doc["doctorHospitalName"],
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                            Row(
                              children: <Widget>[
                                Text(
                                  doc["doctorSpec"],
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black26),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 5.0,
                                  height: 5.0,
                                  decoration: new BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                getExp(doc["doctorSinceYear"]) + "жил",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    ),
                              )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(EvaIcons.heartOutline),
                            )
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only( bottom: 5.0),
                      child: new Divider(
                        color: Colors.grey[300],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("12 сэтгэгдэл", style: TextStyle(fontSize: 12.0)),
                        Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "4.5",
                                  style: TextStyle(fontSize: 12.0),
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
                                    size: 12.0,
                                    color: Colors.grey,
                                    borderColor: Colors.grey,
                                    spacing: 0.0)
                              ],
                            ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: new Divider(
                        color: Colors.grey[300],
                      ),
                    ),
                      Row(
                        children: <Widget>[
                          
                        ],
                      )
                      
                      
                  ],
                ),
              ),
            ))
        .toList();
  }

  getExp(String sinceYear) {
    var since = int.parse(sinceYear);
    var exp = currentyear - since;
    String totalExp = exp.toString();
    return totalExp;
  }
}