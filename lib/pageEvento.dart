import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logioca/api.dart';
import 'package:logioca/main.dart';
import 'package:logioca/models/evento.dart';
import 'package:logioca/pageContainer.dart';
import 'package:logioca/widgets/fields.dart';
import 'package:sizer/sizer.dart';
import 'common.dart';
import 'package:google_place/google_place.dart' as go;

class PageEvento extends StatefulWidget {
  @override
  _PageEventoState createState() => _PageEventoState();
}

class _PageEventoState extends State<PageEvento> {
  final _formKey = GlobalKey<FormState>();
  Evento evento = new Evento();
  DateTime data;
  LatLng coordinate;
  String luogo;
  List<go.AutocompletePrediction> predictions = [];
  go.GooglePlace googlePlace;

  void autoCompletePosition(String value) async {
    if (value.contains(",")) {
      googlePlace = go.GooglePlace(geocodingApiKey);
      var result = await googlePlace.autocomplete.get(value, language: 'it' /*, types: 'food'*/);
      if (result != null && result.predictions != null && mounted) {
        //setState(() {
        predictions = result.predictions;
        //});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: Scaffold(
                appBar: myAppBar(),
                body: Form(
                    key: _formKey,
                    child: Column(children: [
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
                      /*MyTextField(["Luogo"], initialValue: luogo, setField: (value) {
                    luogo = value;
                  }),*/
                      MyTypeAheadPositionField(
                        ["Luogo", "via, numero, comune, provincia"],
                        initialPos: coordinate,
                        initialValue: luogo,
                        hint: luogo == null ? 'selezionare dalla lista' : luogo,
                        suggestionsCallback: (pattern) {
                          if (trimNull(pattern).isNotEmpty) {
                            autoCompletePosition(pattern);
                            return predictions.map((f) => f.description);
                          } else {
                            return [];
                          }
                        },
                        onlySelected: false,
                        setField: (gps, address) {
                          coordinate = gps;
                          luogo = address;
                        },
                      ),
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
                              _formKey.currentState.save();
                              if (_formKey.currentState.validate()) {
                                setEvento(utente.id, data, 60, luogo, coordinate).then((value) {
                                  if (value == 1) {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => PageContainer()));
                                  }
                                });
                              } else {}
                            },
                            child: Text(
                              "Salva",
                              style: TextStyle(color: Colors.white, fontSize: 5.0.w, fontWeight: FontWeight.w400),
                            ),
                          )),
                    ])))));
  }
}
