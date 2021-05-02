import 'package:app/screens/stocks/stocks.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/coin/coin_real.dart';
import 'package:app/screens/forex/forex.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class Market extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: DefaultTabController(length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation:0.0,
            backgroundColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(55),
              child: Container(
                color: Colors.transparent,
                child: SafeArea(
                  child: Column(
                  children: <Widget>[
                    TabBar(
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: Colors.blue, width: 4.0),
                          insets: EdgeInsets.fromLTRB(
                              40.0, 20.0, 40.0, 0)),
                      indicatorWeight: 15,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Colors.blue,
                      labelStyle: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.3,
                          fontWeight: FontWeight.w500),
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: "COINS",
                          icon: Icon(FontAwesomeIcons.bitcoin, size: 30),

                        ),
                        Tab(
                          text: "STOCK",
                          icon: Icon(Icons.book, size: 30),
                        ),
                        Tab(
                          text: "FOREX",
                          icon: Icon(FontAwesomeIcons.exchangeAlt, size: 30)),
                  ])
                ]))
              )
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: TabBarView(children: [
              Center(child: CoinsRealTime()),
              Center(child: Stock()),
              Center(child: Forex())
            ])
          ),
        ),
      )
    );
  }
}