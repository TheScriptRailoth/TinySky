class WeatherModel{
  final String city;
  final double temperature;
  final String condition;
  WeatherModel({required this.city, required this.condition, required this.temperature});

  factory WeatherModel.fromJson(Map<String,dynamic> json){
    return WeatherModel(
        city: json['name'],
        condition: json['weather'][0]['main'],
        temperature: json['main']['temp'].toDouble(),
    );
  }
}