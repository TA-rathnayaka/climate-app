import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future<dynamic> getData() async {
    var url = Uri.parse(this.url);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return JsonDecoder().convert(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
