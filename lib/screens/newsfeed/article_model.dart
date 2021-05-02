class Article{

  String title;
  String author;
  String description;
  String urlToImage;
  DateTime publshedAt;
  String content;
  String articleUrl;

  Article({this.title,this.description,this.author,this.content,this.publshedAt,
    this.urlToImage, this.articleUrl});

}

class CategorieModel {
  String image;
  String categorieName;

  CategorieModel({this.image,this.categorieName});
}