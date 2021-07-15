import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/models/evento.dart';
import 'package:logioca/pageContainer.dart';
import 'package:logioca/pageProfiloUtente.dart';

import 'api.dart';
import 'common.dart';
import 'package:sizer/sizer.dart';

import 'main.dart';
import 'models/partecipanti.dart';

class PageDettagli extends StatefulWidget {
  PageDettagli(this.evento, {Key key}) : super(key: key);

  Evento evento;
  @override
  _PageDettagliState createState() => _PageDettagliState();
}

class _PageDettagliState extends State<PageDettagli> {
  Partecipanti listaPartecipanti;
  bool caricamento = false;
  Future<Partecipanti> getGiocatori() async {
    await getPartecipanti(utente.id, widget.evento.id).then((value) {
      if (value != null) {
        listaPartecipanti = value;
      }

      caricamento = true;
    });
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
                        Row(
                          children: [
                            Container(
                              width: 49.0.w,
                              height: 100.0.h,
                              child: Column(
                                children: [
                                  for (var i = 0; i < listaPartecipanti.listaPartecipanti.length; i++)
                                    if (listaPartecipanti.listaPartecipanti[i].idSquadra == 1)
                                      GestureDetector(
                                        onTap: () {
                                          listaPartecipanti.listaPartecipanti[i].idUser != utente.id
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
                                                          )));
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
                                    if (listaPartecipanti.listaPartecipanti[i].idSquadra == 1)
                                      GestureDetector(
                                        onTap: () {
                                          listaPartecipanti.listaPartecipanti[i].idUser != utente.id
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
                                                          )));
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
}
