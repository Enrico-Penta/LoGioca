import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/widgets/sliderTutorial.dart';
import 'package:sizer/sizer.dart';
import 'common.dart';

final keyTutorial = GlobalKey<PageTutorialState>();

class PageTutorial extends StatefulWidget {
  int index;
  PageTutorial({this.index});
  @override
  PageTutorialState createState() => PageTutorialState();
}

class PageTutorialState extends State<PageTutorial> {
  @override
  PageController _myPage;
  int indiceSlider = 0;

  void setIndiceSlider(int i) {
    setState(() {
      indiceSlider = i;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _myPage,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 100.0.w,
                height: 55.0.h,
                color: Color(0xFFC9CFD6),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Come funziona (1/3)",
                              style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      TutorialSlider()
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          indiceSlider == 0 ? "Partecipa ad un evento" : "ciao",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Text(
                          "Nisl facilisis eros pulvinar viverra ac. Nulla donec egestas ac diam lacus. ANisl facilisis eros pulvinar viverra ac. Nulla donec egestas ac diam lacus. A")),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
