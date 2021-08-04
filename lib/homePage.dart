import 'package:flutter/material.dart';
import 'package:logioca/main.dart';
import 'package:logioca/models/evento.dart';
import 'package:logioca/pageContainer.dart';
import 'package:logioca/pageCreaSquadre.dart';
import 'package:logioca/pageDettagli.dart';
import 'package:logioca/pageMappa.dart';
import 'package:logioca/pageVoto.dart';
import 'package:sizer/sizer.dart';
import 'api.dart';
import 'common.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ListaEventi listaEventi;
  bool caricamento;

  @override
  void initState() {
    caricamento = false;
    super.initState();
  }

  Future<ListaEventi> setListaEventi() async {
    await getEventi(utente.id).then((value) {
      listaEventi = value;
      caricamento = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListaEventi>(
        future: setListaEventi(),
        builder: (context, AsyncSnapshot<ListaEventi> snapshot) {
          return caricamento
              ? Container(
                  key: Key(DateTime.now().toIso8601String()),
                  child: RefreshIndicator(
                      color: arancione,
                      onRefresh: () {
                        setState(() {});
                      },
                      child: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            if (listaEventi != null)
                              if (listaEventi.listaEventi.length > 0)
                                for (var i = 0; i < listaEventi.listaEventi.length; i++)
                                  Container(
                                      child: CardEvent(Evento(
                                          id: listaEventi.listaEventi[i].id,
                                          data: listaEventi.listaEventi[i].data,
                                          idCreatore: listaEventi.listaEventi[i].idCreatore,
                                          creatore: listaEventi.listaEventi[i].creatore,
                                          luogo: listaEventi.listaEventi[i].luogo,
                                          pathImage: listaEventi.listaEventi[i].pathImage,
                                          dataPartecipa: listaEventi.listaEventi[i].dataPartecipa,
                                          titolo: listaEventi.listaEventi[i].titolo,
                                          Latitudine: listaEventi.listaEventi[i].Latitudine,
                                          Longitudine: listaEventi.listaEventi[i].Longitudine)))
                              else
                                Container(padding: EdgeInsets.all(32), child: Text("nessun evento disponibile!"))
                          ],
                        ),
                      )))
              : Loader();
        });
  }
}

class CardEvent extends StatefulWidget {
  CardEvent(this.evento, {Key key}) : super(key: key);

  final Evento evento;
  @override
  _CardEventState createState() => _CardEventState();
}

class _CardEventState extends State<CardEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0.w),
      width: double.infinity,
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: 25.0.h,
              width: double.infinity,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/Img_sport_calcio.png"), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
            widget.evento.idCreatore == utente.id
                ? DateTime.now().isBefore(widget.evento.data)
                    ? creaSquadre(widget.evento)
                    : statistiche(widget.evento)
                : dettagli(widget.evento),
            infoEvento(widget.evento),
          ]),
          SizedBox(
            width: double.infinity,
            height: 7.0.h,
            child: DateTime.now().isBefore(widget.evento.data) && widget.evento.dataPartecipa == null
                ? bottoneDisponibile(widget.evento)
                : DateTime.now().isBefore(widget.evento.data) && widget.evento.dataPartecipa != null
                    ? bottoneElimina(widget.evento)
                    : bottoneVota(widget.evento),
          ),
        ],
      ),
    );
  }

  bottoneDisponibile(Evento evento) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              side: BorderSide(color: Colors.black))),
      onPressed: () {
        setPartecipa(utente.id, evento.id).then((value) {
          setState(() {
            evento.dataPartecipa = DateTime.now();
          });
        });
      },
      child: Text("Disponibile a giocare", style: TextStyle(fontSize: 5.0.w, color: Colors.green)),
    );
  }

  bottoneElimina(Evento evento) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: arancione,
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          //side: BorderSide(color: Colors.black),
        ),
      ),
      onPressed: () {
        eliminaPartecipa(utente.id, evento.id).then((value) {
          setState(() {
            evento.dataPartecipa = null;
          });
        });
      },
      child: Text("Elimina partecipazione", style: TextStyle(fontSize: 5.0.w, color: Colors.white)),
    );
  }

  bottoneVota(Evento evento) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF8FC1FA),
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          //side: BorderSide(color: Colors.black),
        ),
      ),
      onPressed: () {
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageVoto(evento)));
      },
      child: Text("Vota i giocatori", style: TextStyle(fontSize: 5.0.w, color: Colors.white)),
    );
  }

  dettagli(Evento evento) {
    return Positioned(
      top: 1.0.h,
      right: 0,
      child: TextButton(
          onPressed: () {
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageDettagli(evento)));
          },
          style: TextButton.styleFrom(
            alignment: Alignment.topRight,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
            child: Text(
              "Dettagli",
              style: TextStyle(
                fontSize: 16,
                color: viola,
              ),
            ),
          )),
    );
  }

  creaSquadre(Evento evento) {
    return Positioned(
      top: 1.0.h,
      right: 0,
      child: TextButton(
          onPressed: () {
            /*getPartecipanti(8, 1).then((value) {
              print(value);
            });
            getEvento(8, 1).then((value) {
              print(value);
            });*/
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageCreaSquadre(evento, context)));
          },
          style: TextButton.styleFrom(
            alignment: Alignment.topRight,
            backgroundColor: arancione,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
            child: Text("Crea squadre",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                )),
          )),
    );
  }

  statistiche(Evento evento) {
    return Positioned(
      top: 1.0.h,
      right: 0,
      child: TextButton(
          onPressed: () {
            /*getPartecipanti(8, 1).then((value) {
              print(value);
            });
            getEvento(8, 1).then((value) {
              print(value);
            });*/
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageCreaSquadre(evento, context)));
          },
          style: TextButton.styleFrom(
            alignment: Alignment.topRight,
            backgroundColor: arancione,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
            child: Text("inserisci statistiche",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                )),
          )),
    );
  }

  infoEvento(Evento evento) {
    return Positioned(
      top: 2.0.h,
      left: 2.0.w,
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.create,
                color: Colors.white,
              ),
              SizedBox(
                height: 2.0.w,
              ),
              Text(evento.creatore, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 4.0.w))
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              SizedBox(
                height: 2.0.w,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (BuildContext context) => new PageMappa(evento.Latitudine, evento.Longitudine)));
                  },
                  child: Text(evento.luogo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 4.0.w)))
            ],
          ),
          SizedBox(
            height: 11.0.h,
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              SizedBox(
                height: 2.0.w,
              ),
              Text(evento?.titolo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 4.0.w))
            ],
          )
        ],
      )),
    );
  }
}
