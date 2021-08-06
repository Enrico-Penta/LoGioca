import 'dart:convert';

class Notifica {
  int id;
  String corpo;
  String data;
  String dataLettura;

  Notifica({this.id, this.corpo, this.data, this.dataLettura});

  factory Notifica.fromJson(Map<String, dynamic> json) {
    return Notifica(
      id: json['IdUser'],
      corpo: json['Corpo'],
      data: json['ContentAccetta'],
      dataLettura: json['DataLettura'],
    );
  }
}

class ListaNotifiche {
  List<Notifica> listaNotifiche;

  ListaNotifiche({this.listaNotifiche});
  ListaNotifiche.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      Map<String, dynamic> resp = jsonDecode(json['data']);
      listaNotifiche = [];
      resp['DataSet'].forEach((v) {
        v.forEach((y) {
          listaNotifiche.add(Notifica.fromJson(y));
        });
      });
    }
  }
}
