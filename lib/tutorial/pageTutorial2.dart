import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/homePage.dart';
import 'package:logioca/tutorial/pageTutorial3.dart';
import 'package:logioca/widgets/sliderTutorial.dart';
import 'package:sizer/sizer.dart';

import '../pageContainer.dart';

class PageTutorial2 extends StatefulWidget {
  PageTutorial2({Key key}) : super(key: key);
  @override
  PageTutorial2State createState() => PageTutorial2State();
}

class PageTutorial2State extends State<PageTutorial2> {
  PageController _myPage;
  int indiceSlider = 0;
  final List<Widget> listaImmagini2 = [
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 100.0.w,
              height: 60.0.h,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFF8BB3E3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      spreadRadius: -25,
                      blurRadius: 25,
                      offset: Offset(0, 10),
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage("assets/images/creatoreTutorial1.png"),
                    fit: BoxFit.fitWidth,
                    alignment: AlignmentDirectional.topCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Row(
            children: [
              Text(
                getTutorial(0)[0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF5C5C5C),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 100.0.w,
              child: Text(
                getTutorial(0)[1],
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Color(0xFF7C7C7C),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 100.0.w,
              height: 60.0.h,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFF8BB3E3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      spreadRadius: -25,
                      blurRadius: 25,
                      offset: Offset(0, 10),
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage("assets/images/creatoreTutorial2.png"),
                    fit: BoxFit.fitWidth,
                    alignment: AlignmentDirectional.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Row(
            children: [
              Text(
                getTutorial(1)[0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF5C5C5C),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 100.0.w,
              child: Text(
                getTutorial(1)[1],
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Color(0xFF7C7C7C),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 100.0.w,
              height: 60.0.h,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFF8BB3E3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      spreadRadius: -25,
                      blurRadius: 25,
                      offset: Offset(0, 10),
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage("assets/images/creatoreTutorial3.png"),
                    fit: BoxFit.fitWidth,
                    alignment: AlignmentDirectional.center,
                  ),
                ),
              ),
            ),
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Row(
            children: [
              Text(
                getTutorial(2)[0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF5C5C5C),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 100.0.w,
              child: Text(
                getTutorial(2)[1],
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Color(0xFF7C7C7C),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ];

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
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                TutorialSlider(
                  setField: (val) {
                    setState(() {
                      indiceSlider = val;
                    });
                  },
                  itemList: listaImmagini2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Creazione evento (${indiceSlider + 1}/${listaImmagini2.length})",
                        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            indiceSlider == 2
                ? Container(
                    margin: EdgeInsets.only(bottom: 8.0.h),
                    height: 10.0.h,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageTutorial3()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 35.0.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFF57A1F9),
                        ),
                        child: Text(
                          "Avanti",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(bottom: 8.0.h),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageContainer()));
                      },
                      child: Text("Salta il tutorial"),
                    ),
                  )
          ],
        ),
      ],
    )
        //],
        //),
        );
  }
}

List<String> getTutorial(int pagSlider) {
  List<String> fraseTutorial;
  switch (pagSlider) {
    case 0:
      {
        fraseTutorial = [
          "Crea evento",
          "Nella home appariranno tutti gli eventi creati da te o dai tuoi amici. Per partecipare basta spingere l'apposito pulsante sotto alla scheda dell'evento, su cui sono scritti tutti i dettagli. ",
        ];
      }
      break;
    case 1:
      {
        fraseTutorial = [
          "Crea squadre",
          "Sei sempre in tempo per rimuovere la tua iscrizione ad un particolare evento. Il pulsante è sempre quello ma questa volta ti rimuoverà dalla lista dei partecipanti.",
        ];
      }
      break;
    case 2:
      {
        fraseTutorial = [
          "Inserisci statistiche",
          "Ormai non c'è più tempo nè di iscriversi nè di rimuovere l'iscrizione. L'evento si sta svolgendo in questo momento.",
        ];
      }
      break;
    default:
  }
  return fraseTutorial;
}
