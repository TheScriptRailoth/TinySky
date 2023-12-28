import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
             )
           ],
        ),
      ),
    );
  }
}
