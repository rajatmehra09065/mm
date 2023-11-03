import 'package:mm/repository/check_code_repository.dart';
import 'package:mm/views/user_details/user_details.dart';

import '../../consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RedeemScreen extends StatefulWidget {
  final Map<String, dynamic>? doneCheckCodeDataMap;
  final List<dynamic>? doneListCodeDataMap;
  final List<dynamic>? doneListCodeIdDataMap;
  final int selectedIndex;

  const RedeemScreen({
    required this.doneCheckCodeDataMap,
    required this.doneListCodeDataMap,
    required this.doneListCodeIdDataMap,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Call the API when the screen is opened
    _callApi();
  }

  PriceOpen priceOpen = PriceOpen();

  // Define a method to call your API
  Future<void> _callApi() async {
    setState(() {
      isLoading = true;
    });

    try {
      await priceOpen.hitPriceOpenApi(
        priceID: widget.doneListCodeDataMap![widget.selectedIndex]['id'],
        codeId: widget.doneListCodeIdDataMap![0]['code'].toString(),
      );




    } catch (e) {
      print("catch error${e}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
    final height = MediaQuery
        .sizeOf(context)
        .height * 1;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.020),

                // Redeem text
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      redeem,
                      style: TextStyle(
                          fontFamily: bold, fontSize: 20, color: Colors.black),
                    )),
                SizedBox(height: height * 0.020),

                // Price img which is fetched from the API
                Image.network(widget.doneListCodeDataMap![widget
                    .selectedIndex]['picture'], width: 190, height: 190),

                SizedBox(height: height * 0.020),

                // Prize name which is fetched from the API
                Center(
                  child: Text(widget.doneListCodeDataMap![widget.selectedIndex]['name'])
                      .text.fontFamily(bold).size(20)
                      .make(),
                ),

                SizedBox(height: height * 0.020),

                // Items images in grid list
                Container(
                  padding: EdgeInsets.all(20),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.doneListCodeDataMap!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      bool isCardSelected = (index == widget.selectedIndex);

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            if (isCardSelected)
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                                widget.doneListCodeDataMap![index]['picture'],
                                width: 110, height: 110),



                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                color: Colors.transparent,
                                child: Text(
                                  (index + 1).toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    color: fontGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            if (isCardSelected)
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0) , color: Colors.black26.withOpacity(0.4),
                                ),
                                
                              ),
                            if (isCardSelected)
                              Text(
                                "Redeemed",
                                style: TextStyle(
                                  fontFamily: semibold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                          ],

                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: height * 0.020),

                // Redeem button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius
                        .circular(30)),
                    backgroundColor: pinkishOrange,
                    padding: EdgeInsets.all(12),
                  ),
                  onPressed: isLoading ? null : () async {

                    if (priceOpen.donePriceOpenCodeDataMap!['code'] == 200) {
                      Get.to(
                        UserDetails(
                          doneListCodeDataMap: widget.doneListCodeDataMap!,
                          selectedIndex: widget.selectedIndex,
                          doneListCodeIdDataMap: widget.doneListCodeIdDataMap![0]['code'],
                        ),
                        duration: Duration(milliseconds: 1100),
                        transition: Transition.rightToLeft,
                      );
                    } else if (priceOpen.donePriceOpenCodeDataMap!['code'] == 400) {
                      print("code 400");
                    }

                  },
                  child: Text("Redeem").text.white.fontFamily(bold)
                      .size(16)
                      .make(),
                ).box.width(context.screenWidth - 40).height(55).make(),

                SizedBox(height: height * 0.030),

                if (isLoading) CircularProgressIndicator(color: pinkishOrange),
              ],
            ),
          ),
        ),
      ),
    );
  }}
