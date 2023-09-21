import 'package:flutter/material.dart';
import 'package:mm/consts/consts.dart';

import '../../consts/lists.dart';
import '../../consts/styles.dart';
import '../../repository/check_code_repository.dart';
import '../../widget_common/open_button.dart';

class OpenCardScreen extends StatefulWidget {
  final Map<String, dynamic>? doneCheckCodeDataMap;
  final List<dynamic>? doneListCodeDataMap;

  const OpenCardScreen({
    required this.doneCheckCodeDataMap,
    required this.doneListCodeDataMap,
    Key? key,
  }) : super(key: key);


  @override
  State<OpenCardScreen> createState() => _OpenCardScreenState();
}

class _OpenCardScreenState extends State<OpenCardScreen> {
  CheckCodeRepository checkCodeRepository = CheckCodeRepository();

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return WillPopScope(
      onWillPop: () async {
        // Perform your custom action here, e.g., show a dialog or do nothing.
        // To prevent navigation back, return 'false'.
        return false;
      },

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: height * 0.03,),
              // Text
              Align(
                alignment: Alignment.center,
                child: Text(
                  "You Can Open One Card",
                  style: TextStyle(
                    fontFamily: semibold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: height * 0.001,),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: buildCardStack(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardStack() {
    // Check if doneListCodeDataMap is not null
    if (widget.doneListCodeDataMap != null) {
      // Get the length of the API data
      int apiDataLength = widget.doneListCodeDataMap!.length;


      // Ensure that the index is within the bounds of the API data
      return Expanded(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
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
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(openCardsIconsList[index]),
                    Positioned(
                      top: 43,
                      left: 58,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        color: Colors.transparent,
                        child: Text(
                          (index + 1).toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 8,
                        right: 8,
                        left: 8,
                        child: openButton(
                          doneCheckCodeDataMap: widget.doneCheckCodeDataMap,
                          doneListCodeDataMap: widget.doneListCodeDataMap,
                          index: index,).box.width(130).height(35).make()
                    ),
                  ],
                ).box.roundedSM.clip(Clip.antiAlias).make();
              },
            ),
          ),
        ),
      );
    } else {
      // Handle the case where doneListCodeDataMap is null
      return CircularProgressIndicator(color: pinkishOrange,); // Show a loading indicator or handle accordingly
    }
  }
}
