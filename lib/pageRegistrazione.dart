import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/api.dart';
import 'package:logioca/widgets/fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'common.dart';

class PageRegistrazione extends StatefulWidget {
  @override
  _PageRegistrazioneState createState() => _PageRegistrazioneState();
}

class _PageRegistrazioneState extends State<PageRegistrazione> {
  String email;
  String password;
  String nome;
  String cognome;
  bool caricamento;
  DateTime dataNascita;
  bool registrato = false;
  @override
  void initState() {
    email = "";
    password = "";
    nome = "";
    cognome = "";
    caricamento = false;
    super.initState();
  }

  Future<void> setLocalStorageAfterreg(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<void> registrati(BuildContext context) async {
    await doRegistrazione(email, password, nome, cognome, dataNascita).then((value) {
      if (value.toString() == "ok") {
        setLocalStorageAfterreg(email, password);
        setState(() {
          registrato = true;
        });
      } else {
        showdialog(context, "Attenzione", value);
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: myAppBar(),
          body: ListView(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.0.h),
                child: !registrato
                    ? Column(children: [
                        Text("Registrazione\n", style: TextStyle(fontSize: 4.5.w), textAlign: TextAlign.left),
                        MyTextField(["Email"], setField: (value) {
                          this.email = value;
                        }),
                        MyTextField(["Password"], setField: (value) {
                          this.password = value;
                        }),
                        MyTextField(["Nome"], setField: (value) {
                          this.nome = value;
                        }),
                        MyTextField(["Cognome"], setField: (value) {
                          this.cognome = value;
                        }),
                        MyDateTimeField(["Data di nascita"],
                            mode: DateTimeFieldPickerMode.date, initialMode: DatePickerMode.day, initialValue: dataNascita, setField: (d) {
                          dataNascita = d;
                        }),
                        !caricamento
                            ? Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 3.5.h, horizontal: 4.0.w),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(1.0.h),
                                      backgroundColor: viola,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                                  child: Text("INVIA"),
                                  onPressed: () {
                                    registrati(context);
                                  },
                                ),
                              )
                            : Loader()
                      ])
                    : Container(
                        padding: EdgeInsets.all(16),
                        child: Text("Grazie per aver effettuato la registrazione, torna indietro ed effettua il Login."),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
