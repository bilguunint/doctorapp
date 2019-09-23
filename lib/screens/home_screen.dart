import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet/bloc/auth_bloc/bloc.dart';
import 'package:wallet/screens/tabs/home.dart';
import 'package:wallet/style/theme.dart' as Style;
import 'package:wallet/bloc/bottom_navbar_bloc.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;

  HomeScreen({Key key, @required this.user}) : super(key: key);
  createState() => _HomeScreenState(user);
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseUser user;
  _HomeScreenState(this.user);
  BottomNavBarBloc _bottomNavBarBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2.5, color: Style.Colors.mainColor),
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: new NetworkImage(user.photoUrl)),
                    )),
              ],
            ),
          ),
          title: new Text(
            "Healthy",
            style: TextStyle(
                fontSize: Theme.of(context).platform == TargetPlatform.iOS
                    ? 20.0
                    : 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                EvaIcons.logOutOutline,
              ),
              color: Colors.black,
              onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).dispatch(
                LoggedOut(),
              );
            },
            ),
          ],
        ),
      ),
      body: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.MENU:
              return _alertArea();
            case NavBarItem.TOPIC:
              return _alertArea();
            case NavBarItem.ARTICLE:
              return HomeTab();
            case NavBarItem.NOTIFICATION:
              return _settingsArea();
            case NavBarItem.SAVED:
              return _settingsArea();
          }
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            iconSize: 20,
            unselectedItemColor: Colors.grey[400],
            unselectedFontSize: 10,
            selectedFontSize: 10,
            type: BottomNavigationBarType.fixed,
            fixedColor: Style.Colors.mainColor,
            currentIndex: snapshot.data.index,
            onTap: _bottomNavBarBloc.pickItem,
            items: [
              BottomNavigationBarItem(
                  title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text('Урамшуулал',
                          style: TextStyle(fontWeight: FontWeight.w600))),
                  icon: SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: SvgPicture.asset("assets/icons/card.svg"),
                  ),
                  activeIcon: SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: SvgPicture.asset("assets/icons/card-active.svg"),
                  )),
              BottomNavigationBarItem(
                title: Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text('Эм',
                        style: TextStyle(fontWeight: FontWeight.w600))),
                icon: SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: SvgPicture.asset("assets/icons/pill.svg"),
                ),
                activeIcon: SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: SvgPicture.asset(
                    "assets/icons/pill-active.svg",
                  ),
                ),
              ),
              BottomNavigationBarItem(
                title: Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text('Эхлэл',
                        style: TextStyle(fontWeight: FontWeight.w600))),
                icon: SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: SvgPicture.asset(
                    "assets/icons/home.svg",
                  ),
                ),
                activeIcon: SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: SvgPicture.asset(
                    "assets/icons/home-active.svg",
                  ),
                ),
              ),
              BottomNavigationBarItem(
                  title: Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text('Зөвлөгөө',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  icon: SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: SvgPicture.asset(
                      "assets/icons/advice.svg",
                    ),
                  ),
                  activeIcon: SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: SvgPicture.asset(
                      "assets/icons/advice-active.svg",
                    ),
                  )),
              BottomNavigationBarItem(
                  title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text('Түүх',
                          style: TextStyle(fontWeight: FontWeight.w600))),
                  icon: SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: SvgPicture.asset("assets/icons/history.svg"),
                  ),
                  activeIcon: SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: SvgPicture.asset("assets/icons/history-active.svg"),
                  )),
            ],
          );
        },
      ),
    );
  }

  Widget _alertArea() {
    return Center(
      child: Text(
        'Test Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.red,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _settingsArea() {
    return Center(
      child: Text(
       "",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blue,
          fontSize: 25.0,
        ),
      ),
    );
  }
}
