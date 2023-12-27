import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/weather_model.dart';
import 'package:http/http.dart' as http;
class WeatherData{
  static const url="https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherData(this.apiKey);
  Future<WeatherModel>getWeatherData(String city) async{
      final response= await http.get(Uri.parse('$url?q=$city&appid=$apiKey&units=metric'));
      if(response.statusCode==200){
        return WeatherModel.fromJson(jsonDecode(response.body));
      }else{
        throw Exception('Failed to get weather data');
      }
  }
  Future<String> currentCity() async{
    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks= await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city=placemarks[0].locality;
    return city??"";
  }
}