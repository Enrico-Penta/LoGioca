import 'dart:convert';

class Partecipante {
  int idUser;
  int idGiocatore;
  String nome;
  String cognome;
  int idSquadra;
  String mediaVoti;
  String mioVoto;

  Partecipante({this.idUser, this.idGiocatore, this.nome, this.cognome, this.idSquadra, this.mediaVoti, this.mioVoto});

  factory Partecipante.fromJson(Map<String, dynamic> json) {
    return Partecipante(
        idUser: json['IdUser'],
        idGiocatore: json['IdGiocatore'],
        nome: json['Nome'],
        cognome: json['Cognome'],
        idSquadra: json['IdSquadra'],
        mediaVoti: json['MediaVoti'],
        mioVoto: json['MioVoto']);
  }
}

class Partecipanti {
  List<Partecipante> listaPartecipanti;

  Partecipanti({this.listaPartecipanti});
  Partecipanti.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      Map<String, dynamic> resp = jsonDecode(json['data']);
      listaPartecipanti = [];
      resp['DataSet'].forEach((v) {
        v.forEach((y) {
          listaPartecipanti.add(Partecipante.fromJson(y));
        });
      });
    }
  }
}
