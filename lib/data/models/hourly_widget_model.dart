class HourlyWidgetModel{
  final List<double> temperature;
  final List<String> time;
  final List<String> condition;

  HourlyWidgetModel({
    required this.temperature,
    required this.time,
    required this.condition,
  });

  factory HourlyWidgetModel.fromJson(Map<String,dynamic> json){
    List<double> tempValues= <double>[];
    List<dynamic> listData = json['list'];
    List<String> timeValue = <String>[];
    List<String> conditionValues= <String>[];

    for(int i=0;i<listData.length;i++){
      double temp=listData[i]['main']['temp'].toDouble();
      String time=listData[i]['dt_txt'];
      String condition= listData[i]['weather'][0]['main'];
      conditionValues.add(condition);
      timeValue.add(time);
      tempValues.add(temp);
    }
    return HourlyWidgetModel(
      temperature: tempValues,
      time: timeValue,
      condition: conditionValues,
    );
  }
}