import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tiny_sky/data/datasources/remote/weather_data.dart';
import 'package:tiny_sky/data/models/weather_model.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  final _weatherData = WeatherData('672dd5784d1ee2fff09d6767c38498c7');
  WeatherModel? _weatherModel;

  _fetchWeather() async{
    String cityName = await _weatherData.currentCity();

    try{
      final weather=await _weatherData.getWeatherData(cityName);
      setState(() {
          _weatherModel=weather;
      });
    }
    catch (e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    List<Color> colors = isNightTime ? [nightColor1, nightColor2] : [dayColor1, dayColor2];

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
                      Text(_weatherModel?.city??"Loading City...", style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ), ),
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
                      child: Lottie.asset('assets/animations/clouds.json')
                  ),
                  Text("${_weatherModel?.temperature.round()}\u00B0C", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 64.sp
                  ),),
                  Text("Precipitation", style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                  Text("Max: 34 Min: 28", style: TextStyle(color: Colors.white, fontSize: 14.sp),),
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
                            Icon(CupertinoIcons.drop_fill, color: Colors.white, size: 18,),
                            Text("18%", style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),)
                          ],
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.thermometer, color: Colors.white, size: 18,),
                            Text("67%", style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),)
                          ],
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.wind, color: Colors.white, size: 18,),
                            Text("20 km/h", style: TextStyle(
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
                          SizedBox(height: 10.h,),
                          SingleChildScrollView(
                            scrollDirection:Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(width: 5.w,),
                                Container(
                                  height: 140.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(color: Colors.lightBlueAccent)
                                  ),
                                  child: TextButton(
                                      onPressed: (){},
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("30\u00B0C", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp
                                          ),),
                                          Container(
                                              height: 43.h,
                                              width: 43.w,
                                              child: Lottie.asset('assets/animations/light_rain.json'),
                                          ),
                                          Text("17:00", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp
                                          ),),
                                        ],
                                      )
                                  ),
                                ),
                                SizedBox(width: 5.w,),
                                Container(
                                  height: 140.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(color: Colors.lightBlueAccent)
                                  ),
                                  child: TextButton(
                                      onPressed: (){},
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("30\u00B0C", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp
                                          ),),
                                          Container(
                                            height: 43.h,
                                            width: 43.w,
                                            child: Lottie.asset('assets/animations/light_rain.json'),
                                          ),
                                          Text("17:00", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp
                                          ),),
                                        ],
                                      )
                                  ),
                                ),
                                SizedBox(width: 5.w,),
                              ],
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