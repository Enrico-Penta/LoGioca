import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/api.dart';
import 'package:logioca/main.dart';

import 'common.dart';
import 'models/notifica.dart';

class PageNotifiche extends StatefulWidget {
  @override
  _PageNotificheState createState() => _PageNotificheState();
}

class _PageNotificheState extends State<PageNotifiche> {
  ListaNotifiche listaNotifiche;
  bool caricamento = true;
  Future<ListaNotifiche> getNotificheAll() async {
    getNotifiche(utente.id).then((value) {
      listaNotifiche = value;
      caricamento = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListaNotifiche>(
        future: getNotificheAll(),
        builder: (context, AsyncSnapshot<ListaNotifiche> snapshot) {
          return Container(
              child: SafeArea(
            child: Scaffold(
              appBar: myAppBar(),
              body: SingleChildScrollView(
                child: caricamento ? ListBody(children: []) : Loader(),
              ),
            ),
          ));
        });
  }
}
