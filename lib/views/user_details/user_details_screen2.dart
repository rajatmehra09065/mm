
import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm/consts/consts.dart';
import 'package:mm/widget_common/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
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
  //for img select
  io.File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),// Change the background color
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

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
    if(pickedFile != null){
      image = io.File(pickedFile.path);
      setState(() {

      });
    }
    else{
      print("no image selected");
    }
  }

  //upload img method
  Future<void> uploadImageAndSubmit() async {

    Map<String , dynamic>? userDetailsDataMap;
    Map<String , dynamic>? doneUserDetailsDataMap;
    List<dynamic>? doneListUserDetailsDataMap;

    if (image != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://employeyarena.com/makhoyamoolah/api/user-data'), // Replace with your image upload URL
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // Replace with your server's field name for the image
          image!.path,
        ),
      );

      request.fields['user_name'] = fullNameController.text;
      request.fields['user_mobile'] = mobileNumberController.text;
      request.fields['user_address'] = addressController.text;
      request.fields['user_pin_code'] = pinCodeController.text;
      request.fields['price_name'] = widget.doneListCodeDataMap![0]['name'];
      request.fields['price_description'] = widget.doneListCodeDataMap![0]['discription'];
      request.fields['price_code'] = widget.doneListCodeIdDataMap![0]['code'];

      try {
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);


        if(response.statusCode==200){
          userDetailsDataMap = jsonDecode(response.body);


          doneUserDetailsDataMap = userDetailsDataMap!['meta_data'];

          //all the data like prize name and img
          doneListUserDetailsDataMap = doneUserDetailsDataMap!['data'];


        }


        if (doneUserDetailsDataMap!['code'] == 401) {
          // Show the success dialog
          _showSuccessDialog(context);
        } else if (doneUserDetailsDataMap!['code'] == 400) {
          setState(() {
            submitMsg = "Please Enter The Details";
            isLoading = false;

          });
        }

      } catch (e) {
        // Handle network or request error
        print('Image upload error: $e');
      }
      finally {
        setState(() {
          isLoading = false;
        });
      }
    }
    else {
      // If no image is selected, show an error message and set isLoading to false
      setState(() {
        submitMsg = "Please Upload The Receipt";
        isLoading = false;
      });
    }
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                    Image.network(widget.doneListCodeDataMap![0]['picture'], width: 180, height: 180),
                        SizedBox(width: width * 0.040,),
                        // upload img conatiner
                        GestureDetector(
                          onTap: () {
                            getImage(); // Call getImage method when the container is tapped.
                          },
                          child: image == null
                              ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey6,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: height * 0.010,),
                                Image.asset(uploadImg, width: 50, height: 50),
                                SizedBox(height: height * 0.005,),
                                Text("Add Receipt",style: TextStyle(color: fontGrey), )
                              ],
                            ),
                          )
                              : Container(
                            child: Image.file(
                              io.File(image!.path).absolute,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )


                  ]),

                  SizedBox(height: height * 0.010,),
                  // Price name
                  Center(child: Text(widget.doneListCodeDataMap![0]['name']).text.fontFamily(bold).size(20).make()),

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

                      uploadImageAndSubmit();

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
