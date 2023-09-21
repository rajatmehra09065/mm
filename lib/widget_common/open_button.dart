

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../consts/consts.dart';
import '../views/redeemed_screen/redeemed_screen.dart';

Widget openButton({
  required Map<String, dynamic>? doneCheckCodeDataMap,
  required List<dynamic>? doneListCodeDataMap,
  required int index,
}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(12)
      ),
      onPressed: () async{

        Get.to(
            RedeemScreen(
              doneCheckCodeDataMap: doneCheckCodeDataMap,
              doneListCodeDataMap: doneListCodeDataMap,
                selectedIndex: index

            ), //next page class
            duration: Duration(milliseconds: 1100 ), //duration of transitions, default 1 sec
            transition: Transition.fadeIn); //transition effect

      }, child: open.text.fontFamily(semibold).black.make());
}