import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';

Widget customTextField({hint,controller}){
  return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: TextFormField(
      controller: controller,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),

        hintText: hint,
        hintStyle: TextStyle(
            color: fontGrey,
            fontSize: 18),
        isDense: true,
        fillColor: CupertinoColors.systemGrey6,
        filled: true,
        border: InputBorder.none,
      ),
    ),
  );
}