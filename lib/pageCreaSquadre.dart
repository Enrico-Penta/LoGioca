import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/main.dart';
import 'package:logioca/models/evento.dart';

import 'api.dart';
import 'common.dart';
import 'package:sizer/sizer.dart';

import 'models/partecipanti.dart';

class PageCreaSquadre extends StatefulWidget {
  PageCreaSquadre(this.evento, this.contextpop, {Key key}) : super(key: key);

  Evento evento;
  final BuildContext contextpop;
  @override
  _PagePageCreaSquadre createState() => _PagePageCreaSquadre();
}

class _PagePageCreaSquadre extends State<PageCreaSquadre> {
  Partecipanti listaPartecipanti;
  bool caricamento = false;
  bool spostamentoGiocatore = false;
  Partecipante partecipanteDrag = new Partecipante();

  List<Partecipante> listaSquadraA = new List<Partecipante>();
  List<Partecipante> listaSquadraB = new List<Partecipante>();
  List<Partecipante> listaPanchina = new List<Partecipante>();

  Future<Partecipanti> getGiocatori() async {
    await getPartecipanti(utente.id, widget.evento.id).then((value) {
      listaPartecipanti = value;
      listaPanchina.clear();
      listaSquadraA.clear();
      listaSquadraB.clear();
      if (listaPartecipanti?.listaPartecipanti != null) {
        for (var i = 0; i < listaPartecipanti.listaPartecipanti.length; i++) {
          if (listaPartecipanti?.listaPartecipanti[i].idSquadra == 1) {
            listaSquadraA.add(listaPartecipanti.listaPartecipanti[i]);
          }
          if (listaPartecipanti?.listaPartecipanti[i].idSquadra == 2) {
            listaSquadraB.add(listaPartecipanti.listaPartecipanti[i]);
          }
          if (listaPartecipanti?.listaPartecipanti[i].idSquadra == null) {
            listaPanchina.add(listaPartecipanti?.listaPartecipanti[i]);
          }
        }
        listaPartecipanti?.listaPartecipanti = listaPanchina;
      }
      caricamento = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Partecipanti>(
        future: getGiocatori(),
        builder: (context, AsyncSnapshot<Partecipanti> snapshot) {
          return MaterialApp(
            key: Key(DateTime.now().toIso8601String()),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                appBar: myAppBar(
                    automaticallyImplyLeading: false,
                    onBack: () {
                      Navigator.pop(widget.contextpop);
                    }),
                body: Column(children: [
                  Stack(children: [
                    Container(
                      height: 25.0.h,
                      width: double.infinity,
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
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
                                  width: 10.0.w,
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
                  //dragabble
                  caricamento
                      ? Expanded(
                          child: ListView(children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.grey[200],
                            child: Text(
                                "Per creare le squadre trascina i giocatori disponibili a sinistra o destra per assegnarli alla squadra bianca o nera."),
                          ),
                          if (listaPartecipanti != null)
                            Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              DragTarget<Partecipante>(
                                key: Key(DateTime.now().toIso8601String()),
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                    decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.black))),
                                    width: 32.0.w,
                                    height: 100.0.h,
                                    child: Column(
                                      children: [
                                        for (var j = 0; j < listaSquadraA?.length; j++)
                                          Column(children: [
                                            SizedBox(height: 5.0.h),
                                            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                              CircleAvatar(
                                                backgroundImage: AssetImage("assets/images/utenteIncognito.png"),
                                              ),
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                alignment: Alignment.topCenter,
                                                icon: Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  deleteFromSquadra(listaSquadraA[j]?.idUser, widget.evento.id, 0).then((value) {
                                                    setState(() {
                                                      listaPanchina.clear();
                                                      listaSquadraA.clear();
                                                      listaSquadraB.clear();
                                                    });
                                                  });
                                                },
                                              ),
                                            ]),
                                            Text(listaSquadraA[j]?.nome),
                                            Text(listaSquadraA[j]?.cognome),
                                          ]),
                                      ],
                                    ),
                                  );
                                },
                                onAccept: (Partecipante v) {
                                  setState(() {
                                    spostamentoGiocatore = true;
                                  });

                                  setSquadra(v.idUser, widget.evento.id, 1).then((value) {
                                    setState(() {
                                      listaPanchina.clear();
                                      listaSquadraA.clear();
                                      listaSquadraB.clear();
                                      spostamentoGiocatore = false;
                                    });
                                  });
                                },
                              ),
                              if (listaPartecipanti?.listaPartecipanti?.length == 0)
                                Container(
                                  width: 32.0.w,
                                )
                              else
                                //colonna centrale
                                !spostamentoGiocatore
                                    ? Column(children: [
                                        Container(
                                          width: 32.0.w,
                                          padding: EdgeInsets.all(4),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Disponibili",
                                            style: TextStyle(color: viola, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        for (var i = 0; i < listaPartecipanti.listaPartecipanti.length; i++)
                                          Draggable<Partecipante>(
                                            key: Key(DateTime.now().toIso8601String()),
                                            data: listaPartecipanti?.listaPartecipanti[i],
                                            child: Container(
                                                alignment: Alignment.topCenter,
                                                width: 32.0.w,
                                                padding: EdgeInsets.only(top: 2.0.h),
                                                child: Column(children: [
                                                  CircleAvatar(
                                                    backgroundImage: AssetImage("assets/images/utenteIncognito.png"),
                                                  ),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  Text(
                                                    listaPartecipanti?.listaPartecipanti[i].nome,
                                                    style: TextStyle(fontSize: 3.5.w),
                                                  ),
                                                  Text(
                                                    listaPartecipanti?.listaPartecipanti[i].cognome,
                                                    style: TextStyle(fontSize: 3.5.w),
                                                  )
                                                ])),
                                            feedback: Material(
                                                color: Colors.transparent,
                                                child: Container(
                                                    width: 32.0.w,
                                                    alignment: Alignment.topCenter,
                                                    child: Column(children: [
                                                      CircleAvatar(
                                                        backgroundImage: AssetImage("assets/images/utenteIncognito.png"),
                                                      ),
                                                      Text(listaPartecipanti?.listaPartecipanti[i]?.nome,
                                                          style: TextStyle(fontSize: 3.0.w, color: Colors.black)),
                                                      Text(
                                                        listaPartecipanti?.listaPartecipanti[i]?.cognome,
                                                        style: TextStyle(fontSize: 3.0.w, color: Colors.black),
                                                      )
                                                    ]))),
                                            childWhenDragging: Container(
                                              width: 32.0.w,
                                            ),
                                          ),
                                      ])
                                    : Container(padding: EdgeInsets.only(top: 2.0.h), width: 32.0.w, child: Loader()),
                              DragTarget<Partecipante>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                    decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black))),
                                    width: 32.0.w,
                                    height: 100.0.h,
                                    child: Column(
                                      children: [
                                        for (var j = 0; j < listaSquadraB.length; j++)
                                          Column(children: [
                                            SizedBox(height: 5.0.h),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: AssetImage("assets/images/utenteIncognito.png"),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  alignment: Alignment.topCenter,
                                                  icon: Icon(
                                                    Icons.cancel,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    deleteFromSquadra(listaSquadraB[j]?.idUser, widget.evento.id, 0).then((value) {
                                                      setState(() {
                                                        listaPanchina.clear();
                                                        listaSquadraA.clear();
                                                        listaSquadraB.clear();
                                                      });
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                            Text(listaSquadraB[j].nome),
                                            Text(listaSquadraB[j].cognome),
                                          ]),
                                      ],
                                    ),
                                  );
                                },
                                onAccept: (Partecipante v) {
                                  setState(() {
                                    spostamentoGiocatore = true;
                                  });
                                  setSquadra(v.idUser, widget.evento.id, 2).then((value) {
                                    setState(() {
                                      listaPanchina.clear();
                                      listaSquadraA.clear();
                                      listaSquadraB.clear();
                                      spostamentoGiocatore = false;
                                    });
                                  });
                                },
                              )
                            ])
                        ]))
                      : Loader()
                ])),
          );
        });
  }
}
