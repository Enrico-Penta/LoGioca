import 'package:flutter/material.dart';
import 'package:logioca/common.dart';
import 'package:logioca/models/giocatore.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class Sport {
  bool dettagliVisibili = true;
}

class TendinaSport extends StatefulWidget {
  final Sport calcio;
  ScrollController controller;
  Giocatore giocatore;

  TendinaSport(this.calcio, this.controller, this.giocatore, {key}) : super(key: key);

  @override
  _TendinaSportState createState() => _TendinaSportState();
}

class _TendinaSportState extends State<TendinaSport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(DateTime.now().toIso8601String()),
      //height: widget.dealer.detailVisbility ? 34.0.h : 12.0.h,
      padding: EdgeInsets.symmetric(horizontal: 7.7.w, vertical: 2.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            //mainAxisSize: MainAxisSize.max,
            children: [
              Image(
                image: AssetImage("assets/images/Icon_sportCalcetto.png"),
                width: 6.0.w,
              ),
              Container(
                  padding: EdgeInsets.only(left: 2.0.w),
                  width: 18.0.w,
                  child: Text(
                    "Calcio",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              widget.calcio.dettagliVisibili == false
                  ? IconButton(
                      icon: Image(
                        width: 4.0.w,
                        image: AssetImage("assets/images/iconaFreccetta.png"),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.controller
                              .animateTo(widget.controller.offset + 300, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                          mostraDettagli(widget.calcio);
                        });
                      })
                  : Transform.rotate(
                      angle: 180 * math.pi / 180,
                      child: IconButton(
                        icon: Image(
                          width: 4.0.w,
                          image: AssetImage("assets/images/iconaFreccetta.png"),
                        ),
                        onPressed: () {
                          //closeDetailDealer(widget.dealer);
                          setState(() {
                            chiudiDettagli(widget.calcio);
                          });
                        },
                      ),
                    ),
            ],
          ),
          widget.calcio.dettagliVisibili
              ? Container(
                  child: Container(
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
                    padding: EdgeInsets.all(7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(children: [
                              Container(
                                  width: 22.0.w,
                                  padding: EdgeInsets.only(bottom: 1.0.h),
                                  child: Text(
                                    "Partite giocate",
                                    textAlign: TextAlign.center,
                                  )),
                              Text(
                                widget.giocatore.presenze.toString(),
                                style: TextStyle(fontSize: 28, color: arancione),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                  width: 22.0.w,
                                  padding: EdgeInsets.only(bottom: 1.0.h),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Goal",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "segnati",
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )),
                              Text(
                                widget.giocatore.golFatti.toString(),
                                style: TextStyle(fontSize: 28, color: arancione),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                  width: 22.0.w,
                                  padding: EdgeInsets.only(bottom: 1.0.h),
                                  child: Text(
                                    "Magic number",
                                    textAlign: TextAlign.center,
                                  )),
                              Text(
                                widget.giocatore.magicNumber.toString(),
                                style: TextStyle(fontSize: 28, color: arancione),
                              ),
                            ]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(children: [
                              Container(
                                  width: 22.0.w,
                                  padding: EdgeInsets.only(bottom: 1.0.h),
                                  child: Text(
                                    "Vittorie",
                                    textAlign: TextAlign.center,
                                  )),
                              Text(
                                widget.giocatore.vittorie.toString(),
                                style: TextStyle(fontSize: 28, color: arancione),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                  width: 22.0.w,
                                  padding: EdgeInsets.only(bottom: 1.0.h),
                                  child: Text(
                                    "Media voti",
                                    textAlign: TextAlign.center,
                                  )),
                              Text(
                                widget.giocatore.mediaVoti.toString(),
                                style: TextStyle(fontSize: 28, color: arancione),
                              ),
                            ]),
                            Column(children: [
                              Container(
                                  width: 22.0.w,
                                  padding: EdgeInsets.only(bottom: 1.0.h),
                                  child: Text(
                                    "Mvp",
                                    textAlign: TextAlign.center,
                                  )),
                              Text(
                                widget.giocatore.mvp.toString(),
                                style: TextStyle(fontSize: 28, color: arancione),
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
              : Container(
                  child: SizedBox(),
                ),
        ],
      ),
    );
  }

  void mostraDettagli(Sport calcio) {
    setState(() {
      calcio.dettagliVisibili = true;
    });
  }

  void chiudiDettagli(Sport calcio) {
    setState(() {
      calcio.dettagliVisibili = false;
    });
  }
}
