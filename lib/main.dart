import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiny_sky/presentation/pages/splash_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final ConnectivityProvider _connectivityProvider = ConnectivityProvider();
  MyApp({Key? key}):super(key: key){
    _connectivityProvider.checkConnectivity();
  }

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
            home: _connectivityProvider.isConnected?SplashScreen():NoInternetScreen(),
        );
      },
    );
  }
}

class ConnectivityProvider extends ChangeNotifier {
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _isConnected = false;
    } else {
      _isConnected = true;
    }
    notifyListeners();
  }
}

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No Internet Connection!'),
      ),
    );
  }
}
