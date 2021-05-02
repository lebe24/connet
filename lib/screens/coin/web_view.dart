import 'package:app/model/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailBody extends StatelessWidget {
  final Coin data;

  const DetailBody({Key key,this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String name = data.id;
    return Scaffold(

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.share,color:Colors.black))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: WebViewClass(
        name:'https://www.coingecko.com/en/coins/$name'
      ),
    );
  }
}

class WebViewClass extends StatefulWidget {
  final String name;

  WebViewClass({
    Key key,
    this.name
  }) : super(key: key);
 
  WebViewState createState() => WebViewState();
 
}
 
class WebViewState extends State<WebViewClass>{
 
  num position = 1 ;
 
  final key = UniqueKey();
 
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }
 
  startLoading(String A){
    setState(() {
      position = 1;
    });
  }
 
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: IndexedStack(
      index: position,
      children: <Widget>[
 
      WebView(
        initialUrl:widget.name,
        javascriptMode: JavascriptMode.unrestricted,
        key: key ,
        onPageFinished: doneLoading,
        onPageStarted: startLoading,
        ),
 
       Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator()),
        ),
        
      ])
  );
  }
  }