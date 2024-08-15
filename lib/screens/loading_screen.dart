import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clima/services/networking.dart';

String? apiAddress;
String? apiKey;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    await dotenv.load(fileName: ".env");
    apiAddress = dotenv.env['API_URL'] ?? '';
    apiKey = dotenv.env['API_KEY'] ?? '';

    NetworkHelper networkHelper = NetworkHelper(
        url: '${apiAddress}?lat=${location.latitude}&lon=${location.longitude}&appid=${apiKey}&units=metric');
    var whetherData = await networkHelper.getData();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LocationScreen(locationWhether: whetherData,)));
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color:Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
