import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm/consts/consts.dart';
import 'package:mm/widget_common/custom_text_field.dart';

import '../../consts/strings.dart';
import '../../repository/check_code_repository.dart';
import '../enter_code_screen/enter_code_screen.dart';

class UserDetailScreen2 extends StatefulWidget {
  final List<dynamic>? doneListCodeDataMap;
  final List<dynamic>? doneListCodeIdDataMap;

  const UserDetailScreen2({
    required this.doneListCodeDataMap,
    required this.doneListCodeIdDataMap,
    Key? key,
  }) : super(key: key);

  @override
  State<UserDetailScreen2> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetailScreen2> {
  bool isLoading = false;
  String submitMsg = '';

  // Instance
  UserDetailsRepository userDetailsRepository = UserDetailsRepository();

  // Controllers
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  // Function to show success dialog
  Future<void> _showSuccessDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // The user must tap a button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Change the background color
          title: Text(
            'Success',
            style: TextStyle(color: Colors.black), // Change the text color
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Details Submitted Successfully.',
                  style: TextStyle(color: pinkishOrange), // Change the text color
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black), // Change the text color
              ),
              onPressed: () {
                Get.to(
                  EnterCodeScreen(),
                  duration: Duration(milliseconds: 1100),
                  transition: Transition.rightToLeft,
                );// Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
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

                  // Redeemed text
                  Align(
                    alignment: Alignment.center,
                    child: redeemed.text.fontFamily(bold).black.size(20).make(),
                  ),

                  SizedBox(height: height * 0.040,),
                  // Price img
                  Image.network(widget.doneListCodeDataMap![0]['picture'], width: 180, height: 180),

                  SizedBox(height: height * 0.010,),
                  // Price name
                  Text(widget.doneListCodeDataMap![0]['name']).text.fontFamily(bold).size(20).make(),

                  SizedBox(height: height * 0.050,),
                  customTextField(hint: fullName, controller: fullNameController),

                  SizedBox(height: height * 0.020,),
                  customTextField(hint: mobileNumber, controller: mobileNumberController),

                  SizedBox(height: height * 0.020,),
                  customTextField(hint: address, controller: addressController),

                  SizedBox(height: height * 0.020,),
                  customTextField(hint: pinCode, controller: pinCodeController),

                  SizedBox(height: height * 0.020,),

                  // Submit button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: pinkishOrange,
                      padding: EdgeInsets.all(12),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                      setState(() {
                        isLoading = true;
                        submitMsg = '';
                      });

                      try {
                        await userDetailsRepository.hitUserDetailsApi(
                          fullName: fullNameController.text.toString(),
                          mobileNumber: mobileNumberController.text.toString(),
                          address: addressController.text.toString(),
                          pinCode: pinCodeController.text.toString(),
                          priceName: widget.doneListCodeDataMap![0]['name'],
                          priceDescription: widget.doneListCodeDataMap![0]['discription'],
                          priceCode: widget.doneListCodeIdDataMap![0]['code'],
                        );
                        if (userDetailsRepository.doneUserDetailsDataMap!['code'] == 401) {
                          setState(() {
                            submitMsg = "";
                          });


                          // Show the success dialog
                          _showSuccessDialog(context);


                        }

                        // Blank details
                        else if(userDetailsRepository.doneUserDetailsDataMap!['code'] == 400){
                          setState(() {
                            submitMsg = "Please Enter The Details";
                            isLoading = false;
                          });
                        }

                      } catch (e) {
                        print("error=$e");
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: submit.text.white.fontFamily(bold).size(16).make(),
                  ).box.width(context.screenWidth).height(55).make(),

                  SizedBox(height: height * 0.02),
                  if (isLoading)
                    Center(child: CircularProgressIndicator(color: pinkishOrange,)),
                  if (submitMsg.isNotEmpty)
                    Center(
                      child: Text(
                        submitMsg,
                        style: TextStyle(color: pinkishOrange, fontFamily: semibold, fontSize: 16),
                      ),
                    ),
                  SizedBox(height: height * 0.010),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
