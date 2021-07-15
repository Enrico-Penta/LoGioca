import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/api.dart';
import 'package:logioca/common.dart';
import 'package:logioca/main.dart';
import 'package:logioca/models/giocatore.dart';
import 'package:logioca/models/utente.dart';
import 'package:logioca/pageContainer.dart';
import 'package:logioca/pageProfilo.dart';
import 'package:logioca/pageProfiloUtente.dart';
import 'package:sizer/sizer.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

class PageClassifica extends StatefulWidget {
  PageClassifica({Key key}) : super(key: key);

  @override
  _PageClassificaState createState() => _PageClassificaState();
}

class _PageClassificaState extends State<PageClassifica> {
  bool caricamento = false;
  ScrollController controller;
  ListaGiocatori listaGiocatori;

  Future<ListaGiocatori> getClassificaAll() async {
    await getClassifica(1).then((value) {
      listaGiocatori = value;

      caricamento = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListaGiocatori>(
        future: getClassificaAll(),
        builder: (context, AsyncSnapshot<ListaGiocatori> snapshot) {
          return caricamento
              ? Center(
                  child: LazyDataTable(
                    rows: listaGiocatori.listaGiocatori.length,
                    columns: 5,
                    tableTheme: LazyDataTableTheme(
                      cornerColor: arancione,
                      cornerBorder: Border(
                        bottom: BorderSide(color: viola, width: 1.5),
                        right: BorderSide(color: viola, width: 1.5),
                      ),
                      //
                      columnHeaderColor: arancione,
                      columnHeaderBorder: Border(bottom: BorderSide(color: viola, width: 1.5)),
                      //
                      rowHeaderColor: Colors.white,
                      alternateRowHeaderColor: Colors.blue[50],
                      rowHeaderBorder: Border(right: BorderSide(color: viola, width: 1.5)),
                      alternateRowHeaderBorder: Border(right: BorderSide(color: viola, width: 1.5)),
                      //
                      cellBorder: Border.fromBorderSide(BorderSide.none),
                      alternateCellBorder: Border.fromBorderSide(BorderSide.none),
                      //
                      cellColor: Colors.white, //Colors.blue[100],
                      alternateCellColor: Colors.blue[50],
                      //
                    ),
                    tableDimensions: LazyDataTableDimensions(
                      cellHeight: 50,
                      cellWidth: 17.0.w,
                      topHeaderHeight: 5.0.h,
                      leftHeaderWidth: 50.0.w,
                    ),
                    topHeaderBuilder: (i) => Center(
                        child: Text(
                      i == 0
                          ? "Magic Num"
                          : i == 1
                              ? "Presenze"
                              : i == 2
                                  ? "Gol Fatti"
                                  : i == 3
                                      ? "Media Voti"
                                      : i == 4
                                          ? "Vittorie"
                                          : i,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
                    leftHeaderBuilder: (i) => Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 2.0.w),
                        Text(
                          "${i + 1}.",
                          style: TextStyle(
                              color: listaGiocatori.listaGiocatori[i].idUser == utente.id ? Colors.blue : viola,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 2.0.w),
                        GestureDetector(
                          onTap: () {
                            listaGiocatori.listaGiocatori[i].idUser != utente.id
                                ? Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) => new PageProfiloUtente(listaGiocatori.listaGiocatori[i].idUser)))
                                : Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) => new PageContainer(
                                              index: 2,
                                            )));
                          },
                          child: Text(
                            "${listaGiocatori.listaGiocatori[i].nome} ${listaGiocatori.listaGiocatori[i].cognome}",
                            style: TextStyle(color: listaGiocatori.listaGiocatori[i].idUser == utente.id ? Colors.blue : viola),
                          ),
                        ),
                      ],
                    )),
                    dataCellBuilder: (i, j) => Center(
                        child: Text(
                      valoreGiocatore(listaGiocatori.listaGiocatori[i], j),
                      style: TextStyle(
                          color: listaGiocatori.listaGiocatori[i].idUser == utente.id ? Colors.blue : viola, fontWeight: FontWeight.bold),
                    )),
                    topLeftCornerWidget: Center(
                        child: Text(
                      "Giocatori",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                )
              : Loader();
        });
  }

  String valoreGiocatore(Giocatore g, int j) {
    switch (j) {
      case 0:
        return g.magicNumber.toString();
      case 1:
        return g.presenze.toString();
      case 2:
        return g.golFatti.toString();
      case 3:
        return g.mediaVoti.toString();
      case 4:
        return g.vittorie.toString();
    }
  }
}
