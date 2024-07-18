// https://www.omdbapi.com/?apikey=3f65a517&s=

import 'dart:convert';

import 'package:movie_buddy/models/movie.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = "https://www.omdbapi.com/?apikey=3f65a517&s=";

  Future<List<Movie>> fetchMovies(String query) async {
    String url = baseUrl + query;

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> movieResults = jsonResponse["Search"];
      List<Movie> movies =
          movieResults.map((movie) => Movie.fromJson(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load movies");
    }
  }
}
