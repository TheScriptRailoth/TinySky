import 'package:flutter/material.dart';
import 'package:tiny_sky/data/datasources/remote/weather_data.dart';
import 'package:tiny_sky/data/models/weather_model.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _weatherData = WeatherData('672dd5784d1ee2fff09d6767c38498c7');
  WeatherModel? _weatherModel;

  _fetchWeather() async{
    String cityName = await _weatherData.currentCity();

    try{
      final weather=await _weatherData.getWeatherData(cityName);
      setState(() {
          _weatherModel=weather;
      });
    }
    catch (e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weatherModel?.city??"Loading City..."),
          Text("${_weatherModel?.temperature.round()}\u00B0C"),
        ],
      ),
    );
  }
}
