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
    List<dynamic> listData = json['hourly'];
    List<String> timeValue = <String>[];
    List<String> conditionValues= <String>[];
    List<double> tempValues= <double>[];


    for(int i=0;i<listData.length;i++){

      var time=listData[i]['dt'];
      var dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000, isUtc: true);
      var formattedTime = dateTime.toString();


      double temp=(listData[i]['temp'].toDouble())-273.15;
      String condition= listData[i]['weather'][0]['main'];
      conditionValues.add(condition);
      timeValue.add(formattedTime);
      tempValues.add(temp);
    }
    return HourlyWidgetModel(
      temperature: tempValues,
      time: timeValue,
      condition: conditionValues,
    );
  }
}