import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/model/menu.dart';

class HomeHeader extends StatelessWidget {
  final menuItems = <Menu>[
    Menu(
      title: "Хүүхдийн эмч",
      subTitle: "12 эмч",
      img: 'assets/kids/stethoscope.svg',
      page: Container()
    ),
    Menu(
      title: "Нярайн эмч",
      subTitle: "7 эмч",
      img: 'assets/kids/feeding-bottle.svg',
      page: Container()
    ),
    Menu(
      title: "Шүдний эмч",
      subTitle: "83 эмч",
      img: 'assets/kids/teeth.svg',
      page: Container()
    ),
  ];
  @override
  Widget build(BuildContext context){
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics (),
      scrollDirection: Axis.horizontal,
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return 
            Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0, ),
            child: Container(
              width: 120,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius:
                          5.0, // has the effect of softening the shadow
                      spreadRadius:
                          1.0, // has the effect of extending the shadow
                      offset: Offset(
                        1.0, // horizontal, move right 10
                        1.0, // vertical, move down 10
                      ),
                    )
                  ],
                  color: Colors.white,
                  border: Border.all(color: Colors.black12, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: SvgPicture.asset(
                      menuItems[index].img,
                 
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    menuItems[index].title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    menuItems[index].subTitle,
                    style: TextStyle(color: Colors.black38, fontSize: 9.0),
                  )
                ],
              ),
            ),
          );
          
      },
    );
  }
}