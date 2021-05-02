import 'package:flutter/material.dart';
import 'package:app/screens/newsfeed/widget.dart';
import 'package:app/screens/newsstand/Screen.dart';
import 'package:app/screens/newsstand/stand_model.dart';
import 'package:app/screens/newsstand/widgets/content_scroll.dart';

class NewsStand extends StatefulWidget {
  @override
  _NewsStandState createState() => _NewsStandState();
}

class _NewsStandState extends State<NewsStand> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  _standSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Screen(
              stand: stand[index]),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Hero(
                    tag: stand[index].image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: AssetImage(stand[index].image),
                        height: 220.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'EXPLO',
                style:TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
              "RER",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
            ],
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search, color: Colors.blue,),onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            })
          ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 280.0,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: stand.length,
              itemBuilder: (context,index){
                return _standSelector(index);
              }
            ),
          ),
          SizedBox(height: 10.0),
          ContentScroll(
            images: myList,
            title: 'Entertainment',
            imageHeight: 150.0,
            imageWidth: 150.0,
          ),
          SizedBox(height: 10.0),
          ContentScroll(
            images: spt,
            title: 'Sport',
            imageHeight: 150.0,
            imageWidth: 150.0,
          ),
          ContentScroll(
            images: tech,
            title: 'Technology',
            imageHeight: 150.0,
            imageWidth: 150.0,
          ),
          ContentScroll(
            images: sci,
            title: 'Science',
            imageHeight: 150.0,
            imageWidth: 150.0,
          ),
          ContentScroll(
            images: comdy,
            title: 'comedy',
            imageHeight: 150.0,
            imageWidth: 150.0,
          ),
          ContentScroll(
            images: doc,
            title: 'Documentry',
            imageHeight: 150.0,
            imageWidth: 150.0,
          ),
          ContentScroll(
            images: review,
            title: 'Reviewer',
            imageHeight: 150.0,
            imageWidth: 150.0,
          ),
        ],
      ),
    );
  }
}