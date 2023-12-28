import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tiny_sky/data/datasources/remote/hourly_widget_data.dart';
import 'package:tiny_sky/data/models/hourly_widget_model.dart';
import 'package:tiny_sky/data/models/weather_model.dart';
import 'package:tiny_sky/presentation/pages/search_screen.dart';
class HomeScreen extends StatefulWidget {
  final WeatherModel? weatherModel;
  final HourlyWidgetModel? hourlyWeatherModel;
  const HomeScreen({Key? key, this.weatherModel, this.hourlyWeatherModel}):super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isNightTime=DateTime.now().hour<6 || DateTime.now().hour>18;
  Color dayColor1 = Color(0xff91DEFF);
  Color dayColor2 = Color(0xff47BBE1);
  Color nightColor1 = Colors.blueGrey.shade800;
  Color nightColor2 = Colors.black87;

  String monthName(int num){
    List<String> abbreviatedMonths = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return abbreviatedMonths[num-1];
  }

  WeatherModel? _weatherModel;
  HourlyWidgetModel? _hourlyWidgetModel;

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherModel=widget.weatherModel;
    _hourlyWidgetModel=widget.hourlyWeatherModel;
  }
  @override
  Widget build(BuildContext context) {
    List<Color> colors = isNightTime ? [nightColor1, nightColor2] : [dayColor1, dayColor2];

    if (_weatherModel == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Color(0xff91DEFF),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
              // colors: [
              //   // Color(0xff254659),
              //   // Colors.white,
              //   Color(0xff91DEFF),
              //   Color(0xff47BBE1),
              //   // Colors.white
              // ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 27, color: Colors.white,),
                      SizedBox(width: 5.w,),
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SearchScreen();
                          }));
                        },
                        child: Text(_weatherModel?.city??"Loading City...", style: GoogleFonts.roboto(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ), ),
                      ),
                      SizedBox(width: 5.w,),
                      Icon(Icons.arrow_drop_down_rounded, color: Colors.white,size: 24.h,)
                    ],
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
                      color: Color(0xff104084).withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.water_rounded, color: Colors.white, size: 18,),
                            SizedBox(width: 5.w,),
                            Text((_weatherModel!.humidity.round().toString()??"__")+"%", style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),)
                          ],
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.thermometer, color: Colors.white, size: 18,),
                            Text("${_weatherModel?.feelsLike.round().toString()??"__"}\u00B0C", style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),)
                          ],
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.wind, color: Colors.white, size: 18,),
                            SizedBox(width: 5.w),
                            Text("${_weatherModel?.windSpeed.round().toString()??"__"}km/h", style: TextStyle(
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
                      color: Color(0xff104084).withOpacity(0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Today", style: GoogleFonts.taprom(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w200,),),
                              Text(monthName(DateTime.now().month)+', '+ DateTime.now().day.toString(), style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp
                              ),)
                            ],
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
                                          Container(
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Text(_weatherModel?.city??"Loading City..."),
// Text("${_weatherModel?.temperature.round()}\u00B0C"),
// Text(_weatherModel!.condition??"Loading Condition...")