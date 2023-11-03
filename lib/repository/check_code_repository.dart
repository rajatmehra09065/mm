

import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/CheckCodeModel.dart';
import 'package:image_picker/image_picker.dart';

import '../views/user_details/user_details.dart';

class CheckCodeRepository{


  //check code api
  Map<String , dynamic>? checkCodeDataMap;
  Map<String , dynamic>? doneCheckCodeDataMap;
  List<dynamic>? doneListCodeDataMap;
  List<dynamic>? doneListCodeIdDataMap;

 Future hitCheckCodeApi(String code) async {
   final Map<String , dynamic> requestBody ={
     'code' : code
   };
   http.Response response;
   response  =await http.post(Uri.parse("https://employeyarena.com/makhoyamoolah/api/code"),
     body: jsonEncode(requestBody),
     headers: {'Content-Type': 'application/json'},);


   if(response.statusCode==200){
     checkCodeDataMap = jsonDecode(response.body);

     //code related data ex invalid or not
     doneCheckCodeDataMap = checkCodeDataMap!['meta_data'];

     //all the data like prize name and img
     doneListCodeDataMap = checkCodeDataMap!['data'];

     doneListCodeIdDataMap = checkCodeDataMap!['code'];


   }

 }
}

class PriceOpen{

  Map<String , dynamic>? priceOpenCodeDataMap;
  Map<String , dynamic>? donePriceOpenCodeDataMap;
  List<dynamic>? doneListPriceOpenDataMap;

  Future hitPriceOpenApi({required int  priceID , required String codeId}) async {
    final Map<String , dynamic> requestBody ={
      'id' : priceID,
      'code_id' : codeId,
    };
    http.Response response;
    response  =await http.post(Uri.parse("https://employeyarena.com/makhoyamoolah/api/price-open"),
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},);


    if(response.statusCode==200){
      priceOpenCodeDataMap = jsonDecode(response.body);


      donePriceOpenCodeDataMap = priceOpenCodeDataMap!['meta_data'];

      //all the data like prize name and img
      doneListPriceOpenDataMap = priceOpenCodeDataMap!['data'];


    }

  }

}

//new request api
class UserDetailsRepository{


  Map<String , dynamic>? userDetailsDataMap;
  Map<String , dynamic>? doneUserDetailsDataMap;
  List<dynamic>? doneListUserDetailsDataMap;

  Future hitUserDetailsApi({required String fullName , required String mobileNumber , required String address , required String pinCode ,required String priceName ,required String priceDescription , required String priceCode} ) async{



    final Map<String , dynamic> requestBody ={
      'user_name' : fullName,
      'user_mobile' : mobileNumber,
      'user_address' : address ,
      'user_pin_code' : pinCode,
      'price_name' : priceName,
      'price_description' :priceDescription,
      'price_code' : priceCode,

    };

    http.Response response;
    response =await http.post(Uri.parse("https://employeyarena.com/makhoyamoolah/api/user-data"),
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode==200){
      userDetailsDataMap = jsonDecode(response.body);


      doneUserDetailsDataMap = userDetailsDataMap!['meta_data'];

      //all the data like prize name and img
      doneListUserDetailsDataMap = doneUserDetailsDataMap!['data'];


    }

  }
}