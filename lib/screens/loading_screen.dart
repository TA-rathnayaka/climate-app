import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String? apiAddress;
String? apiKey;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
  }

  void getData() async {
    await dotenv.load(fileName: ".env");
    apiAddress = dotenv.env['API_URL'] ?? '';
    apiKey = dotenv.env['API_KEY'] ?? '';
    var url = Uri.parse(
        '${apiAddress}?lat=${latitude}&lon=${longitude}&appid=${apiKey}');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = JsonDecoder().convert(response.body);
      double temperature = data['main']['temp'];
      String cityName = data['name'];
      int condition = data['weather'][0]['id'];
      print(temperature);
      print(cityName);
      print(condition);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
