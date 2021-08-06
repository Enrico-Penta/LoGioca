import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/homePage.dart';
import 'package:logioca/widgets/sliderTutorial.dart';
import 'package:sizer/sizer.dart';

import '../pageContainer.dart';

class PageTutorial3 extends StatefulWidget {
  PageTutorial3({Key key}) : super(key: key);
  @override
  PageTutorial3State createState() => PageTutorial3State();
}

class PageTutorial3State extends State<PageTutorial3> {
  PageController _myPage;
  int indiceSlider = 0;
  final List<Widget> listaImmagini3 = [
    Image(
      image: AssetImage("assets/images/creatoreTutorial1.png"),
      fit: BoxFit.contain,
    ),
    Image(
      image: AssetImage("assets/images/creatoreTutorial2.png"),
      fit: BoxFit.contain,
    ),
    Image(
      image: AssetImage("assets/images/creatoreTutorial3.png"),
      fit: BoxFit.contain,
    )
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
                              /*"Come funziona (${indiceSlider + 1}/${listaImmagini.length})",*/
                              "Come funziona (2/3)",
                              style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      TutorialSlider(
                          setField: (val) {
                            setState(() {
                              indiceSlider = val;
                            });
                          },
                          itemList: listaImmagini3)
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Row(
                      children: [
                        Text(
                          getTutorial(this.indiceSlider)[0],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
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
                          getTutorial(this.indiceSlider)[1],
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              indiceSlider == 2
                  ? Container(
                      margin: EdgeInsets.only(top: 5.0.h),
                      height: 10.0.h,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageContainer()));
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
                  : SizedBox()
            ],
          )
        ],
      ),
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
