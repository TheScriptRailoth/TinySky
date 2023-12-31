import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tiny_sky/presentation/pages/search_screen.dart';

import '../../data/datasources/remote/hourly_widget_data.dart';
import '../../data/datasources/remote/weather_data.dart';
import '../../data/models/hourly_widget_model.dart';
import '../../data/models/weather_model.dart';
class SearchResultScreen extends StatefulWidget {
  final String cityName;

  const SearchResultScreen({Key?key, required this.cityName }):super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();


}

class _SearchResultScreenState extends State<SearchResultScreen> {

  final _weatherData = WeatherData('672dd5784d1ee2fff09d6767c38498c7');
  final _hourlyWidgetData = HourlyWidgetData();
  HourlyWidgetModel? _hourlyWidgetModel;
  WeatherModel? _weatherModel;

  Color dayColor1 = const Color(0xff91DEFF);
  Color dayColor2 = const Color(0xff47BBE1);
  Color nightColor1 = const Color(0xff08244F);
  Color nightColor2 = const Color(0xff134CB5);

  String monthName(int num){
    List<String> abbreviatedMonths = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return abbreviatedMonths[num-1];
  }

  String convertToFullDayName(String abbreviatedDay) {
    switch (abbreviatedDay.toLowerCase()) {
      case 'mon':
        return 'Monday';
      case 'tue':
        return 'Tuesday';
      case 'wed':
        return 'Wednesday';
      case 'thu':
        return 'Thursday';
      case 'fri':
        return 'Friday';
      case 'sat':
        return 'Saturday';
      case 'sun':
        return 'Sunday';
      default:
        return 'Invalid Day';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDataAndNavigate();
  }
  Future<void> _fetchDataAndNavigate() async {
    try {
      final weather = await _weatherData.getWeatherData(widget.cityName);
      final hourlyWeather = await _hourlyWidgetData.getHourlyData();

      setState(() {
        _weatherModel = weather;
        _hourlyWidgetModel = hourlyWeather;
      });
    } catch (e) {
      print('Error fetching weather data for ${widget.cityName} $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    Brightness systemBrightness= MediaQuery.of(context).platformBrightness;
    bool isNightTime=  systemBrightness == Brightness.dark?true:false;
    List<Color> colors = isNightTime ? [nightColor1, nightColor2] : [dayColor1, dayColor2];

    if (_weatherModel == null) {
      return Scaffold(
        backgroundColor: Color(0xff91DEFF),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Featching Data", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                Container(
                  height: 35.h,
                  width: 35.w,
                  child: Lottie.asset('assets/animations/loading_animation.json', fit: BoxFit.contain),
                )
              ],
            ),
          ),
        ),
      );
    }

    String ClimateAnimation(String currentCondtion) {
      String? currentCondition = currentCondtion.toLowerCase();

      final Map<String, String> animations = {
        'clouds': 'clouds',
        'mist': 'clouds',
        'smoke': 'clouds',
        'haze': 'clouds',
        'dust': 'clouds',
        'fog': 'clouds',
        'cloud': 'night_cloud',
      };

      String defaultAnimation = 'sunny';
      String nightDefaultAnimation = 'night_clear';

      if (currentCondition != null) {
        String animationKey = animations[currentCondition] ?? defaultAnimation;

        if (isNightTime && !animationKey.contains('night')) {
          return 'assets/animations/$nightDefaultAnimation.json';
        }

        if (isNightTime) {
          animationKey = 'night_$animationKey';
        }

        return 'assets/animations/$animationKey.json';
      }

      if (isNightTime) {
        return 'assets/animations/$nightDefaultAnimation.json';
      }

      return 'assets/animations/$defaultAnimation.json';
    }

    return Scaffold(
      backgroundColor: Color(0xff91DEFF),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 27, color: Colors.white,),
                      SizedBox(width: 5.w,),
                      Row(
                        children: [
                          Text(_weatherModel?.city??"Loading City...", style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ), ),
                          SizedBox(width: 5.w,),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: (){},
                      icon: Icon(CupertinoIcons.xmark_circle_fill, size: 32, color: Colors.white,)
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 187.h,
                      width: 284.w,
                      child: Lottie.asset(ClimateAnimation(_weatherModel!.condition), fit: BoxFit.contain)
                  ),
                  Text("${_weatherModel?.temperature.round()}\u00B0C", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 64.sp
                  ),),
                  Text("Feels Like ${_weatherModel?.feelsLike.toString()??"__"}\u00B0C", style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                  Text("Max: ${_weatherModel?.maxTemp.toString()??"__"}"+"  Min: ${_weatherModel?.minTemp.toString()??"__"}", style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                  SizedBox(height: 20.h,),
                  Container(
                    height: 47.h,
                    width: MediaQuery.sizeOf(context).width-40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: isNightTime?const Color(0xff001026).withOpacity(0.3):const Color(0xff104084).withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.water_rounded, color: Colors.white, size: 18,),
                            SizedBox(width: 5.w,),
                            Text("${_weatherModel!.humidity.round().toString()??"__"}%", style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),)
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.thermometer, color: Colors.white, size: 18,),
                            Text("${_weatherModel?.feelsLike.round().toString()??"__"}\u00B0C", style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),)
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.wind, color: Colors.white, size: 18,),
                            SizedBox(width: 5.w),
                            Text("${_weatherModel?.windSpeed.round().toString()??"__"}km/h", style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    height: 217.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: isNightTime?const Color(0xff001026).withOpacity(0.3):const Color(0xff104084).withOpacity(0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(height: 5.h,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Today", style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w500,),),
                                Text('${monthName(DateTime.now().month)}, ${DateTime.now().day}', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp
                                ),)
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h,),
                          Container(
                            height: 140.h,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(20, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Container(
                                      height: 140.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.r),
                                        border: Border.all(color: Colors.lightBlueAccent),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${_hourlyWidgetModel!.temperature[index].round().toString()}\u00B0C' ?? "__",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          SizedBox(
                                              height: 43.h,
                                              width: 43.w,
                                              child: Lottie.asset(ClimateAnimation(_hourlyWidgetModel!.condition[index]))
                                          ),
                                          Text(
                                            _hourlyWidgetModel!.time[index].substring(11,16),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    height: 400.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: isNightTime?Color(0xff001026).withOpacity(0.3):Color(0xff104084).withOpacity(0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(height: 5.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Next Forcast", style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w500,),),
                                Icon(CupertinoIcons.calendar, color: Colors.white, size: 20.sp,)
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h,),
                          Container(
                            child: Column(
                              children: List.generate(8, (index) {
                                return Container(
                                  height: 40.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              convertToFullDayName(_hourlyWidgetModel?.dayName[index]?? ""),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 35.h,
                                          width: 35.w,
                                          child: Lottie.asset(ClimateAnimation(_hourlyWidgetModel!.dayCondition[index].toString())),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              '${_hourlyWidgetModel?.dayMaxTemp[index].round().toString() ?? ""}\u00B0C',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Text(
                                              '${_hourlyWidgetModel?.dayMinTemp[index]?.round().toString() ?? ""}\u00B0C',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
