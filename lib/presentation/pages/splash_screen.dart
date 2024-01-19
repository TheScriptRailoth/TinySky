import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../data/datasources/remote/hourly_widget_data.dart';
import '../../data/datasources/remote/weather_data.dart';
import '../../data/models/hourly_widget_model.dart';
import '../../data/models/weather_model.dart';
import 'home_scree.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasInternet = true;
  Color dayColor1 = const Color(0xff91DEFF);
  Color dayColor2 = const Color(0xff47BBE1);
  Color nightColor1 = const Color(0xff08244F);
  Color nightColor2 = const Color(0xff134CB5);

  final _weatherData = WeatherData('672dd5784d1ee2fff09d6767c38498c7');
  final _hourlyWidgetData = HourlyWidgetData();
  HourlyWidgetModel? _hourlyWidgetModel;
  WeatherModel? _weatherModel;
  bool showAnimtion=false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300),(){
      showAnimtion=true;
    });
    _fetchDataAndNavigate();
  }



  Future<void> _fetchDataAndNavigate() async {
    try {
      String cityName = await _weatherData.currentCity();
      final weather = await _weatherData.getWeatherData(cityName);
      final hourlyWeather = await _hourlyWidgetData.getHourlyData();

      setState(() {
        _weatherModel = weather;
        _hourlyWidgetModel = hourlyWeather;
      });

      await Future.delayed(Duration(seconds: 2));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return HomeScreen(
            weatherModel: _weatherModel,
            hourlyWeatherModel: _hourlyWidgetModel,
          );
        }),
      );
    } catch (e) {
      print(e);
      setState(() {
        hasInternet=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Brightness systemBrightness= MediaQuery.of(context).platformBrightness;
    bool isNightTime=  systemBrightness == Brightness.dark?true:false;

    List<Color> colors = isNightTime ? [nightColor1, nightColor2] : [dayColor1, dayColor2];

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150.h,
                    width: 170.w,
                    child: hasInternet?Image.asset('assets/TinySky_logo.png', fit: BoxFit.cover):Lottie.asset('assets/animations/no_internet.json', fit: BoxFit.contain),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    hasInternet?"TinySky":"No Internet!",style: GoogleFonts.adventPro(
                      color: Colors.white,
                      fontSize: 30.sp,
                    ),
                  ),
                ],
              ),
            ),
            showAnimtion?Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: hasInternet?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Featching Data", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 35.h,
                    width: 35.w,
                    child: Lottie.asset('assets/animations/loading_animation.json', fit: BoxFit.contain),
                  )
                ],
              ):Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 35.h,
                    width: 35.w,
                  )
                ],
              ),
            ):Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Container(
                height: 35.h,
                width: 35.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
