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
    return Scaffold(
      backgroundColor: Color(0xff91DEFF),
      body: Padding(
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
            Container(child: Lottie.asset('assets/animations/clouds.json')),
          ],
        ),
      ),
    );
  }
}
// Text(_weatherModel?.city??"Loading City..."),
// Text("${_weatherModel?.temperature.round()}\u00B0C"),
// Text(_weatherModel!.condition??"Loading Condition...")