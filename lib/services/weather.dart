import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'networking.dart';
import 'location.dart';

class WeatherModel {
  String? apiAddress;
  String? apiKey;

  Future<dynamic> getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();
    await dotenv.load(fileName: ".env");
    apiAddress = dotenv.env['API_URL'] ?? '';
    apiKey = dotenv.env['API_KEY'] ?? '';

    NetworkHelper networkHelper = NetworkHelper(
        url:
            '${apiAddress}?lat=${location.latitude}&lon=${location.longitude}&appid=${apiKey}&units=metric');
    return networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
