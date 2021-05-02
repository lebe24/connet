import 'package:app/screens/newsfeed/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {

  String api1  ='a50cb8c0c4a54a828d4986bf64b3dbf3';

  List<Article> news  = [];

  Future<void> getNews() async{

    String url ='https://newsapi.org/v2/top-headlines?country=ng&apiKey=$api1';
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }
}


class NewsForCategorie {

   String api1  ='a50cb8c0c4a54a828d4986bf64b3dbf3';


  List<Article> news  = [];

  Future<void> getNewsForCategory(String category) async{

    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url = "http://newsapi.org/v2/top-headlines?country=ng&category=$category&apiKey=$api1";
    String urll ='https://newsapi.org/v2/everything?domains=tomsguide.com,nintendolife.com/&apiKey=2ac90714e5324641a0494a7770e95c2f';
    
    
    var response = await http.get(url);

    var give = await http.get(urll);


    var jsonData = jsonDecode(response.body);
    var givedata = jsonDecode(give.body);
    
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }
  }
}

class NewStand{
  String api2 = '2ac90714e5324641a0494a7770e95c2f';

  List<Article> news  = [];

  Future<void> getDomainNew(String domain) async{

    var url = 'https://newsapi.org/v2/everything?domains=$domain&language=en&apiKey=$api2';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }
  }
}

class NewsSearch {
  String api2 = '2ac90714e5324641a0494a7770e95c2f';

  List<Article> news  = [];

  Future<void> getSearch(String search) async {
    var url = 'http://newsapi.org/v2/everything?q=$search&language=en&sortBy=publishedAt&apiKey=$api2';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }
  }
}