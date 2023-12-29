import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../../models/hourly_widget_model.dart';
class HourlyWidgetData{
  static const url="https://api.openweathermap.org/data/2.5/weather";

  HourlyWidgetData();
  Future<HourlyWidgetModel>getHourlyData() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final response2= await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&exclude=minutely,currently,current&appid=105d997a8a1977cb138167503eb7afa1'));
    if(response2.statusCode==200){
      print("Respose 2: ${response2.body}");
      return HourlyWidgetModel.fromJson(jsonDecode(response2.body));
    }else{
      throw Exception('Failed to get weather data');
    }
  }
}