import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? cityName;
  Map<String, dynamic>? weatherData;
  String? temperature;
  String? description;

  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentCity().then((city) {
      setState(() {
        cityName = capitalize(city);
        getCurrentWeather().then((data) {
          setState(() {
            weatherData = data;
            temperature = "${weatherData!['main']['temp']} °C";
            description = capitalize(weatherData!['weather'][0]['description']);
          });
        }).catchError((error) {
          weatherData = error;
        });
      });
    }).catchError((error) {
      setState(() {
        cityName = error;
      });
    });
  }

  Future getCurrentCity() async {
    String baseUrl = "https://ipinfo.io/json?token=";
    String? token = dotenv.env['API_TOKEN'];
    String url = "$baseUrl$token";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["city"];
    } else {
      throw Exception('Failed to load city data: ${response.statusCode}');
    }
  }

  Future getCurrentWeather() async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${dotenv.env["WEATHER_APIKEY"]}&units=metric";
    print(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  String capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Weather Meter",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF143D4C),
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF143D4C), Color(0xFF042024)])),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        controller: cityController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: Colors.white,
                            hintText: "Enter City Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                            fillColor: Colors.white)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        cityName = capitalize(cityController.text);
                        cityController.text = "";
                        getCurrentWeather().then((data) {
                          setState(() {
                            weatherData = data;
                            temperature =
                                "${weatherData!['main']['temp']} °C";
                            description = capitalize(
                                weatherData!['weather'][0]['description']);
                          });
                        }).catchError((error) {});
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        minimumSize: const Size(100, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      child: const Text("Search"))
                ],
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cityName ?? "Loading...",
                        style: const TextStyle(
                            fontSize: 42,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        temperature ?? "Loading...",
                        style: const TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontWeight: FontWeight.w200),
                      ),
                      Text(
                        description ?? "Loading...",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
