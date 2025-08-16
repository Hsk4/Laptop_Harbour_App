import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Permissions extends StatefulWidget {
  const Permissions({super.key});

  @override
  State<Permissions> createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Enter Your location '),
        leading: Padding(
          padding: EdgeInsets.all(3.w),
          child: CircleAvatar(
            backgroundColor: Color(0xFFF2F2F2),
            radius: 18.r,
              child:IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon:  Icon(
                Icons.arrow_back,
                color:  Colors.black87,
                size: 22.sp,
              ),)
            ),
          ),
        ),
        
      body: Center(
    child: Column(
      children: [
        SizedBox(height: 20,),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black87,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
        GestureDetector(
          onTap: (){},
          child: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.navigation_rounded,
                  size: 18.sp,
                  color: Color(0xFFFF4548),
                ),
                SizedBox(width: 6.w),
                Text(
                  'Use my current location',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
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
