import 'dart:convert';

//import 'dart:ffi';

class Giocatore {
  int id;
  int idUser;
  String email;
  String nome;
  String cognome;
  String idLivelloAmicizia;
  double magicNumber;
  int presenze;
  int golFatti;
  double mediaVoti;
  int vittorie;
  int mvp;

  Giocatore(
      {this.id,
      this.idUser,
      this.email = "",
      this.nome,
      this.cognome = '',
      this.idLivelloAmicizia,
      this.magicNumber,
      this.golFatti,
      this.mediaVoti,
      this.presenze,
      this.vittorie,
      this.mvp});

  factory Giocatore.fromJson(Map<String, dynamic> json) {
    return Giocatore(
        id: json['Id'],
        idUser: json['IdUser'],
        email: json['Email'],
        nome: json['Nome'],
        cognome: json['Cognome'],
        idLivelloAmicizia: json['IdLivelloAmicizia'],
        magicNumber: json['MagicNumber'],
        presenze: json['Presenze'],
        golFatti: json['Goal'],
        mediaVoti: json['MediaVoti'],
        vittorie: json['Vittorie'],
        mvp: json['BestPlayer']);
  }
}

class ListaGiocatori {
  List<Giocatore> listaGiocatori;

  ListaGiocatori({this.listaGiocatori});

  ListaGiocatori.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      Map<String, dynamic> resp = jsonDecode(json['data']);
      listaGiocatori = [];
      resp['DataSet'].forEach((v) {
        v.forEach((y) {
          listaGiocatori.add(Giocatore.fromJson(y));
        });
      });
    }
  }
}
