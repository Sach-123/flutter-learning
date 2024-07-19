import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_headline/models/news.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl =
      "https://newsapi.org/v2/top-headlines?apiKey=${dotenv.env["NEWS_API_KEY"]}";

  Future<List<News>> fetchNews({String? query, String? countryCode}) async {
    String url = baseUrl;
    if (countryCode != null) {
      url += "&country=$countryCode";
    } else {
      url += "&country=in";
    }
    if (query != null) {
      url += "&q=$query";
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      List<dynamic> articles = result["articles"];
      List<News> newss = articles.map((news) => News.fromJson(news)).toList();
      return newss;
    } else {
      throw Exception("Failed to get News");
    }
  }
}
