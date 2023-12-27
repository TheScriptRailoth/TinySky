import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../../models/hourly_widget_model.dart';
class HourlyWidgetData{
  static const url="https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  HourlyWidgetData(this.apiKey);
  Future<HourlyWidgetModel>getHourlyData(String city) async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final response2= await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&exclude=hourly&appid=$apiKey&units=metric'));
    if(response2.statusCode==200){
      print(response2.body);
      return HourlyWidgetModel.fromJson(jsonDecode(response2.body));
    }else{
      throw Exception('Failed to get weather data');
    }
  }
}