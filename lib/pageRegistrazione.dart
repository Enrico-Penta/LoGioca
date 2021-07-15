import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/widgets/fields.dart';
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
  @override
  void initState() {
    email = "";
    password = "";
    nome = "";
    cognome = "";
    caricamento = false;
    super.initState();
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
                child: Column(children: [
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
                  !caricamento
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 3.5.h, horizontal: 4.0.w),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(1.0.h),
                              backgroundColor: Color(0xFF2F267A),
                            ),
                            onPressed: () {
                              setState(() {
                                caricamento = true;
                              });
                              //Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageContainer()));
                              //}),
                            },
                            child: Text(
                              "INVIA",
                              style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                            ),
                          ),
                        )
                      : Loader()
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
