import 'package:app/screens/newsstand/Screen.dart';
import 'package:app/screens/newsstand/stand_model.dart';
import 'package:app/widgets/sliding_cards.dart';
import 'package:flutter/material.dart';

class Scroll extends StatefulWidget {
  final List<Stand> images;
  final inde;
  final String title;
  final double imageHeight;
  final double imageWidth;
  final String imageUrl;
  final String desc;

  Scroll({
    this.images,
    this.inde,
    this.title,
    this.imageHeight,
    this.imageWidth,
    this.imageUrl,
    this.desc
  });

  @override
  _ScrollState createState() => _ScrollState();
}

class _ScrollState extends State<Scroll> {

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
            Container(
            height: widget.imageHeight,
            child: Expanded(
                child: ListView.builder(
                // padding: EdgeInsets.symmetric(horizontal: 30.0),
                scrollDirection: Axis.horizontal,
                itemCount: widget.inde,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  width: widget.imageWidth,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          widget.imageUrl,
                          height: MediaQuery.of(context).size.width * 0.37,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 2),
                      Expanded(
                      child: CardContent(
                        name: widget.desc,
                        date: '',
                      ),
                    )
                    ],
                  ),
                    );
                },
              ),
            ),
          ),
      ],
    );
  }
}
