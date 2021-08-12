import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color viola = Color(0xFF102d77);
const Color arancione = Color(0xFF2274D4);
final myAppBar = makeMyAppBar;
final showdialog = _showMaterialDialog;

PreferredSizeWidget makeMyAppBar({bool automaticallyImplyLeading = true, void Function() onBack}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    leading: automaticallyImplyLeading ? null : IconButton(icon: Icon(Icons.arrow_back), onPressed: onBack),
    centerTitle: true,
    backgroundColor: viola,
    title: Text("LoGioca"),
  );
}

class Loader extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(arancione)),
    );
  }
}

_showMaterialDialog(BuildContext context, String titolo, String message) {
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text(titolo),
            content: new Text(message),
          ));
}

String trimNull(String v) {
  return (v ?? "").trim();
}
