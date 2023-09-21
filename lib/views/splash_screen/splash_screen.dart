import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../consts/consts.dart';
import '../enter_code_screen/enter_code_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //change screen method
  changeScreen(){
    Future.delayed(Duration(seconds: 2), (){

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>const EnterCodeScreen()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(appLogo , width:100),
            30.heightBox,
            appName.text.fontFamily(bold).size(25).make()
          ],
        ),

      ),
    );
  }
}