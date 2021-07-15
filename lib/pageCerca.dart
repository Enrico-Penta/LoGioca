import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/api.dart';
import 'package:logioca/main.dart';
import 'package:logioca/models/utente.dart';
import 'package:logioca/pageProfilo.dart';
import 'package:logioca/pageProfiloUtente.dart';
import 'package:logioca/widgets/fields.dart';
import 'package:sizer/sizer.dart';

import 'common.dart';
import 'models/giocatore.dart';

class PageCerca extends StatefulWidget {
  @override
  _PageCercaState createState() => _PageCercaState();
}

class _PageCercaState extends State<PageCerca> {
  String parola = "";
  ListaGiocatori listaGiocatori;
  bool caricamento = false;

  Future<ListaGiocatori> ricerca(String parola) async {
    await getRicerca(utente.id, parola).then((value) {
      listaGiocatori = value;

      caricamento = true;
    });
  }

  @override
  void initState() {
    caricamento = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListaGiocatori>(
        future: ricerca(parola),
        builder: (context, AsyncSnapshot<ListaGiocatori> snapshot) {
          return Expanded(
              key: Key(DateTime.now().toIso8601String()),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(right: 2.0.h, left: 2.0.h, top: 0.5.w),
                  child: TextFormField(
                      initialValue: parola,
                      cursorColor: Colors.grey,
                      style: TextStyle(
                        fontFamily: 'ToyotaType Book',
                        fontStyle: FontStyle.normal,
                        fontSize: 14.7.sp,
                        color: Colors.black,
                      ),
                      enableSuggestions: false,
                      onChanged: (v) {
                        parola = v;
                      },
                      decoration: InputDecoration(
                        hintText: "Cerca..",
                        contentPadding: EdgeInsets.only(left: 2.0.w, top: 2.0.h),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: viola),
                          onPressed: () {
                            setState(() {
                              parola = parola;
                              caricamento = false;
                            });
                          },
                        ),
                      )),
                ),
                Divider(
                  color: viola,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: caricamento
                      ? ListBody(children: [
                          if (listaGiocatori != null)
                            for (var i = 0; i < listaGiocatori.listaGiocatori.length; i++)
                              if (listaGiocatori.listaGiocatori[i].nome != null && listaGiocatori.listaGiocatori[i].idUser != utente.id)
                                Container(
                                    padding: EdgeInsets.symmetric(vertical: 2.0.w, horizontal: 2.0.w),
                                    width: double.infinity,
                                    child: ListTile(
                                        leading: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                        new PageProfiloUtente(listaGiocatori.listaGiocatori[i].idUser)));
                                          },
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage("assets/images/utenteIncognito.png"),
                                          ),
                                        ),
                                        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Row(children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (BuildContext context) =>
                                                            new PageProfiloUtente(listaGiocatori.listaGiocatori[i].idUser)));
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 2.0.w,
                                                  ),
                                                  SizedBox(
                                                      child: Text(
                                                    listaGiocatori.listaGiocatori[i].nome,
                                                    style: TextStyle(fontSize: 4.0.w, fontWeight: FontWeight.bold),
                                                  )),
                                                  SizedBox(
                                                    width: 1.0.w,
                                                  ),
                                                  SizedBox(
                                                      child: Text(
                                                          listaGiocatori.listaGiocatori[i].cognome != null
                                                              ? listaGiocatori.listaGiocatori[i].cognome
                                                              : "",
                                                          style: TextStyle(fontSize: 4.0.w, fontWeight: FontWeight.bold)))
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              height: 4.5.h,
                                              alignment: Alignment.topRight,
                                              child: listaGiocatori.listaGiocatori[i].idLivelloAmicizia == null
                                                  ? TextButton(
                                                      onPressed: () {
                                                        inviaRichiesta(utente.id, listaGiocatori.listaGiocatori[i].idUser).then((value) {
                                                          setState(() {
                                                            listaGiocatori.listaGiocatori[i].idLivelloAmicizia = 'AM';
                                                          });
                                                        });
                                                      },
                                                      child: Text(
                                                        "Aggiungi",
                                                        style: TextStyle(color: viola),
                                                      ))
                                                  : SizedBox(),
                                            ))
                                          ]),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext context) =>
                                                          new PageProfiloUtente(listaGiocatori.listaGiocatori[i].idUser)));
                                            },
                                            child: Text(
                                              listaGiocatori.listaGiocatori[i].email != null ? listaGiocatori.listaGiocatori[i].email : "",
                                              style: TextStyle(fontSize: 3.0.w),
                                            ),
                                          )
                                        ])))
                        ])
                      : Loader(),
                ))
              ]));
        });
  }
}
