
class WeatherModel{
  final String city;
  final double temperature;
  final String condition;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final double humidity;
  final double windSpeed;
  WeatherModel({
    required this.city,
    required this.condition,
    required this.temperature,
    required this.feelsLike,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String,dynamic> json){
    return WeatherModel(
        city: json['name'],
        condition: json['weather'][0]['main'],
        temperature: json['main']['temp'].toDouble(),
        feelsLike: json['main']['feels_like'].toDouble(),
        maxTemp:  json['main']['temp_max'].toDouble(),
        minTemp:  json['main']['temp_min'].toDouble(),
        humidity: json['main']['humidity'].toDouble(),
        windSpeed: json['wind']['speed'].toDouble(),
      );
  }
}