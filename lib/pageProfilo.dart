import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/api.dart';
import 'package:logioca/common.dart';
import 'package:logioca/models/giocatore.dart';
import 'package:logioca/models/utente.dart';
import 'package:logioca/widgets/slider.dart';
import 'package:logioca/widgets/tendinaSport.dart';
import 'package:sizer/sizer.dart';

class PageProfilo extends StatefulWidget {
  int id;

  PageProfilo(this.id, {Key key}) : super(key: key);

  @override
  _PageProfiloState createState() => _PageProfiloState();
}

class _PageProfiloState extends State<PageProfilo> {
  UtenteProfilo profiloUtente = new UtenteProfilo();

  bool caricamento = false;
  bool caricamentoAmici = false;
  bool caricamentoStatistiche = false;
  ScrollController controller;
  Giocatore statisticheGiocatore;
  ListaGiocatori listaAmici;

  Future<UtenteProfilo> datiUtente() async {
    await getUtente(widget.id).then((value) {
      profiloUtente = value;

      caricamento = true;
    });

    await getClassifica(1).then((value) {
      try {
        statisticheGiocatore = value.listaGiocatori.where((element) => element.idUser == widget.id).first;
      } catch (e) {
        statisticheGiocatore = null;
      }
      caricamentoStatistiche = true;
    });

    await getAmici(widget.id).then((value) {
      listaAmici = value;
      caricamentoAmici = true;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = new ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UtenteProfilo>(
      future: datiUtente(),
      builder: (context, AsyncSnapshot<UtenteProfilo> snapshot) {
        return caricamento
            ? SingleChildScrollView(
                controller: controller,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 24.0, bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: 10.0.w,
                              )
                            ],
                          ),
                          Column(children: [
                            Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage("assets/images/utenteIncognito.png"),
                                radius: 80.0,
                              ),
                            ),
                          ]),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.0.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      print("CIAONE");
                                    },
                                    child: Container(
                                      width: 10.0.w,
                                      child: GestureDetector(
                                        onTap: toggleIcon,
                                        child: Image(
                                          width: 35,
                                          color: viola,
                                          image: AssetImage(
                                            "assets/images/icon_settings.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '${profiloUtente.nome} ${profiloUtente.cognome}',
                        style: TextStyle(color: viola, fontSize: 22.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        profiloUtente.email,
                        style: TextStyle(fontSize: 18.0, color: arancione, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 1.5.h),
                            child: Text(
                              "Achievements",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          /*Container(
                          child: TextButton(
                            onPressed: () {},
                            child: Text("mostra tutti"),
                          ),
                        )*/
                        ],
                      ),
                    ),
                    Container(
                      width: 80.0.w,
                      height: 24.0.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: viola,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(children: [
                                  Image(
                                    image: AssetImage("assets/images/Icon_medagliaBronzo.png"),
                                  ),
                                  Text("Presenze", textAlign: TextAlign.center)
                                ]),
                                Column(children: [
                                  Image(
                                    image: AssetImage("assets/images/Icon_medagliaArgento.png"),
                                  ),
                                  Text("Goal segnati", textAlign: TextAlign.center)
                                ]),
                                Column(children: [
                                  Image(
                                    image: AssetImage("assets/images/Icon_medagliaOro.png"),
                                  ),
                                  Text("Assist", textAlign: TextAlign.center)
                                ]),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(children: [
                                  Image(
                                    image: AssetImage("assets/images/Icon_medagliaBloccata.png"),
                                  ),
                                  Text("Presenze", textAlign: TextAlign.center)
                                ]),
                                Column(children: [
                                  Image(
                                    image: AssetImage("assets/images/Icon_medagliaBloccata.png"),
                                  ),
                                  Text("Goal segnati", textAlign: TextAlign.center)
                                ]),
                                Column(children: [
                                  Image(
                                    image: AssetImage("assets/images/Icon_medagliaBloccata.png"),
                                  ),
                                  Text("Assist", textAlign: TextAlign.center)
                                ]),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 2.0.h, top: 4.0.h, left: 12.0.w, right: 12.0.w),
                        child: Row(
                          children: [
                            Text(
                              "Amici",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ) /*SliderAmici(),*/
                        ),
                    if (listaAmici?.listaGiocatori != null)
                      if (listaAmici.listaGiocatori.length > 0)
                        NoonLoopingDemo(listaAmici)
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(2.0.w),
                          child: Text("Nessun amico aggiunto!"),
                        )
                    else
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(2.0.w),
                        child: Text("Nessun amico aggiunto!"),
                      ),
                    SizedBox(
                      height: 0.1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                      child: statisticheGiocatore != null ? TendinaSport(new Sport(), controller, statisticheGiocatore) : SizedBox(),
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                  ],
                ),
              )
            : Loader();
      },
    );
  }

  void toggleIcon() => setState(() {
        return showDialog(
          context: context,
          builder: (_) => new AlertDialog(
            elevation: 5,
            backgroundColor: Colors.white,
            content: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                          child: Image(
                            image: AssetImage("assets/images/icon_modifica.png"),
                            width: 4.0.w,
                          ),
                        ),
                        Text(
                          "Cambia password",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.0.h),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                          child: Image(
                            image: AssetImage("assets/images/icon_logout.png"),
                            color: Colors.red,
                            width: 4.0.w,
                          ),
                        ),
                        Text(
                          "Esci",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
