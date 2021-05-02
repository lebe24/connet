import 'package:app/constants/constant.dart';
import 'package:app/screens/newsfeed/newsFeed.dart';
import 'package:app/screens/newsstand/newsstand.dart';
import 'package:app/screens/profile/profile.dart';
import 'package:app/screens/views/body.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app/screens/views/market.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  
  int _current = 2;
  final tabs =[
    Stack(
        children:[
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            title: Text('Billionaires',
            style: TextStyle(
            color:Colors.white),
          ),
      actions: <Widget>[
        IconButton(icon: SvgPicture.asset('assets/icons/notification.svg'), onPressed: (){})
      ]),
          Body()
        ]
      ),
      Center(child: Market()),
      Center(child: NewsStand()),
      Center(child: NewsFeed()),
      Center(child: Profile())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:Container(
      decoration: BoxDecoration(
        gradient: kgoldenColor
      ),
      child: tabs[_current]
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _bottomBar(){
    return Container(
      color: kblack.withOpacity(0.1),
        child: CurvedNavigationBar(
        // key: _bottomNavigationKey,
        index: 2,
        height: 50.0,
        items: [
          Icon(Icons.home,color:Colors.blue, size: 40),
          Icon(Icons.monetization_on,color: Colors.blue, size: 40),
          Icon(Icons.add_circle,color: Colors.blue, size: 40),
          Icon(FontAwesomeIcons.globeAfrica,color:Colors.blue, size: 40),
          Icon(Icons.person,color: Colors.blue, size: 40),
        ],
        color: Colors.white,
        buttonBackgroundColor:Colors.white,
        backgroundColor: kgold.withOpacity(0.3),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index){
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }
}

