

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getX;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:mm/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'package:mm/views/open_card_screen/open_card_screen.dart';


import '../../consts/images.dart';
import '../../consts/strings.dart';
import '../../repository/check_code_repository.dart';
import '../../widget_common/internet_connecton_snakeBar.dart';
import '../user_details/user_details_screen2.dart';


class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {

  //snakeBar internetConnection
  final SnackbarController snackbarController = Get.put(SnackbarController());
  final ConnectivityController connectivityController = Get.find();

  TextEditingController enterCodeController  = TextEditingController();

  CheckCodeRepository checkCodeRepository = CheckCodeRepository();
  String errorMsg="";
  bool isLoading = false;


  //internet connection error sankebar
  @override
  void initState() {
    super.initState();

    connectivityController.isConnected.listen((isConnected) {
      if (!isConnected) {
        snackbarController.showSnackbar('No Internet Connection');
      } else {
        snackbarController.hideSnackbar();
      }
    });
  }



  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.sizeOf(context).width *1;
    final height = MediaQuery.sizeOf(context).height *1;

    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                //app logo
                Image.asset(appLogo, width: 100,),

                SizedBox(height: height * 0.04,),
                //app name
                appName.text.fontFamily(bold).size(25).make(),

                SizedBox(height: height * 0.10,),
                //textfield
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: enterCodeController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      hintText: enterCodeHint,
                      hintStyle: TextStyle(
                        color: fontGrey,
                        fontSize: 18,
                      ),
                      isDense: true,
                      fillColor: CupertinoColors.systemGrey6,
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.05,),
                //Redeem button
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        backgroundColor: pinkishOrange,
                        padding: EdgeInsets.all(12)
                    ),
                    onPressed:isLoading || !connectivityController.isConnected.value ? null : () async{
                      setState(() {
                        isLoading = true;
                        errorMsg="";
                      });
                      try{

                        await checkCodeRepository.hitCheckCodeApi(enterCodeController.text.toString());


                        if(checkCodeRepository.doneCheckCodeDataMap!['code'] ==404){

                          setState(() {
                            errorMsg="Invalid Code";
                          });
                        }
                        else if(checkCodeRepository.doneCheckCodeDataMap!['code'] ==400){
                          setState(() {
                            errorMsg="Please Enter The Code";
                          });
                        }

                        else if(checkCodeRepository.doneCheckCodeDataMap!['code'] ==405){
                          setState(() {
                            errorMsg="Code Already Redeemed";
                          });
                        }

                        else if(checkCodeRepository.doneCheckCodeDataMap!['code'] ==403){

                          Get.to(
                            UserDetailScreen2(

                                doneListCodeDataMap: checkCodeRepository.doneListCodeDataMap,
                                doneListCodeIdDataMap : checkCodeRepository.doneListCodeIdDataMap
                            ), //next page class
                            duration: Duration(milliseconds: 1100 ), //duration of transitions, default 1 sec
                            transition: Transition.rightToLeft,
                          );


                        }

                        else if(checkCodeRepository.doneCheckCodeDataMap!['code'] ==200){

                          //moved to next screen
                          Get.to(
                              OpenCardScreen(
                                doneCheckCodeDataMap: checkCodeRepository.doneCheckCodeDataMap,
                                doneListCodeDataMap: checkCodeRepository.doneListCodeDataMap,
                                  doneListCodeIdDataMap : checkCodeRepository.doneListCodeIdDataMap
                              ), //next page class
                              duration: Duration(milliseconds: 1100 ), //duration of transitions, default 1 sec
                              transition: Transition.rightToLeft,
                          );
                        }


                      }
                      catch (e){
                        print("$e");

                      }
                      finally{
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }, child: Text(redeem,style: TextStyle( fontSize: 16),)).box.width(context.screenWidth).height(height * 0.07).make(),

                SizedBox(height: height * 0.05),
                if(isLoading)
                  CircularProgressIndicator(color: pinkishOrange,),
                if(errorMsg.isNotEmpty)
                  Text(
                    errorMsg,
                    style: TextStyle(color: pinkishOrange , fontFamily: semibold  , fontSize: 16 ),
                  ),
              ],

            ),
          ),
        ),
      ),

      bottomNavigationBar: Obx(() {
        final snackbar = snackbarController.snackbar.value;
        return snackbar != null ? snackbar : SizedBox.shrink();
      }),
    );
  }
}
