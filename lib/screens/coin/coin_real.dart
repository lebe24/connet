import 'package:app/screens/coin/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:app/model/coin_model.dart';
import 'package:app/network/tempApi.dart';
import 'package:app/widgets/auto_refresh.dart';
import 'package:app/screens/coin/coins.dart';

class CoinsRealTime extends StatefulWidget {
  @override
  _CoinsRealTimeState createState() => _CoinsRealTimeState();
}

class _CoinsRealTimeState extends State<CoinsRealTime> {

  List<Coin> _coin = List<Coin>();
  List<Coin> _coinForDisplay = List<Coin>();

  @override
  void initState() {
    fetchCoin().then((value){
      setState(() {
        _coin.addAll(value);
        _coinForDisplay = _coin;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AutoRefresh(
      duration: const Duration(milliseconds: 100000),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
        child: SafeArea(
          child: AnimationLimiter(
            child:_coinForDisplay.length == 0 ? Center(child: CircularProgressIndicator()) : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _coinForDisplay.length ,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      child: Coins(
                        item: index,
                        data:_coinForDisplay[index],
                        press:(){
                          Navigator.push(context, 
                      MaterialPageRoute(
                        builder:(context) => DetailBody(
                          data: _coin[index],
                        ))
                      );
                        }
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}