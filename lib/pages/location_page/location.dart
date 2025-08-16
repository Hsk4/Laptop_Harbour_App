import 'package:eproject_sem4/components/G_Navigation.dart';
import 'package:eproject_sem4/components/buttons_component.dart';
import 'package:eproject_sem4/pages/Dashboard_pages/main_page.dart';
import 'package:eproject_sem4/pages/location_page/permissions.dart';
import 'package:eproject_sem4/pages/splash_screen_pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class location extends StatefulWidget {
  const location({super.key});

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What is your location?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'we need to know your location to provide better services',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
             SizedBox(height: 30),
            MyButton(text: 'Allow Location Access '),
            SizedBox(height: 15),

            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Permissions()),
                );
              },
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 16, color: Color(0xFFFF4548),),
                  SizedBox(width:5 ,),

                  Text('Enter Your Location' ,style: TextStyle(
                    fontSize: 12.sp,
                    color:  Color(0xFFFF4548),
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
            
                
              
            )


          ],
        ),
      ),
    );
  }
}
