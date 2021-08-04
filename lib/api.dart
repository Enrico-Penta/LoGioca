import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:logioca/models/evento.dart';
import 'package:logioca/models/notifica.dart';
import 'package:logioca/models/utente.dart';

import 'models/giocatore.dart';
import 'models/partecipanti.dart';

Future<Utente> doLogin(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/User/Login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'Email': email, 'Password': password}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Utente.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<String> doRegistrazione(String email, String password, String nome, String cognome, DateTime dataNascita) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/User/Register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'Email': email, 'Password': password, 'Nome': nome, 'Cognome': cognome, 'DataNascita': dataNascita.toString()}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var js = jsonDecode(response.body);
    if (js['data'] != null) {
      Map<String, dynamic> resp = jsonDecode(js['data']);
      if (resp['Output']['Messaggi'] == null) {
        return "ok";
      } else {
        return resp['Output']['Messaggi'];
      }
    } else {
      return "Errore di connessione";
    }
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return "Errore di connessione";
  }
}

Future<ListaEventi> getEventi(int idUser) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/evento/getByUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{'IdUser': idUser, 'IdEvento': 0}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return ListaEventi.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<Partecipanti> getPartecipanti(int idUser, int idEvento) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/evento/partecipanti'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{'IdUser': idUser, 'IdEvento': idEvento}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Partecipanti.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<Partecipante> getEvento(int idUser, int idEvento) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/evento/get'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'IdUser': idUser,
      'IdEvento': idEvento,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Partecipante.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<ListaGiocatori> getRicerca(int idUser, String parola) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/giocatore/Search'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{'IdUser': idUser, 'search': parola}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return ListaGiocatori.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<int> setEvento(int idUser, DateTime data, int durata, String luogo, LatLng gps) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/Evento/Create'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'IdUser': idUser.toString(),
      'Data': data.toString(),
      'Durata': 60.toString(),
      'Luogo': luogo,
      'Sport': '1',
      'Privacy': 'SA',
      'Latitudine': gps.latitude.toString(),
      'Longitudine': gps.longitude.toString()
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return 1;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return 0;
  }
}

Future<int> setPartecipa(int idUser, int idEvento) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/Evento/Partecipa'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'IdUser': idUser.toString(), 'IdEvento': idEvento.toString(), 'Aggiungi': '1'}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return 1;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return 0;
  }
}

Future<int> setSquadra(int idUser, int idEvento, int idSquadra) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/Evento/Partecipa'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'IdUser': idUser.toString(), 'IdEvento': idEvento.toString(), 'Aggiungi': '1', 'IdSquadra': idSquadra.toString()}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return 1;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return 0;
  }
}

Future<int> deleteFromSquadra(int idUser, int idEvento, int idSquadra) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/Evento/Partecipa'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'IdUser': idUser.toString(), 'IdEvento': idEvento.toString(), 'Aggiungi': '1', 'IdSquadra': null}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return 1;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return 0;
  }
}

Future<int> eliminaPartecipa(int idUser, int idEvento) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/Evento/Partecipa'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'IdUser': idUser.toString(), 'IdEvento': idEvento.toString(), 'Elimina': '1'}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return 1;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return 0;
  }
}

Future<int> inviaRichiesta(int idUser, int idUserDest) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/user/amicizia/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'IdUser': idUser.toString(), 'IdUserDest': idUserDest.toString(), 'IdLivelloAmicizia': 'AM'}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return 1;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return 0;
  }
}

Future<UtenteProfilo> getUtente(int idUser) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/User/GetUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{'idUser': idUser}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return UtenteProfilo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<String> setVoto(int idUser, int idEvento, int idGiocatore, String voto) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/giocatore/SetGiudizio'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'IdUser': idUser.toString(),
      'IdEvento': idEvento.toString(),
      'IdGiocatore': idGiocatore.toString(),
      'Voto': voto
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return "";
  }
}

Future<ListaGiocatori> getClassifica(int idSport) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/campionato/classifica'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{'IdSport': idSport}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return ListaGiocatori.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<ListaGiocatori> getAmici(int idUser) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/User/getamici'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{'IdUser': idUser}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return ListaGiocatori.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<ListaNotifiche> getNotifiche(int idUser) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/notifica/getNotifica'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{'idUser': idUser}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return ListaNotifiche.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<int> setAmicizia(String data) async {
  final response = await http.post(
    Uri.parse('https://logiocarest.azurewebsites.net/user/amicizia/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: data,
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return 1;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return 0;
  }
}

Future<LocationData> getLoc() async {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Location location = Location();

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      throw new Exception("Servizio Location non abilitato");
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      throw new Exception("Servizio Location permesso negato");
    }
  }

  return await location.getLocation();
}
