import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny_sky/data/datasources/remote/location_data.dart';
import 'package:tiny_sky/presentation/pages/search_result_screen.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  Color dayColor1 = Color(0xff91DEFF);
  Color dayColor2 = Color(0xff47BBE1);
  Color nightColor1 = Color(0xff08244F);
  Color nightColor2 = Color(0xff134CB5);


  @override
  Widget build(BuildContext context) {

    TextEditingController _cityName= TextEditingController();

    void initState(){
      super.initState();
      _cityName=TextEditingController();
    }

    void dispose(){
      _cityName.dispose();
      super.dispose();
    }


    Brightness systemBrightness = MediaQuery.of(context).platformBrightness;
    bool isNightTime= systemBrightness==Brightness.dark?true:false;
    List<Color> colors = isNightTime ? [nightColor1, nightColor2] : [dayColor1, dayColor2];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
             children: [
               Container(
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.white, width: 0.7),
                   borderRadius: BorderRadius.circular(10.r),
                 ),
                 width: double.infinity,
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                   child: Row(
                     children: [
                       Expanded(
                         child: TextFormField(
                           controller: _cityName,
                           decoration: const InputDecoration(
                             border: InputBorder.none,
                             hintText: 'Search',
                             hintStyle: TextStyle(color: Colors.white),
                           ),
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 18.sp,
                           ),
                         ),
                       ),
                       Container(
                         height: 50.h,
                         width: 40.w,
                         alignment: Alignment.center,
                         child: Center(
                           child: IconButton(
                             onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context){
                                 return SearchResultScreen(cityName: _cityName.text);
                               }));
                             },
                             icon: Icon(CupertinoIcons.search, color: Colors.white,)),
                         )
                       ),
                     ],
                   ),
                 ),
               ),
               SizedBox(height: 10.h,),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 20),
                 child: Container(
                   height: 40.h,
                   width: double.infinity,
                   decoration: BoxDecoration(
                     color: Color(0xff104084).withOpacity(0.8),
                     borderRadius: BorderRadius.circular(10.r)
                   ),
                   child: TextButton(
                     onPressed: (){
                     },
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(CupertinoIcons.location_circle, color: Colors.white,),
                         SizedBox(width: 10,),
                         Text("Use current location", style: TextStyle(
                           color: Colors.white,
                         ),),
                       ],
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 10.h,),
               LocationListTile('Jhansi'),
               LocationListTile('Jhansi'),
             ],
          ),
        ),
      ),
    );
  }

  Widget LocationListTile(String location){
    return Container(
      height: 40.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5,) ,width: 0.5))
      ),
      child: TextButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return SearchResultScreen(cityName: location);
            }));
          },
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 30.h,
                child: Icon(CupertinoIcons.location_circle, color: Colors.grey,),
              ),
              Expanded(
                  child: Text(location, style: TextStyle(color: Colors.grey, fontSize: 16.sp), overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: 40.w,
                height: 30.h,
                child: Icon(CupertinoIcons.arrow_up_left, color: Colors.grey,),
              ),
            ],
          )
      ),
    );
  }
}
