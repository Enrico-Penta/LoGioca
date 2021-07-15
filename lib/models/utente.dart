import 'dart:convert';

class Utente {
  int id;
  String email;
  String password;

  Utente({
    this.id,
    this.email,
    this.password,
  });

  factory Utente.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> resp = jsonDecode(json['data']);
    return Utente(
      id: resp['Output']['IdUser'],
    );
  }
}

class UtenteProfilo {
  int id;
  String email;
  String password;
  String nome;
  String cognome;
  int telefono;

  UtenteProfilo({
    this.id,
    this.email,
    this.password,
    this.nome,
    this.cognome,
    this.telefono,
  });

  factory UtenteProfilo.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> resp = jsonDecode(json['data']);
    return UtenteProfilo(
      id: resp['DataSet'][0][0]['IdUser'],
      nome: resp['DataSet'][0][0]['Nome'],
      cognome: resp['DataSet'][0][0]['Cognome'],
      email: resp['DataSet'][0][0]['Email'],
    );
  }
}
