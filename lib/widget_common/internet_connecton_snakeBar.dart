import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

import '../consts/colors.dart';

class ConnectivityController extends GetxController {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen((result) {
      isConnected.value = result != ConnectivityResult.none;
    });
  }
}




class SnackbarController extends GetxController {
  final snackbar = Rxn<GetBar>();

  void showSnackbar(String message) {
    snackbar.value = GetBar(
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: pinkishOrange,
    );
  }

  void hideSnackbar() {
    snackbar.value = null;
  }
}


