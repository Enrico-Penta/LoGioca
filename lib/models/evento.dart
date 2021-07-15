import 'dart:convert';

import 'package:flutter/foundation.dart';

class Evento {
  int id;
  DateTime data;
  DateTime dataPartecipa;
  int idCreatore;
  String creatore;
  String luogo;
  String pathImage;
  String titolo;

  Evento({this.id, this.data, this.dataPartecipa, this.idCreatore, this.creatore, this.luogo, this.pathImage, this.titolo});

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
        id: json['Id'],
        data: DateTime.parse(json['Data']),
        dataPartecipa: json['DataPartecipa'] != null ? DateTime.parse(json['DataPartecipa']) : null,
        luogo: json['LabelLuogo'],
        creatore: json['NomeCreatore'] + " " + json["CognomeCreatore"],
        idCreatore: json['IdUserIns'],
        titolo: json['Titolo'] != null ? json['Titolo'] as String : "");
  }
}

class ListaEventi {
  List<Evento> listaEventi;

  ListaEventi({this.listaEventi});

  ListaEventi.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      Map<String, dynamic> resp = jsonDecode(json['data']);
      listaEventi = [];
      resp['DataSet'].forEach((v) {
        v.forEach((y) {
          listaEventi.add(Evento.fromJson(y));
        });
      });
    }
  }
}
