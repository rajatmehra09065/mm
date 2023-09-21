

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mm/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'package:mm/views/open_card_screen/open_card_screen.dart';


import '../../consts/images.dart';
import '../../consts/strings.dart';
import '../../repository/check_code_repository.dart';


class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {

  TextEditingController enterCodeController  = TextEditingController();

  CheckCodeRepository checkCodeRepository = CheckCodeRepository();
  String errorMsg="";
  bool isLoading = false;



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
          child: Expanded(
            child: Column(
              children: [
                SizedBox(height: height * 0.15,),
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
                    onPressed:isLoading ? null : () async{
                      setState(() {
                        isLoading = true;
                        errorMsg="";
                      });
                      try{

                        await checkCodeRepository.hitCheckCodeApi(enterCodeController.text.toString());


                        if(checkCodeRepository.doneCheckCodeDataMap!['code'] ==402){

                          setState(() {
                            errorMsg="Invalid Code";
                          });
                        }
                        else if(checkCodeRepository.doneCheckCodeDataMap!['code'] ==400){
                          setState(() {
                            errorMsg="Please Enter The Code";
                          });
                        }

                        else if(checkCodeRepository.doneCheckCodeDataMap!['code'] ==500){
                          setState(() {
                            errorMsg="Code Is Already Opened";
                          });
                        }


                        else if(checkCodeRepository.doneCheckCodeDataMap!['code'] ==200){

                          //moved to next screen
                          Get.to(
                              OpenCardScreen(
                                doneCheckCodeDataMap: checkCodeRepository.doneCheckCodeDataMap,
                                doneListCodeDataMap: checkCodeRepository.doneListCodeDataMap,
                              ), //next page class
                              duration: Duration(milliseconds: 1100 ), //duration of transitions, default 1 sec
                              transition: Transition.fadeIn,
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
    );
  }
}
