import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/api.dart';
import 'package:logioca/main.dart';
import 'package:logioca/models/evento.dart';
import 'package:logioca/pageContainer.dart';
import 'package:logioca/widgets/fields.dart';
import 'package:sizer/sizer.dart';
import 'common.dart';

class PageEvento extends StatefulWidget {
  @override
  _PageEventoState createState() => _PageEventoState();
}

class _PageEventoState extends State<PageEvento> {
  Evento evento = new Evento();
  DateTime data;
  String luogo;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: Scaffold(
                appBar: myAppBar(),
                body: Column(children: [
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Text(
                    "NUOVO EVENTO",
                    style: TextStyle(fontSize: 6.0.w, color: viola, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  MyDateTimeField(["Data evento"],
                      mode: DateTimeFieldPickerMode.dateAndTime, initialMode: DatePickerMode.day, initialValue: data, setField: (d) {
                    data = d;
                  }),
                  MyTextField(["Luogo"], initialValue: luogo, setField: (value) {
                    luogo = value;
                  }),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  //bottone
                  Container(
                      padding: EdgeInsets.all(4.0.w),
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          padding: EdgeInsets.all(1.0.h),
                          backgroundColor: Color(0xFF2F267A),
                        ),
                        onPressed: () {
                          setEvento(utente.id, data, 60, luogo).then((value) {
                            if (value == 1) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => PageContainer()));
                            }
                          });
                        },
                        child: Text(
                          "Salva",
                          style: TextStyle(color: Colors.white, fontSize: 5.0.w, fontWeight: FontWeight.w400),
                        ),
                      )),
                ]))));
  }
}
