import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm/consts/consts.dart';
import 'package:mm/widget_common/custom_text_field.dart';

import '../../consts/strings.dart';

class UserDetails extends StatefulWidget {


  final List<dynamic>? doneListCodeDataMap;
  final int selectedIndex;

  const UserDetails({

    required this.doneListCodeDataMap,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  //Controllers
  TextEditingController fullNameController  = TextEditingController();
  TextEditingController mobileNumberController  = TextEditingController();
  TextEditingController addressController  = TextEditingController();
  TextEditingController pinCodeController  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.sizeOf(context).width *1;
    final height = MediaQuery.sizeOf(context).height *1;

    return  Expanded(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,

        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.010,),

                    //Redeemed text
                    Align(
                        alignment: Alignment.center,
                        child: redeemed.text.fontFamily(bold).black.size(20).make()),

                    SizedBox(height: height * 0.050,),
                    //Price img
                    Image.network(widget.doneListCodeDataMap![widget.selectedIndex]['picture'], width: 180, height: 180 , ),

                    SizedBox(height: height * 0.010,),
                    //Price name
                    Text(widget.doneListCodeDataMap![widget.selectedIndex]['name']).text.fontFamily(bold).size(20).make(),

                    SizedBox(height: height * 0.050,),
                    customTextField(hint: fullName, controller: fullNameController),

                    SizedBox(height: height * 0.020,),
                    customTextField(hint: mobileNumber , controller: mobileNumberController),

                    SizedBox(height: height * 0.020,),
                    customTextField(hint: address , controller: addressController),

                    SizedBox(height: height * 0.020,),
                    customTextField(hint: pinCode , controller: pinCodeController),


                    SizedBox(height: height * 0.020,),
                //Submit button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: pinkishOrange,
                      padding: EdgeInsets.all(12)
                  ),
                  onPressed: () async{},
                  child:submit.text.white.fontFamily(bold).size(16).make()


                ).box.width(context.screenWidth).height(55).make()],
                ),
              ),
            )
        ),
      ),
    );
  }
}
