import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/homePage.dart';
import 'package:logioca/tutorial/pageTutorial2.dart';
import 'package:logioca/widgets/sliderTutorial.dart';
import 'package:sizer/sizer.dart';

class PageTutorial extends StatefulWidget {
  PageTutorial({Key key}) : super(key: key);
  @override
  PageTutorialState createState() => PageTutorialState();
}

class PageTutorialState extends State<PageTutorial> {
  PageController _myPage;
  int indiceSlider = 0;
  final List<Widget> listaImmagini = [
    Image(
      image: AssetImage("assets/images/schedaEventoTutorial1.png"),
      fit: BoxFit.contain,
    ),
    Image(
      image: AssetImage("assets/images/schedaEventoTutorial2.png"),
      fit: BoxFit.contain,
    ),
    Image(
      image: AssetImage("assets/images/schedaEventoTutorial3.png"),
      fit: BoxFit.contain,
    ),
    Image(
      image: AssetImage("assets/images/schedaEventoTutorial4.png"),
      fit: BoxFit.contain,
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
                              "Come funziona (1/3)",
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
                          itemList: listaImmagini)
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
              indiceSlider == 3
                  ? Container(
                      margin: EdgeInsets.only(top: 5.0.h),
                      height: 10.0.h,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageTutorial2()));
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
          "Partecipa ad un evento ",
          "Nella home appariranno tutti gli eventi creati da te o dai tuoi amici. Per partecipare basta spingere l'apposito pulsante sotto alla scheda dell'evento, su cui sono scritti tutti i dettagli. ",
        ];
      }
      break;
    case 1:
      {
        fraseTutorial = [
          "Hai cambiato idea? ",
          "Sei sempre in tempo per rimuovere la tua iscrizione ad un particolare evento. Il pulsante è sempre quello ma questa volta ti rimuoverà dalla lista dei partecipanti.",
        ];
      }
      break;
    case 2:
      {
        fraseTutorial = [
          "L'evento è iniziato ",
          "Ormai non c'è più tempo nè di iscriversi nè di rimuovere l'iscrizione. L'evento si sta svolgendo in questo momento.",
        ];
      }
      break;
    case 3:
      {
        fraseTutorial = [
          "L'evento è terminato",
          "Accedi ai dettagli per vedere le statistiche che lo riguardano. Inoltre all'interno della pagina dell'evento potrai votare la prestazione dei tuoi compagni e dei tuoi avversari, ovviamente solo se vi avrai partecipato.",
        ];
      }
      break;
    default:
  }
  return fraseTutorial;
}
