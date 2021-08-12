import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logioca/classifica.dart';
import 'package:logioca/homePage.dart';
import 'package:logioca/main.dart';
import 'package:logioca/pageCerca.dart';
import 'package:logioca/pageEvento.dart';
import 'package:logioca/pageNotifiche.dart';
import 'package:logioca/pageProfilo.dart';
import 'package:sizer/sizer.dart';
import 'api.dart';
import 'common.dart';

bool globalCheckNotifiche = false;

class PageContainer extends StatefulWidget {
  int index;
  PageContainer({this.index});
  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  @override
  PageController _myPage;
  var selectedPage;
  bool checkNotifiche = false;

  @override
  void initState() {
    super.initState();
    if (widget.index == null) {
      _myPage = PageController(initialPage: 1);
      selectedPage = 1;
    } else {
      _myPage = PageController(initialPage: widget.index);
      selectedPage = widget.index;
    }
  }

  Future<void> getchecklastNotificheAll() async {
    try {
      await getlastNotifica(utente.id).then((value) {
        if (value != checkNotifiche) {
          setState(() {
            checkNotifiche = value;
          });
        }
      });
    } catch (e) {
      checkNotifiche = false;
    }
  }

  Widget build(BuildContext context) {
    getchecklastNotificheAll();
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: viola,
              centerTitle: true,
              leading: IconButton(
                padding: EdgeInsets.only(left: 5.0.w),
                icon:
                    !checkNotifiche ? Image.asset("assets/images/icon_notificaOff.png") : Image.asset("assets/images/Icon_notificaOn.png"),
                onPressed: () {
                  getchecklastNotificheAll();
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageNotifiche()));
                },
              ),
              title: Text("LoGioca"),
            ),
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _myPage,
              children: <Widget>[
                Center(
                  child: Text("Another Page"),
                ),
                Center(
                  child: /*Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[*/
                      new HomePage(),
                  //],
                ), //),

                //Center(child: Text("Page 3")),
                Center(child: new PageClassifica()),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new PageCerca(),
                  ],
                )),
                Center(child: new PageProfilo(utente.id)),
              ],
            ),
            floatingActionButton: selectedPage == 1
                ? FloatingActionButton(
                    elevation: 5.0,
                    backgroundColor: Color(0xFF0756b1),
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PageEvento()));
                    },
                    tooltip: 'crea evento',
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  )
                : null,
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      "assets/images/home.png",
                      color: selectedPage == 1 ? arancione : viola,
                    ),
                    onPressed: () {
                      _myPage.jumpToPage(1);
                      setState(() {
                        selectedPage = 1;
                      });
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/images/classifica.png",
                      color: selectedPage == 2 ? arancione : viola,
                    ),
                    onPressed: () {
                      _myPage.jumpToPage(2);
                      setState(() {
                        selectedPage = 2;
                      });
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/images/icona_cerca.png",
                      color: selectedPage == 3 ? arancione : viola,
                    ),
                    onPressed: () {
                      _myPage.jumpToPage(3);
                      setState(() {
                        selectedPage = 3;
                      });
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/images/profilo.png",
                      color: selectedPage == 4 ? arancione : viola,
                    ),
                    onPressed: () {
                      _myPage.jumpToPage(4);
                      setState(() {
                        selectedPage = 4;
                      });
                    },
                  ),
                ],
              ),
            )));
  }
}
