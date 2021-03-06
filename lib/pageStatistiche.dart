import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/models/evento.dart';
import 'package:logioca/pageContainer.dart';
import 'package:logioca/pageProfiloUtente.dart';
import 'package:logioca/widgets/fields.dart';

import 'api.dart';
import 'common.dart';
import 'package:sizer/sizer.dart';

import 'main.dart';
import 'models/partecipanti.dart';

class PageStatistiche extends StatefulWidget {
  PageStatistiche(this.evento, {Key key}) : super(key: key);

  Evento evento;
  @override
  _PageStatisticheState createState() => _PageStatisticheState();
}

class _PageStatisticheState extends State<PageStatistiche> {
  Partecipanti listaPartecipanti;
  bool caricamento = false;
  Future<Partecipanti> getGiocatori() async {
    await getPartecipanti(utente.id, widget.evento.id).then((value) {
      if (value != null) {
        listaPartecipanti = value;
      }

      caricamento = true;
    });
    return listaPartecipanti;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Partecipanti>(
        future: getGiocatori(),
        builder: (context, AsyncSnapshot<Partecipanti> snapshot) {
          return Container(
              child: SafeArea(
                  child: Scaffold(
            appBar: myAppBar(),
            body: Column(children: [
              Stack(children: [
                Container(
                  height: 26.0.h,
                  width: double.infinity,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                    image: DecorationImage(image: AssetImage("assets/images/sfondoDiv_formazione.png"), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                    top: 2.0.h,
                    left: 4.0.w,
                    child: Row(
                      children: [
                        Container(
                            width: 46.0.w,
                            child: Row(children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              Text(widget.evento.titolo, style: TextStyle(color: Colors.white))
                            ])),
                        Container(
                            width: 46.0.w,
                            alignment: Alignment.centerRight,
                            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                              Icon(
                                Icons.create,
                                color: Colors.white,
                              ),
                              Text(widget.evento.creatore, style: TextStyle(color: Colors.white)),
                            ]))
                      ],
                    )),
                Positioned(
                    top: 6.0.h,
                    left: 4.0.w,
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white),
                        Text(widget.evento.luogo, style: TextStyle(color: Colors.white))
                      ],
                    )),
                Positioned(
                    top: 15.0.h,
                    child: Row(children: [
                      Container(
                        padding: EdgeInsets.only(left: 4.0.w),
                        width: 43.0.w,
                        child: Row(
                          children: [
                            Image(image: AssetImage("assets/images/SquadraBianca.png")),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 10.0.w,
                              child: Text(
                                "0",
                                style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 10.0.w,
                        child: Text(
                          "-",
                          style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                        ),
                      ),
                      Container(
                        width: 43.0.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 15.0.w,
                              child: Text(
                                "0",
                                style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                              ),
                            ),
                            Image(image: AssetImage("assets/images/SquadraNera.png")),
                          ],
                        ),
                      ),
                    ]))
              ]),
              caricamento
                  ? Expanded(
                      child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.grey[200],
                          child: Text("Clicca i giocatori che hanno segnato per registrare i gol."),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 49.0.w,
                              height: 100.0.h,
                              decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.black))),
                              child: Column(
                                children: [
                                  for (var i = 0; i < listaPartecipanti.listaPartecipanti.length; i++)
                                    if (listaPartecipanti.listaPartecipanti[i].idSquadra == 1)
                                      GestureDetector(
                                        onTap: () {
                                          popupGol(context, listaPartecipanti.listaPartecipanti[i].idUser,
                                              listaPartecipanti.listaPartecipanti[i].nome);
                                          /*listaPartecipanti.listaPartecipanti[i].idUser != utente.id
                                              ? Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext context) =>
                                                          new PageProfiloUtente(listaPartecipanti.listaPartecipanti[i].idUser)))
                                              : Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext context) => new PageContainer(
                                                            index: 2,
                                                          )));*/
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: AssetImage("assets/images/utenteIncognito.png"),
                                            ),
                                            Text(
                                              listaPartecipanti?.listaPartecipanti[i].nome,
                                              style: TextStyle(fontSize: 3.0.w),
                                            ),
                                            Text(
                                              listaPartecipanti?.listaPartecipanti[i].cognome,
                                              style: TextStyle(fontSize: 3.0.w),
                                            )
                                          ],
                                        ),
                                      )
                                ],
                              ),
                            ),
                            Container(
                              width: 49.0.w,
                              height: 100.0.h,
                              child: Column(
                                children: [
                                  for (var i = 0; i < listaPartecipanti.listaPartecipanti.length; i++)
                                    if (listaPartecipanti.listaPartecipanti[i].idSquadra == 2)
                                      GestureDetector(
                                        onTap: () {
                                          popupGol(context, listaPartecipanti.listaPartecipanti[i].idUser,
                                              listaPartecipanti.listaPartecipanti[i].nome);
                                          /*listaPartecipanti.listaPartecipanti[i].idUser != utente.id
                                              ? Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext context) =>
                                                          new PageProfiloUtente(listaPartecipanti.listaPartecipanti[i].idUser)))
                                              : Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext context) => new PageContainer(
                                                            index: 2,
                                                          )));*/
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: AssetImage("assets/images/utenteIncognito.png"),
                                            ),
                                            Text(
                                              listaPartecipanti?.listaPartecipanti[i].nome,
                                              style: TextStyle(fontSize: 3.0.w),
                                            ),
                                            Text(
                                              listaPartecipanti?.listaPartecipanti[i].cognome,
                                              style: TextStyle(fontSize: 3.0.w),
                                            )
                                          ],
                                        ),
                                      )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ))
                  : Loader()
            ]),
          )));
        });
  }

  popupGol(BuildContext context, int idGiocatore, String nomeGiocatore, {bool errore: false}) {
    final keyform = GlobalKey<FormState>();
    String nGol;
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Quanti gol ha fatto $nomeGiocatore ?"),
              content: Container(
                  height: 30.0.h,
                  child: Column(
                    children: [
                      Form(
                        key: keyform,
                        child: MyTextField(["Gol"], initialValue: "", setField: (value) {
                          nGol = value;
                        }),
                      ),
                      SizedBox(height: 5.0.h),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.all(1.0.h),
                            backgroundColor: Color(0xFF2F267A),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                        onPressed: () {
                          setGol(utente.id, widget.evento.id, idGiocatore, int.parse(nGol)).then((value) {
                            if (jsonDecode(jsonDecode(value)['data'])["Output"]["Messaggi"] == null) {
                              setState(() {
                                print("ok");
                                Navigator.pop(context);
                              });
                            } else {
                              Navigator.pop(context);
                              popupGol(context, idGiocatore, nomeGiocatore, errore: true);
                            }
                          });
                        },
                        child: Text(
                          "Salva",
                          style: TextStyle(color: Colors.white, fontSize: 5.0.w, fontWeight: FontWeight.w400),
                        ),
                      ),
                      !errore
                          ? SizedBox()
                          : Text("Valore non valido!",
                              style: TextStyle(
                                color: Colors.red,
                              ))
                    ],
                  )),
            ));
  }
}
