// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tiny_sky/data/datasources/remote/hourly_widget_data.dart';
// import 'package:tiny_sky/data/models/hourly_widget_model.dart';
// import 'package:tiny_sky/data/models/weather_model.dart';
// import '../../data/datasources/remote/weather_data.dart';
// import 'home_scree.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   bool isNightTime = DateTime.now().hour < 6 || DateTime.now().hour > 18;
//   Color dayColor1 = Color(0xff91DEFF);
//   Color dayColor2 = Color(0xff47BBE1);
//   Color nightColor1 = Colors.blueGrey.shade800;
//   Color nightColor2 = Colors.black87;
//
//   final _weatherData = WeatherData('672dd5784d1ee2fff09d6767c38498c7');
//   final _hourlyWidgetData = HourlyWidgetData('672dd5784d1ee2fff09d6767c38498c7');
//   HourlyWidgetModel? _hourlyWidgetModel;
//   WeatherModel? _weatherModel;
//   @override
//   void initState() {
//     super.initState();
//     _fetchWeather().then((weather){
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) {
//           return HomeScreen(weatherModel: weather, hourlyWeatherModel: _,);
//         }),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Color> colors = isNightTime ? [nightColor1, nightColor2] : [dayColor1, dayColor2];
//
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: colors,
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   height: 150.h,
//                   width: 170.w,
//                   child: Image.asset('assets/TinySky_logo.png', fit: BoxFit.cover),
//                 ),
//                 SizedBox(height: 5.h),
//                 Text(
//                   "TinySky",
//                   style: GoogleFonts.adventPro(
//                     color: Colors.white,
//                     fontSize: 30.sp,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Future<WeatherModel?> _fetchWeather() async {
//     try {
//       String cityName = await _weatherData.currentCity();
//       final weather = await _weatherData.getWeatherData(cityName);
//       await Future.delayed(Duration(seconds: 2));
//       return weather;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
//
//   Future<HourlyWidgetModel?> _fetchHourlyWeather() async {
//     try {
//       String cityName = await _weatherData.currentCity();
//       final hourlyWeather = await _hourlyWidgetData.getHourlyData(cityName);
//       await Future.delayed(Duration(seconds: 2));
//       return hourlyWeather;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool isNightTime = DateTime.now().hour < 6 || DateTime.now().hour > 18;
  Color dayColor1 = Color(0xff91DEFF);
  Color dayColor2 = Color(0xff47BBE1);
  Color nightColor1 = Colors.blueGrey.shade800;
  Color nightColor2 = Colors.black87;

  final _weatherData = WeatherData('672dd5784d1ee2fff09d6767c38498c7');
  final _hourlyWidgetData = HourlyWidgetData('672dd5784d1ee2fff09d6767c38498c7');
  HourlyWidgetModel? _hourlyWidgetModel;
  WeatherModel? _weatherModel;

  @override
  void initState() {
    super.initState();
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
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Column(
              children: [
                Container(
                  height: 150.h,
                  width: 170.w,
                  child: Image.asset('assets/TinySky_logo.png', fit: BoxFit.cover),
                ),
                SizedBox(height: 5.h),
                Text(
                  "TinySky",
                  style: GoogleFonts.adventPro(
                    color: Colors.white,
                    fontSize: 30.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
