import 'dart:io';

import 'package:app/screens/newsfeed/article_view.dart';
import 'package:app/widgets/sliding_cards.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/model/channel_model.dart';
import 'package:app/network/api_service.dart';
import 'package:app/network/newsfeed.dart';

import 'package:app/screens/newsstand/stand_model.dart';
import 'package:app/screens/newsstand/widgets/circular_clipper.dart';
import 'package:app/temp/temp4/model/video_model.dart';
import 'package:app/temp/temp4/video_screen.dart';


class Screen extends StatefulWidget {
  final Stand stand;

  Screen({this.stand});

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Channel _channel;
  bool _isLoading = false;
  bool _loading = true;
  var newslist;

  @override
  void initState() {
    getNews();
    _initChannel();
    // TODO: implement initState
    super.initState();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: widget.stand.channel);
    setState(() {
      _channel = channel;
    });
  }

  void getNews() async {
    NewStand  news = NewStand();
    await news.getDomainNew(widget.stand.title);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = true;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                    child: Hero(
                      tag: widget.stand.image,
                      child: ClipShadowPath(
                        clipper: CircularClipper(),
                        shadow: Shadow(blurRadius: 20.0),
                        child: Image(
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: AssetImage(widget.stand.image),
                        ),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     IconButton(
                  //       padding: EdgeInsets.only(left: 30.0),
                  //       onPressed: () => Navigator.pop(context),
                  //       icon: Icon(Icons.arrow_back),
                  //       iconSize: 30.0,
                  //       color: Colors.black,
                  //     ),
                  //     Text(widget.stand.title),
                  //     // Image(
                  //     //   image: AssetImage('assets/images/netflix_logo.png'),
                  //     //   height: 60.0,
                  //     //   width: 150.0,
                  //     // ),
                  //     IconButton(
                  //       padding: EdgeInsets.only(left: 30.0),
                  //       onPressed: () => print('Add to Favorites'),
                  //       icon: Icon(Icons.share),
                  //       iconSize: 30.0,
                  //       color: Colors.black,
                  //     ),
                  //   ],
                  // ),
                  Positioned.fill(
                    bottom: 10.0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RawMaterialButton(
                        padding: EdgeInsets.all(10.0),
                        elevation: 12.0,
                        onPressed: () => print('Play Video'),
                        shape: CircleBorder(),
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.star,
                          size: 60.0,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 5.0),
                ],
              ),
            Expanded(

            child:ListView(
              children:<Widget>[
                _loading ? Center(child: CircularProgressIndicator()):
            Column(
            // shrinkWrap: true,
             children: <Widget>[
             newslist.length == 0 ? Text('') : Column(
               children: <Widget>[
                 Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'NEWS',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height:  270,
                    child:ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newslist.length,
                      itemBuilder:  (context, index){
                        return GestureDetector(
                            onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ArticleView(
                                      postUrl: newslist[index].articleUrl ?? "",
                                    )
                                ));
                              },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 20.0,
                            ),
                               width:MediaQuery.of(context).size.width - 150,
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
                                children:<Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child:CachedNetworkImage(
                                      imageUrl: newslist[index].urlToImage ?? "",
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          height: MediaQuery.of(context).size.width * 0.37,
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
                                      height: MediaQuery.of(context).size.width * 0.37,
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
                                        height: MediaQuery.of(context).size.width * 0.37,
                                        width: double.infinity,
                                      )
                                    ),
                                  
                                  //   child: Image.network(
                                  //     newslist[index].urlToImage ?? "",
                                  //     height: MediaQuery.of(context).size.width * 0.37,
                                  //     width: double.infinity,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  ),
                                  SizedBox(height: 2),
                                  Expanded(
                                    child: CardContent(
                                        name:newslist[index].title == null ? ' No title ' : newslist[index].title,
                                      // name: '${newslist[index].title.length}',
                                      date: '',
                                    ),
                                  )
                                ]
                              ),
                            ),
                          );
                      }
                  )
                )
               ]
             ),
             _loading ? Text('') : Column(
               children: <Widget>[
                 Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'VIDEOS',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollDetails) {
                    if (!_isLoading &&
                      _channel.videos.length != int.parse(_channel.videoCount) &&
                      scrollDetails.metrics.pixels ==
                          scrollDetails.metrics.maxScrollExtent){
                            _loadMoreVideos();
                    }
                    return false;
                  },
                  child: Container(
                    height:  270,
                    child:_channel == null ? Text('') :ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _channel.videos.length,
                      itemBuilder: (context, index){
                        Video video = _channel.videos[index];
                         return GestureDetector(
                              onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => VideoScreen(id: video.id),
                                  ));
                                },
                             child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 20.0,
                              ),
                                 width:MediaQuery.of(context).size.width - 150,
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
                                  children:<Widget>[
                                    Stack(
                                      children: <Widget>[
                                       
                                       ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child:CachedNetworkImage(
                                          imageUrl:video.thumbnailUrl,
                                          imageBuilder: (context, imageProvider) {
                                            return Container(
                                              height: MediaQuery.of(context).size.width * 0.37,
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
                                            height: MediaQuery.of(context).size.width * 0.37,
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
                                             height: MediaQuery.of(context).size.width * 0.37,
                                             width: double.infinity,
                                          ),
                                        )
                                      ),
                                      ]),
                                    SizedBox(height: 2),
                                    Expanded(
                                      child: CardContent(
                                        name: video.title,
                                        date: '',
                                      ),
                                    )
                                  ]
                                ),
                              ),
                            );
                      }
                    )
                  ),
                )
               ],
             )
            ])]
            ))
         ])
        ),
      ),
    );
  }
}
