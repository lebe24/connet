import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {

  var dropdownValue, data, selectedComp;

  Future loadStock(String id) async{
     String url = 'https://financialmodelingprep.com/api/v3/profile/FB?apikey=b6bcf1c61282d9db9c768bfb73b430a2';
      //  String jsonString = await rootBundle.loadString('assets/stocks.json');
    var jsonString = await get(url);
    final jsonResponse = json.decode(jsonString.body);
    
    print(jsonResponse[0]['image']);
    if(mounted){
      setState(() {
        data = jsonResponse;
      });
    }
    
  }

  @override
  void initState() {
    // TODO: implement initState
    this.loadStock('FB');
  }
  @override
  void dispose() {
    this.loadStock('FB');
  }

  List<Map> _myJson = [
    {'id':'AAPL', 'name': 'Apple Inc.'},
    {'id':'FB', 'name': 'Facebook Inc.'},
    {'id':'JMIA', 'name': 'Jumia Tec.'},
    {'id':'MSFT', 'name': 'Microsoft'}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children:<Widget>[
          Container(
           width: 200,
           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 4.0,
                  offset: const Offset(4.0, 4.0),
                ),
              ],
             color: Colors.white,
             borderRadius: BorderRadius.circular(5)),
          child: DropdownButton<String>(
            isDense: true,
             value: dropdownValue,
             hint: new Text("Currency"),
             icon: Icon(Icons.arrow_drop_down),
             iconSize: 42,
             underline: SizedBox(),
             onChanged: (String newValue) {
                 setState(() {
                   dropdownValue = newValue;
                 });
               },
            items: _myJson.map((Map map) {
               return new DropdownMenuItem<String>(
                 value: map["id"].toString(),
                 // value: _mySelection,
                 child: Row(
                   children: <Widget>[
                     Text(map["name"]),
                     Container(
                         margin: EdgeInsets.only(left: 10),
                         child: Text(map["id"])),
                   ],
                 ),
               );
             }).toList())
          ),
          SizedBox(height:10),
          Expanded(
            child:dropdownValue == null ? Center(child: Text('No Country Currency')) : FutureBuilder(
              future: loadStock('FB'),
              builder: (context, snapshot) {
                return Container(
                 child: Column(children: <Widget>[
                    Row(children: <Widget>[
                      Text(
                        data[0]['image'].toString()
                      )
                    ],)
                  ],)
                );
              },
            )
          )
        ]
      ),
    );
  }
}