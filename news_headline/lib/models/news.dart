class News {
  String? title;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;

  News({this.title, this.url, this.urlToImage, this.publishedAt});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        title: json['title'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: DateTime.parse(json['publishedAt']));
  }
}
