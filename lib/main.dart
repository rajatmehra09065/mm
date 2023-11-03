import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mm/views/open_card_screen/open_card_screen.dart';
import 'package:mm/views/splash_screen/splash_screen.dart';
import 'package:mm/views/user_details/user_details.dart';
import 'package:mm/widget_common/internet_connecton_snakeBar.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final ConnectivityController connectivityController = Get.put(ConnectivityController());
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:const SplashScreen(),


      
    );
  }
}


