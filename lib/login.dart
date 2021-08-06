import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/api.dart';
import 'package:logioca/common.dart';
import 'package:logioca/main.dart';
import 'package:logioca/pageContainer.dart';
import 'package:logioca/pageRecuperoPsw.dart';
import 'package:logioca/pageRegistrazione.dart';
import 'package:logioca/tutorial/pageTutorial.dart';
import 'package:logioca/widgets/fields.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool caricamento;
  bool tutorial;

  Future<void> setLocalStorage(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<void> getEmailUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      utente.email = prefs.getString('email') ?? '';
      utente.password = prefs.getString('password') ?? '';
      tutorial = prefs.getBool('LookTutorial') ?? true;
    });
  }

  @override
  void initState() {
    caricamento = false;
    tutorial = true;

    getEmailUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(DateTime.now().toIso8601String()),
      width: double.infinity,
      padding: EdgeInsets.all(5.0.h),
      child: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/logo.png"),
              color: viola,
            ),
            SizedBox(
              height: 2.0.h,
            ),
            MyTextField(["Email"], initialValue: utente.email, setField: (value) {
              utente.email = value;
            }),
            MyTextField(["Password"], initialValue: utente.password, obscureText: true, setField: (value) {
              utente.password = value;
            }),
            Container(
              //width: double.infinity,
              //padding: EdgeInsets.symmetric(vertical: 3.5.h, horizontal: 4.0.w),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageRecuperoPsw()));
                },
                child: Text(
                  "Hai dimenticato la password?",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 3.5.w, decoration: TextDecoration.underline),
                ),
              ),
            ),
            Container(
              //width: double.infinity,
              //padding: EdgeInsets.symmetric(vertical: 3.5.h, horizontal: 4.0.w),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageRegistrazione()));
                },
                child: Text(
                  "Non hai un account? Registrati!",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 3.5.w, decoration: TextDecoration.underline),
                ),
              ),
            ),
            !caricamento
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 3.5.h, horizontal: 4.0.w),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.all(1.0.h),
                          backgroundColor: viola,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                      onPressed: () {
                        setState(() {
                          caricamento = true;
                        });
                        doLogin(utente.email, utente.password).then((value) {
                          if (value.id != null) {
                            setLocalStorage(utente.email, utente.password);
                            utente.id = value.id;
                            tutorial
                                ? Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageTutorial()))
                                : Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageContainer()));
                          } else {
                            setState(() {
                              caricamento = false;
                            });
                            showdialog(context, "Attenzione", "Email o password non valide!");
                          }
                        });
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 5.0.w, fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                : Loader()
          ],
        )
      ]),
    );
  }
}
