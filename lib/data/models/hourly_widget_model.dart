class HourlyWidgetModel{
  final List<double> temperature;

  HourlyWidgetModel({
    required this.temperature,
  });

  factory HourlyWidgetModel.fromJson(Map<String,dynamic> json){
    List<double> tempValues= <double>[];
    List<dynamic> listData = json['list'];

    for(int i=0;i<listData.length;i++){
      double temp=listData[i]['main']['temp'].toDouble();
      tempValues.add(temp);
    }
    return HourlyWidgetModel(
      temperature: tempValues
    );
  }
}