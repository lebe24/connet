class NewsCategory{
  String status;
  int totalResult;
  List<Article> articles;
  String error;
  
    NewsCategory.fromJson(Map<String, dynamic> json)
          :status = json['status'],totalResult = json['totalResults'],
           articles = json['articles'];
           
    NewsCategory.withError(this.error);
  }
  
  class Article {
    Source source;
    String author, title, description, url, urlToImage, publishedAt, content;
    
    Article.fromJson(Map<String, dynamic> json)
      : source = json['source'],author = json['author'] == null ? '' : json['author'],title = json['title'],description = json['description'],
        url = json['url'], urlToImage = json['urlToImage'] == null ? null : json['urlToImage']  , publishedAt = json['publishedAt'], content = json['content'];
  }
  
  class Source {
    String name;

    Source.formJson(Map<String, dynamic> json)
      : name = json['name'] == null ? 'no-name' : json['name'];
}