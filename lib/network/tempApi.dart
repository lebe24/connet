import 'dart:convert';
import 'package:app/model/bilionaire_model.dart';
import 'package:app/model/coin_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<List<Data>> fetchNotes() async {
  // var url = 'https://forbes400.herokuapp.com/api/forbes400/getAllBillionaires';
     var url =  'https://forbes400.herokuapp.com/api/forbes400/getAllBillionaires';
    //  var response = await rootBundle.loadString('assets/newBillion.json');
    var response = await http.get(url);
    
    var notes = List<Data>();
    
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Data.fromJson(noteJson));
      }

    return notes;
  }
Future<List<Coin>> fetchCoin() async{
   var url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';
  // var response = await rootBundle.loadString('assets/coin.json');
  var response = await get(url);
  var coins = List<Coin>();
  var coinjson = json.decode(response.body);

  for(var coinjson in coinjson){
    coins.add(Coin.fromJson(coinjson));
  }

  return coins;
}
