
import 'dart:io';

import 'package:app/screens/newsfeed/category_news.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/newsfeed/article_view.dart';


class DataSearch extends SearchDelegate<String>{

  final cities =[''];

  final recentcities =[];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = '';
    })];
  }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
                icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
            onPressed: (){
              close(context, null);
            },);
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return NewSearch(
        search: query,
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      final suggestionList = query.isEmpty ? recentcities : cities;

      return ListView.builder(
        itemBuilder: (context, index) =>ListTile(
          title: Text(suggestionList[index]),
        ),
        itemCount: suggestionList.length,
      );
  }

}

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;

  NewsTile({this.imgUrl, this.desc, this.title, this.content, @required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              postUrl: posturl,
            )
        ));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imgUrl,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                        },
                        placeholder: (context, url) => Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: Platform.isAndroid
                                  ? CircularProgressIndicator()
                                  : CupertinoActivityIndicator(),
                            ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/img_not_found.jpg',
                           fit: BoxFit.cover,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      // child: Image.network(
                      //   imgUrl,
                      //   height: 200,
                      //   width: MediaQuery.of(context).size.width,
                      //   fit: BoxFit.cover,
                      // )
                  ),
                  SizedBox(height: 12,),
                  Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 14),
                  )
                ],
              ),
            ),
          )),
    );
  }
}



