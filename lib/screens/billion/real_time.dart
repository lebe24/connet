import 'dart:io';

import 'package:app/model/bilionaire_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/constant.dart';

class RealTime extends StatelessWidget {

  const RealTime({
    Key key,
    this.item,
    this.data,
    this.press,
  }) : super(key: key);

  final int item;
  final Data data;
  final Function press;

  

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding / 2,),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            blurRadius: 4.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: InkWell(
        onTap: press,
        child: Stack(
            children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            Positioned(
              top:5,
              left: -30,
              child: Hero(
              tag: data.personName,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:kDefaultPadding),
                height: 120,
                width: 200,
                // child: Image.asset('assets/416x416.jpg')
                // child: Image.network('https:'+ data.squImage,
                // fit:BoxFit.fitHeight
                // ),
                child: CachedNetworkImage(
                  imageUrl:'https:'+ data.squImage,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit:BoxFit.fitHeight
                        )
                      )
                    );
                  },
                  placeholder: (context, url) =>Container(
                    child: Center(
                    child: Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator(),
                  )),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/img_not_found.jpg',
                    fit: BoxFit.fitHeight,
                    
                  ),
                ),
              ),
          )),
          
          Positioned(
            top: 15,
            right: 0,
            child: SizedBox(
              height:MediaQuery.of(context).size.height,
              width: size.width - 200,
              child:Column(
          
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Center(
              child: Text('${data.rank}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ))),
          ),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(data.personName.toUpperCase(),
                    style: TextStyle(
                      fontSize:data.personName.length >= 34 ? 11 : 14,
                      fontWeight: FontWeight.bold
                    ))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left :16.0,top:2.0),
                    child:data.industries[0] == null ? Text('') : Text(data.industries[0],
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 14.0)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:2.0),
                    child: Divider(
                      // color:Colors.black,
                      thickness: 5,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left : 8),
                        child: Text('\$'+ datanum(data.finalWealth).toString() + ' B',
                        style: TextStyle(
                          fontWeight:FontWeight.bold
                        ),
                        ),
                       // child:Text(datanum(data.finalWealth).toString())
                      ),
                      // perChange(data.finalWealth, data.preWealth) <= 0 ? Icon(Icons.arrow_drop_down,color:Colors.red, size:30) : Icon(Icons.arrow_drop_up,color:Colors.green, size:20),
                      _buildIcon(perChange(data.finalWealth, data.preWealth)),
                      Padding(
                        padding: const EdgeInsets.only(left :0.0),
                        child: Text(netChange(data.finalWealth, data.preWealth) > 0 ? netChange(data.finalWealth, data.preWealth).toString().length > 5 ? (netChange(data.finalWealth, data.preWealth)/1000).toStringAsFixed(1) + 'B' : netChange(data.finalWealth, data.preWealth).toString() + "M"
                          : netChange(data.finalWealth, data.preWealth).toString().replaceAll(RegExp('-'), '').length > 5 ? (netChange(data.finalWealth, data.preWealth)/1000).toStringAsFixed(1).replaceAll(RegExp('-'), '') + "B" : netChange(data.finalWealth, data.preWealth).toString().replaceAll(RegExp('-'), '') + "M",
                          style: TextStyle(
                            color:_buildColor(netChange(data.finalWealth, data.preWealth)),
                            // color: netChange(data.finalWealth, data.preWealth) >= 0 ? Colors.green : Colors.red,
                            fontWeight:FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:1.0),
                        child: Text('| '+ perChange(data.finalWealth, data.preWealth).toString() + "%",
                          style: TextStyle(
                            color: _buildColor(perChange(data.finalWealth, data.preWealth)),
                            // color: perChange(data.finalWealth, data.preWealth) >= 0 ? Colors.green : Colors.red,
                            fontWeight:FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            )
          )
        ])
      ),
    );
  }

  double datanum( var x){
    double no = x / 1000;
    double p = num.parse(no.toStringAsFixed(1));

    return p;
  }

  double netChange(var x , var y){
    var no = x -y;

    return num.parse(no.toStringAsFixed(1));
  }

  double perChange(var x , var y){
    var no = ((x-y)/x) * 100;

    return num.parse(no.toStringAsFixed(2));
  }
}

Color _buildColor(double n){
  if(n > 0){
    return Colors.green;
  }else if( n < 0){
    return Colors.red;
  }else{
    return Colors.black;
  }
}

Widget _buildIcon(double n){

  if(n > 0){
   return  Icon(Icons.arrow_drop_up,color:Colors.green, size:30);
  }else if(n < 0){
    return Icon(Icons.arrow_drop_down,color:Colors.red, size:30);
  }else{
    return Text('    ');
  }
}