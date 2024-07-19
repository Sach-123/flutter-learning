import 'package:flutter/material.dart';
import "../models/news.dart";
import '../services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<News> _news = [];
  Map<String, String> countryCodes = {
    "Argentina": "ar",
    "Australia": "au",
    "Austria": "at",
    "Belgium": "be",
    "Brazil": "br",
    "Bulgaria": "bg",
    "Canada": "ca",
    "China": "cn",
    "Colombia": "co",
    "Cuba": "cu",
    "Czech Republic": "cz",
    "Egypt": "eg",
    "France": "fr",
    "Germany": "de",
    "Greece": "gr",
    "Hong Kong": "hk",
    "Hungary": "hu",
    "India": "in",
    "Indonesia": "id",
    "Ireland": "ie",
    "Israel": "il",
    "Italy": "it",
    "Japan": "jp",
    "Latvia": "lv",
    "Lithuania": "lt",
    "Malaysia": "my",
    "Mexico": "mx",
    "Morocco": "ma",
    "Netherlands": "nl",
    "New Zealand": "nz",
    "Nigeria": "ng",
    "Norway": "no",
    "Philippines": "ph",
    "Poland": "pl",
    "Portugal": "pt",
    "Romania": "ro",
    "Russia": "ru",
    "Saudi Arabia": "sa",
    "Serbia": "rs",
    "Singapore": "sg",
    "Slovakia": "sk",
    "Slovenia": "si",
    "South Africa": "za",
    "South Korea": "kr",
    "Sweden": "se",
    "Switzerland": "ch",
    "Taiwan": "tw",
    "Thailand": "th",
    "Turkey": "tr",
    "UAE": "ae",
    "Ukraine": "ua",
    "United Kingdom": "gb",
    "United States": "us",
    "Venezuela": "ve"
  };
  final ApiService _apiService = ApiService();
  String? selectedCountry;

  void getNews({String? country, String? query}) async {
    _news = await _apiService.fetchNews(countryCode: country, query: query);
    setState(() {
      _news;
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception("Could not launch $url");
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF134B70),
        appBar: AppBar(
          title: const Text(
            'Breaking News',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF201E43),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ]),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Select Country:",
                          style: TextStyle(fontSize: 20),
                        ),
                        DropdownButton(
                          icon: const Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          menuMaxHeight: 400,
                          items: countryCodes.keys.map((element) {
                            return DropdownMenuItem(
                              value: element,
                              child: Text(element),
                            );
                          }).toList(),
                          onChanged: (String? val) {
                            selectedCountry = val;
                            getNews(country: countryCodes["$selectedCountry"]);
                          },
                          value: selectedCountry ?? "India",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          label: Text("Search For news"),
                          labelStyle: TextStyle(fontSize: 20),
                          suffixIcon: Icon(Icons.search)),
                      onSubmitted: (String? val) {
                        getNews(
                            country: countryCodes["$selectedCountry"],
                            query: val);
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                // itemExtent: 100,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: _news.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Image.network(_news[index].urlToImage ??
                          "https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM="),
                      title: Text(_news[index].title ?? "404"),
                      trailing: Text(
                        _news[index].publishedAt == null
                            ? "Unknown"
                            : "${DateFormat("dd MMMM yyyy").format(_news[index].publishedAt!)} \n${DateFormat('jm').format(_news[index].publishedAt!)}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      tileColor: const Color(0xFFFFF1DB),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      onTap: () {
                        _news[index].url != null
                            ? _launchUrl(_news[index].url!)
                            : null;
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
