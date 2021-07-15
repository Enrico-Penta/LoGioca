import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logioca/widgets/fields.dart';
import 'package:sizer/sizer.dart';
import 'common.dart';

class PageRecuperoPsw extends StatefulWidget {
  @override
  _PageRecuperoPswState createState() => _PageRecuperoPswState();
}

class _PageRecuperoPswState extends State<PageRecuperoPsw> {
  String email;
  bool caricamento;
  @override
  void initState() {
    email = "";
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
                  Text("Hai dimenticato la password?\n", style: TextStyle(fontSize: 4.5.w), textAlign: TextAlign.left),
                  //Text("No Problem!", style: TextStyle(fontSize: 7.0.w, fontWeight: FontWeight.bold)),
                  Text("Scrivi la tua email per ricevere il link per il reset.", style: TextStyle(fontSize: 4.0.w)),
                  MyTextField(["Email"], initialValue: this.email, setField: (value) {
                    this.email = value;
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
