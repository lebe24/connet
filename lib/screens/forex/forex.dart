import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart';

class Forex extends StatefulWidget {
  @override
  _ForexState createState() => _ForexState();
}

class _ForexState extends State<Forex> {

  var dropdownValue, data, selectedCurrency;


  Future loadForex(String name) async {
   String url = 'https://finnhub.io/api/v1/forex/rates?base=$name&token=bs34q1frh5rcraslb4h0';

   //String jsonString = await rootBundle.loadString('assets/ex.json');

  var jsonString = await get(url);
  final jsonResponse = json.decode(jsonString.body);

  if(mounted){
    setState(() {
    data = jsonResponse;
  });
  }

}


@override
  void initState(){
    this.loadForex('NGN');
  }

  List<Map> _myJson = [
    
    {"id": 'Nigeria', "image": "assets/country/nigria.png", "name": "NGN"},
    {"id": 'USA', "image": "assets/country/usd.png", "name": "USD"},
    {"id": 'Euro', "image": "assets/country/eur.png", "name": "EUR"},
    {"id": 'Canada', "image": "assets/country/cad.png", "name": "CAD"},
    {"id": 'British', "image": "assets/country/british.png", "name": "GBP"},
    {"id": 'China', "image": "assets/country/china.png", "name": "CNY"},
    {"id": 'Ghana', "image": "assets/country/ghana.png", "name": "GHS"},
    {"id": 'Mexico', "image": "assets/country/mexico.png", "name": "MXN"},
    {"id": 'Austrial', "image": "assets/country/austrial.png", "name": "AUD"},
    {"id": 'Hong Kong', "image": "assets/country/honkong.png", "name": "HKD"},
    {"id": 'kenya', "image": "assets/country/kenya.png", "name": "KES"},
    {"id": 'SA', "image": "assets/country/sa.png", "name": "ZAR"},
    {"id": 'Sengal', "image": "assets/country/sengal.png", "name": "XOF"},
    {"id": 'Brazil', "image": "assets/country/brazil.png", "name": "BRL"},
    {"id": 'Korea', "image": "assets/country/korea.png", "name": "KRW"},
    {"id": 'UAE', "image": "assets/country/uae.png", "name": "AED"},
    {"id": 'Egypt', "image": "assets/country/egypt.png", "name": "EGP"},
    {"id": 'Singapore', "image": "assets/country/sinapore.png", "name": "SGD"},

    ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child:Column(
        children: <Widget>[
          Container(
            width: 200,
            alignment: Alignment.topLeft,
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
             hint:  Padding(
               padding: const EdgeInsets.only(left: 1.0),
               child: Text("Currency",
               style: TextStyle(
                 fontWeight:FontWeight.bold
               )),
             ),
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
                 value: map["name"].toString(),
                 // value: _mySelection,
                 child: Row(
                   children: <Widget>[
                     Image.asset(
                       map["image"],
                       width: 30,
                     ),
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
              future: loadForex(dropdownValue),
              builder: (context,snapshot){
                return  ListView(
              padding: const EdgeInsets.all(3.0),
               children: <Widget>[
                 buildContainer(dropdownValue,'EUR',data['quote']['EUR'].toStringAsFixed(3), "assets/country/eur.png"),
                 buildContainer(dropdownValue,'NGN',data['quote']['NGN'].toStringAsFixed(3), 'assets/country/nigria.png'),
                 buildContainer(dropdownValue,'GBP',data['quote']['GBP'].toStringAsFixed(3),'assets/country/british.png'),
                 buildContainer(dropdownValue,'USD',data['quote']['USD'].toStringAsFixed(3),'assets/country/usd.png'),
                 buildContainer(dropdownValue,'CAD',data['quote']['CAD'].toStringAsFixed(3),'assets/country/cad.png'),
                buildContainer(dropdownValue,'KRW',data['quote']['KRW'].toStringAsFixed(3),'assets/country/korea.png'),
                  buildContainer(dropdownValue,'HKD',data['quote']['HKD'].toStringAsFixed(3),'assets/country/honkong.png'),
                  buildContainer(dropdownValue,'MXN',data['quote']['MXN'].toStringAsFixed(3),'assets/country/mexico.png'),
                  buildContainer(dropdownValue,'AUD',data['quote']['AUD'].toStringAsFixed(3),'assets/country/austrial.png'),
                  buildContainer(dropdownValue,'EGP',data['quote']['EGP'].toStringAsFixed(3),'assets/country/egypt.png'),
                  buildContainer(dropdownValue,'ZAR',data['quote']['ZAR'].toStringAsFixed(3),'assets/country/sa.png'),
                  buildContainer(dropdownValue,'BRL',data['quote']['BRL'].toStringAsFixed(3),'assets/country/brazil.png'),

               ],
            );
              }
            )
          )
        ],
      )
    );
  }

  Widget buildContainer(String base,String quote,String value , String img){
    return Container(
      margin: EdgeInsets.all(5),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            blurRadius: 4.0,
            offset: const Offset(0.0, 4.0),
          ),
        ]
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(img),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left:50.0),
              child: Text(base + "/"+quote),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(value,
            style: TextStyle(
              fontSize: 16,
              fontWeight:FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}


// ===============================================
// Container(
//                     margin: EdgeInsets.all(5),
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: const BorderRadius.all(Radius.circular(4.0)),
//                       boxShadow: <BoxShadow>[
//                         BoxShadow(
//                           color: Colors.black,
//                           blurRadius: 4.0,
//                           offset: const Offset(0.0, 4.0),
//                         ),
//                       ],
//                     ),
//                   child:Row(
//                     children: <Widget>[
//                       Image.asset('assets/banks/usd.png'),
//                       Text('wahat')
//                     ]
//                     )
//                 );

//   Column(
//         children:<Widget>[
//        Container(
//           padding:
//         EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//   decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(5)),

//   // dropdown below..
//   child: DropdownButton<String>(
//     isDense: true,
//         value: dropdownValue,
//         hint: new Text("Currency"),
//         icon: Icon(Icons.arrow_drop_down),
//         iconSize: 42,
//         underline: SizedBox(),
//         onChanged: (String newValue) {
//           setState(() {
//             dropdownValue = newValue;
//           });
//         },
//         items: _myJson.map((Map map) {
//         return new DropdownMenuItem<String>(
//           value: map["id"].toString(),
//           // value: _mySelection,
//           child: Row(
//             children: <Widget>[
//               Image.asset(
//                 map["image"],
//                 width: 25,
//               ),
//               Container(
//                   margin: EdgeInsets.only(left: 10),
//                   child: Text(map["name"])),
//             ],
//           ),
//         );
//       }).toList()),
// ),
//           AutoRefresh(
//       duration: const Duration(milliseconds: 2000),
//       child: Scaffold(
//         body: SafeArea(
//           child: AnimationLimiter(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(8.0),
//               itemCount: 100,
//               itemBuilder: (BuildContext context, int index) {
//                 return AnimationConfiguration.staggeredList(
//                   position: index,
//                   duration: const Duration(milliseconds: 375),
//                   child: SlideAnimation(
//                     verticalOffset: 44.0,
//                     child: FadeInAnimation(
//                       child: EmptyCard(
//                         width: MediaQuery.of(context).size.width,
//                         height: 88.0,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),)
//         ]
//     );