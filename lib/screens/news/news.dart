import 'package:flutter/material.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Daily',
                style:TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
              "NEWS",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
            ],
          )
        )
      ),
    );
  }
}