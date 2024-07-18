import 'package:flutter/material.dart';
import 'package:movie_buddy/models/movie.dart';
import 'package:movie_buddy/services/api_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ApiService _apiServices = ApiService();
  List<Movie> movies = [];
  final TextEditingController _movieController = TextEditingController();

  void _searchMovies({String? title}) async {
    try {
      String query = title ?? "batman";
      movies = await _apiServices.fetchMovies(query);
      setState(() {
        movies;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _searchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movie Buddy"),
        ),
        backgroundColor: Colors.amber.shade100,
        body: Column(
          children: [
            Container(
                color: Colors.amber.shade100,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _movieController,
                  onSubmitted: (String text) {
                    _searchMovies(title: text);
                    _movieController.text = "";
                  },
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      hintText: "Search for a movie",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.all(10)),
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: movies.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 100,
                      child: ListTile(
                        leading: movies[index].poster != "N/A"
                            ? Image.network(
                                movies[index].poster,
                              )
                            : const Icon(Icons.image_not_supported),
                        title: Text(
                          movies[index].title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          movies[index].year,
                        ),
                        trailing: Text(
                          movies[index].type,
                          style: const TextStyle(fontSize: 16),
                        ),
                        tileColor: Colors.white,
                        minTileHeight: 100,
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
