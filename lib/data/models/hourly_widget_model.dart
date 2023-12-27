
class HourlyWidgetModel{
  final double temperature;
  final String condition;
  HourlyWidgetModel({
    required this.condition,
    required this.temperature,
  });

  factory HourlyWidgetModel.fromJson(Map<String,dynamic> json){
    return HourlyWidgetModel(
      condition: json['weather'][0]['main'],
      temperature: json['main']['temp'].toDouble(),
    );
  }
}