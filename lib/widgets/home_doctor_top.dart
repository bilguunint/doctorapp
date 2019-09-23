import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:wallet/style/theme.dart' as Style;
import 'package:wallet/widgets/doctor-detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TopDoctorList extends StatefulWidget {
  @override
  _TopDoctorListState createState() => _TopDoctorListState();
}

class _TopDoctorListState extends State<TopDoctorList> {
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
                  physics: const AlwaysScrollableScrollPhysics (),
                  scrollDirection: Axis.horizontal,
                  children: getExpenseItems(snapshot)));
        });
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new 
        GestureDetector(
          onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DoctorDetail(document: doc,)));
                    },
          child:  Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius:
                          5.0,
                      spreadRadius:
                          1.0,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.white,
                ),
                width: 130,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                          tag: doc.documentID,
                          child: Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(doc["doctorPhoto"])),
                              )),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              doc["doctorLastName"].toString().substring(0,1) +
                                  "." +
                                  doc["doctorFirstName"],
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                  height: 2.0,
                                ),
                            Text(
                                  doc["doctorHospitalName"],
                                  style: TextStyle(fontSize: 11.0),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                            Row(
                              children: <Widget>[
                                Text(
                                  doc["doctorSpec"],
                                  style: TextStyle(
                                      fontSize: 11.0, color: Colors.black26),
                                ),
                                
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "4.5",
                                  style: TextStyle(fontSize: 11.0),
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
                                    size: 10.0,
                                    color: Style.Colors.secondaryColor,
                                    borderColor: Style.Colors.secondaryColor,
                                    spacing: 0.0)
                              ],
                            ),
                          ],
                        ),
                        
                      ],
                    ),  
                  ],
                ),
              ),
            )
        )
       )
        .toList();
  }

  getExp(String sinceYear) {
    var since = int.parse(sinceYear);
    var exp = currentyear - since;
    String totalExp = exp.toString();
    return totalExp;
  }
}