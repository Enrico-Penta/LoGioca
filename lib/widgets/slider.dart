import 'package:flutter/material.dart';
import 'package:logioca/models/giocatore.dart';
import 'package:logioca/pageProfiloUtente.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../main.dart';
import '../pageContainer.dart';

class NoonLoopingDemo extends StatelessWidget {
  ListaGiocatori listaAmici;
  NoonLoopingDemo(this.listaAmici);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 15.0.h,
        width: 100.0.w,
        child: CarouselSlider(
          options: CarouselOptions(
            //aspectRatio: 2.0,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            pageSnapping: false,
            initialPage: 1,
            /*listaAmici.listaGiocatori.length > 1 ? 2 : 1,*/
            viewportFraction: 0.3,
            autoPlay: false,
          ),
          items: [
            for (var i = 0; i < listaAmici.listaGiocatori.length; i++)
              Column(children: [
                GestureDetector(
                  onTap: () {
                    listaAmici.listaGiocatori[i].idUser != utente.id
                        ? Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => new PageProfiloUtente(
                                      listaAmici.listaGiocatori[i].idUser,
                                      //indexSlider: i,
                                    )))
                        : Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => new PageContainer(
                                      index: 4,
                                    )));
                    ;
                  },
                  child: CircleAvatar(
                    radius: 34.0,
                    backgroundImage: AssetImage("assets/images/utenteIncognito.png"),
                  ),
                ),
                Container(
                  width: 20.0.w,
                  child: Column(
                    children: [
                      Text(
                        "${listaAmici.listaGiocatori[i].nome}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${listaAmici.listaGiocatori[i].cognome}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ])
          ],
        ));
  }
}
