import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common.dart';

class PageNotifiche extends StatefulWidget {
  @override
  _PageNotificheState createState() => _PageNotificheState();
}

class _PageNotificheState extends State<PageNotifiche> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: myAppBar(),
        ),
      ),
    );
  }
}
