import '../utils/constants.dart';
import 'ListResvition.dart';
import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/dashboard.dart';
import 'CalendarScreen.dart';
import 'booking_screen.dart';
class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _screen=[
    Dashboard(),
    ListPage(title: '', key: UniqueKey(),),
    ListPage(title: '', key: UniqueKey(),),
    CalendarScreen(),
  ];
  @override
  Widget build(BuildContext context)=> WillPopScope(child:   Scaffold(
    bottomNavigationBar: CurvedNavigationBar(
    key: _bottomNavigationKey,
    index: 0,
    height: 60.0,
    items: <Widget>[
      Icon(Icons.dashboard, size: 30,color: Constants.FontColor,),
      Icon(Icons.calendar_today, size: 30),
      Badge(
        badgeContent: Text('3'),
        child: Icon(Icons.calendar_view_week_sharp),
      ),
      Icon(Icons.person, size: 30),
    ],
    color: Colors.white,
    buttonBackgroundColor: Colors.white,
    backgroundColor: Colors.blueAccent,
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(milliseconds: 600),
    onTap: (index) {
      setState(() {
        _page = index;
      });
    },
    letIndexChange: (index) => true,
  ),
  body:_screen[_page] ,

  ), onWillPop: () async {
    return false;
  }
  );


}

