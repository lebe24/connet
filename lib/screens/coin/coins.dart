import 'package:flutter/material.dart';
import 'package:app/constants/constant.dart';
import 'package:app/model/coin_model.dart';
import 'package:app/widgets/empty_card.dart';

class Coins extends StatelessWidget {

  const Coins({
    Key key,
    this.item,
    this.data,
    this.press,
  }) : super(key: key);

  final int item;
  final Coin data;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: InkWell(
        onTap:press,
        child:EmptyCard(
          width: MediaQuery.of(context).size.width,
          height: 88.0,
          child: Stack(
            children: <Widget>[
              Positioned(
              top:20,
              left: -30,
              child: Hero(
              tag: '${data.symbol}',
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:kDefaultPadding),
                height: 50,
                width: 150,
                child: Image.network(data.image,
                fit:BoxFit.fitHeight
                ),
              ),
            )),
            Padding(
            padding: const EdgeInsets.only(right: 100,top: 30),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(data.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ))),
                Center(
                  child: Text(data.symbol.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    
                    fontWeight: FontWeight.bold
                )))
              ],
            ),
          ),
          
               Positioned(
                 top:20,
                 right: 5,
                  child: Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Text('Price: '+'\$'+data.currentPrice.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ))
                      ),
                      Padding(
                    padding: const EdgeInsets.only(left :16.0,top:10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:4.0),
                          child: data.percentChange > 0 ? Icon(Icons.arrow_drop_up,color:Colors.green) : Icon(Icons.arrow_drop_down, color: Colors.red,)
                        ),
                        Text(  data.percentChange.toStringAsFixed(3),
                        style: TextStyle(color:data.percentChange < 0 ? Colors.red : Colors.green,fontWeight: FontWeight.bold, fontSize: 14.0)),
                      ],
                    ),
                  ),
                    ],),
                  ),
               ),
          ],
          ),
        ),
      )
    );
  }
}