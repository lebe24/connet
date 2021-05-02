
import 'dart:io';

import 'package:app/screens/newsfeed/article_view.dart';
import 'package:app/widgets/sliding_cards.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/network/newsfeed.dart';
import 'package:app/screens/newsfeed/article_model.dart';
import 'package:app/screens/newsfeed/category_news.dart';
import 'package:app/screens/newsfeed/data.dart';
import 'package:app/screens/newsfeed/widget.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List<CategorieModel> categories = List<CategorieModel>();
  var newslist;

  bool _loading;

   @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'DAILY',
                style:TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
              "NEWS",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
            ],
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search,color:Colors.blue),onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            })
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      body: SafeArea(
        child: _loading ? Center(child: Image.asset('assets/category/icon_refresh3.gif')): Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listCategories.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        image: listCategories[index].image,
                        categoryName: listCategories[index].title,
                      );
                    }),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: newslist.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ArticleView(
                                  postUrl: newslist[index].articleUrl ?? "",
                                )
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 300,
                              child: Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                                color: Colors.white,
                                child: Column(
                                  children:<Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                                      child:CachedNetworkImage(
                          imageUrl: newslist[index].urlToImage ?? "",
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: double.infinity,

                            child: Center(
                              child: Platform.isAndroid
                                  ? CircularProgressIndicator()
                                  : CupertinoActivityIndicator(),
                            ),
                          ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/img_not_found.jpg',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                              ),
                            ),
                                    ),
                                    SizedBox(height: 8),
                                    Expanded(
                                      child: CardContent(
                                        name: newslist[index].title ?? "",
                                        date: ''
                                      ),
                                    )
                                  ]
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  ),
              ],)
          ),
        )
    
    );
  }
}

class CategoryCard extends StatelessWidget {
  CategoryCard({this.image, this.categoryName,this.cat});

  final String image, categoryName,cat;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            newsCategory: categoryName.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(image,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
