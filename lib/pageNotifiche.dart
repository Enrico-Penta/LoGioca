import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/api.dart';
import 'package:logioca/main.dart';
import 'package:sizer/sizer.dart';
import 'common.dart';
import 'models/notifica.dart';

class PageNotifiche extends StatefulWidget {
  PageNotifiche({Key key}) : super(key: key);
  @override
  _PageNotificheState createState() => _PageNotificheState();
}

class _PageNotificheState extends State<PageNotifiche> {
  ListaNotifiche listaNotifiche;
  bool caricamento = false;
  ScrollController controller;

  Future<ListaNotifiche> getNotificheAll() async {
    await getNotifiche(utente.id).then((value) {
      listaNotifiche = value;
      caricamento = true;
      return listaNotifiche;
    });
  }

  Future<void> setchecklastNotificheAll() async {
    int esito;
    try {
      await setNotifiche(utente.id).then((value) {
        esito = value;
      });
    } catch (e) {
      esito = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = new ScrollController();
    setchecklastNotificheAll();
  }

  Future<void> accettaAmicizia(String data) async {
    await setAmicizia(data).then((value) {
      if (value == 1) {
        setState(() {});
      }
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
              body: caricamento
                  ? SingleChildScrollView(
                      controller: controller,
                      child: ListBody(children: [
                        SizedBox(
                          height: 4.0.h,
                        ),
                        for (var i = 0; i < listaNotifiche.listaNotifiche.length; i++)
                          Container(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Container(
                                  child: Text(listaNotifiche.listaNotifiche[i].corpo),
                                  width: listaNotifiche.listaNotifiche[i].data != null ? 65.0.w : 90.0.w,
                                ),
                                if (listaNotifiche.listaNotifiche[i].data != null)
                                  Container(
                                      width: 20.0.w,
                                      child: TextButton(
                                          style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                                          onPressed: () {
                                            accettaAmicizia(listaNotifiche.listaNotifiche[i].data);
                                          },
                                          child: Text("Accetta")))
                              ],
                            ),
                          ),
                      ]))
                  : Loader(),
            ),
          ));
        });
  }
}
