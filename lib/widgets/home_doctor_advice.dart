import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorAdvice extends StatefulWidget {
  @override
  _DoctorAdviceState createState() => _DoctorAdviceState();
}

class _DoctorAdviceState extends State<DoctorAdvice> {
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
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: getExpenseItems(snapshot)));
        });
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: doc.documentID,
                          child: Container(
                              width: 40.0,
                              height: 40.0,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              doc["doctorLastName"].toString().substring(0,1) +
                                  "." +
                                  doc["doctorFirstName"],
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.bold),
                            ),
                            
                            Row(
                              children: <Widget>[
                                Text(
                                  "2 өдрийн өмнө",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black26),
                                ),
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
                    Text("Юуны өмнө хамрын дайвар хөндийнүүд гэж хаана байдаг ямар бүтцийн тухай ярьж байгааг жаахан тайлбарлая. Хүний гавлын яс нь зарим хэсэгтээ агаартай хөндийнүүдтэй байдаг. Тухайлбал, хоёр талын хацрын яс, нүдний хооронд, духны хэсэг, гавлын суурь хэсгийн ясанд агаартай хөндийнууд бий. Энэ хөндийнүүдийг Хамрын Дайвар Хөндийнүүд гэдэг. Эдгээр хөндийнүүд бүгдээрээ өөрийн нүх сүвүүдээр хамрын хөндийтэй холбоотой юм. Хамрын дайвар хөндийнүүд нь гавал тархийг хөнгөн байлгах, дуу авиа үүсгэхэд оролцох, хамар луу орж байгаа агаарыг цэвэрлэн чийгшүүлж дулаацуулах, хамгаалах зэрэг олон үүрэгтэй."),
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
                                  "Сэтгэгдэл үлдээх",
                                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                              
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