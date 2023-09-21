

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/CheckCodeModel.dart';

class CheckCodeRepository{


  //check code api
  Map<String , dynamic>? checkCodeDataMap;
  Map<String , dynamic>? doneCheckCodeDataMap;
  List<dynamic>? doneListCodeDataMap;

 Future hitCheckCodeApi(String code) async {
   final Map<String , dynamic> requestBody ={
     'code' : code
   };
   http.Response response;
   response  =await http.post(Uri.parse("https://employeyarena.com/jpradda/api/code"),
     body: jsonEncode(requestBody),
     headers: {'Content-Type': 'application/json'},);


   if(response.statusCode==200){
     checkCodeDataMap = jsonDecode(response.body);

     //code related data ex invalid or not
     doneCheckCodeDataMap = checkCodeDataMap!['meta_data'];

     //all the data like prize name and img
     doneListCodeDataMap = checkCodeDataMap!['data'];

     print(doneCheckCodeDataMap);
     print(doneListCodeDataMap);




   }

 }
}

//new request api
