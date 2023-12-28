import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny_sky/data/datasources/remote/location_data.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  Future<void> placeAutoComplete(String query) async {
    Uri uri= Uri.https("maps.googleapis.com",
        "maps/api/place/autocomplete/json",
      {
        "input":query,
        "key" : "AIzaSyC6f-pPrWey1Z3ZbU00Q6uK8R5fZNqeVzs",
      });
    String? respose = await LocationData.fetchUrl(uri);

    if(respose!=null){
      print(respose);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
           children: [
             Container(
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.grey, width: 0.5),
                 borderRadius: BorderRadius.circular(10.r),
               ),
               width: double.infinity,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                 child: Row(
                   children: [
                     Container(
                       height: 50.h,
                       width: 40.w,
                       alignment: Alignment.center,
                       child: Center(child: Icon(CupertinoIcons.search)),
                     ),
                     Expanded(
                       child: TextFormField(
                         decoration: InputDecoration(
                           border: InputBorder.none,
                           hintText: 'Search',
                           hintStyle: TextStyle(color: Colors.grey),
                         ),
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 18.sp,
                         ),
                       ),
                     ),
                     Container(
                       height: 50.h,
                       width: 40.w,
                       alignment: Alignment.center,
                       child: Center(child: Icon(CupertinoIcons.mic_fill)),
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
                   color: Colors.grey.withOpacity(0.2),
                   borderRadius: BorderRadius.circular(10.r)
                 ),
                 child: TextButton(
                   onPressed: (){
                     placeAutoComplete("Dubai");
                   },
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(CupertinoIcons.location_circle, color: Colors.grey,),
                       SizedBox(width: 10,),
                       Text("Use current location", style: TextStyle(
                         color: Colors.grey
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
          onPressed: (){},
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
