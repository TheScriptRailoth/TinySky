// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tiny_sky/presentation/pages/home_scree.dart';
//
// import '../../data/datasources/remote/weather_data.dart';
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   bool isNightTime=DateTime.now().hour<6 || DateTime.now().hour>18;
//   Color dayColor1 = Color(0xff91DEFF);
//   Color dayColor2 = Color(0xff47BBE1);
//   Color nightColor1 = Colors.blueGrey.shade800;
//   Color nightColor2 = Colors.black87;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration(seconds: 3),(){
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
//         return HomeScreen();
//       }));
//     });
//   }
//
//   }
// final _weatherData = WeatherData('672dd5784d1ee2fff09d6767c38498c7');
//
// @override
//   Widget build(BuildContext context) {
//     List<Color> colors = isNightTime ? [nightColor1, nightColor2] : [dayColor1, dayColor2];
//
//     return FutureBuilder(
//         future: _fetchWeather(),
//         builder: (context,snapshot){
//           if(snapshot.connectionState==ConnectionState.done){
//             return HomeScreen();
//           }else{
//             return Scaffold(
//               body: Container(
//                   height: MediaQuery.sizeOf(context).height,
//                   width: MediaQuery.sizeOf(context).width,
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: colors,
//                         // colors: [
//                         //   // Color(0xff254659),
//                         //   // Colors.white,
//                         //   Color(0xff91DEFF),
//                         //   Color(0xff47BBE1),
//                         //   // Colors.white
//                         // ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       )
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                               height: 150.h,
//                               width: 170.w,
//                               child: Image.asset('assets/TinySky_logo.png', fit: BoxFit.cover,)
//                           ),
//                           SizedBox(height: 5.h,),
//                           Text("TinySky", style: GoogleFonts.adventPro(
//                               color: Colors.white,
//                               fontSize: 30.sp
//                           ),),
//                         ],
//                       )
//                     ],
//                   )
//               ),
//             );
//           }
//         }
//     );
//
//   }
// Future<void> _fetchWeather() async {
//   try {
//     String cityName = await _weatherData.currentCity();
//     final weather = await _weatherData.getWeatherData(cityName);
//     await Future.delayed(Duration(seconds: 2));
//   } catch (e) {
//     print(e);
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiny_sky/data/models/weather_model.dart';
import '../../data/datasources/remote/weather_data.dart';
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
  WeatherModel? _weatherModel;
  @override
  void initState() {
    super.initState();
    _fetchWeather().then((weather){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return HomeScreen(weatherModel: weather,);
        }),
      );
    });
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
  Future<WeatherModel?> _fetchWeather() async {
    try {
      String cityName = await _weatherData.currentCity();
      final weather = await _weatherData.getWeatherData(cityName);
      await Future.delayed(Duration(seconds: 2));
      return weather; // Return the fetched weather data
    } catch (e) {
      print(e);
      return null;
    }
  }
}
