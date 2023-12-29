import 'package:intl/intl.dart';

class HourlyWidgetModel{
  final List<double> temperature;
  final List<String> time;
  final List<String> condition;

  final List<String> dayName;
  final List<double> dayMinTemp;
  final List<double> dayMaxTemp;
  final List<String> dayCondition;

  HourlyWidgetModel({
    required this.temperature,
    required this.time,
    required this.condition,

    required this.dayName,
    required this.dayMinTemp,
    required this.dayMaxTemp,
    required this.dayCondition,
  });

  factory HourlyWidgetModel.fromJson(Map<String,dynamic> json){
    List<dynamic> listData = json['hourly'];
    List<dynamic> listData2 =json['daily'];

    List<String> timeValue = <String>[];
    List<String> conditionValues= <String>[];
    List<double> tempValues= <double>[];

    List<String> dayNameValues = <String>[];
    List<String> dayConditionValues =<String>[];
    List<double> dayMinTempValues = <double>[];
    List<double> dayMaxTempValues =<double>[];


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

    for(int i=0;i<listData2.length;i++){

      int timestamp = listData2[i]['dt'];
      DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
      String dayName = DateFormat.E().format(dateTime2);
      double minTemp = (listData2[i]['temp']['min'].toDouble())-273.15;
      double maxTemp = (listData2[i]['temp']['max'].toDouble())-273.15;
      String dayCon = listData2[i]['weather'][0]['main'];

      dayNameValues.add(dayName);
      dayConditionValues.add(dayCon);
      dayMinTempValues.add(minTemp);
      dayMaxTempValues.add(maxTemp);

    }

    return HourlyWidgetModel(
      temperature: tempValues,
      time: timeValue,
      condition: conditionValues,
      dayName: dayNameValues,
      dayCondition: dayConditionValues,
      dayMaxTemp: dayMaxTempValues,
      dayMinTemp: dayMinTempValues,
    );
  }
}