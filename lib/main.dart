import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiny_sky/presentation/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: GoogleFonts.roboto().fontFamily,
              colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff254659)),
              useMaterial3: true,
            ),
            home: SplashScreen()
        );
      },
    );
  }
}