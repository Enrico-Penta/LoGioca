import 'dart:async';

import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:sizer/sizer.dart';
import 'package:google_geocoding/google_geocoding.dart' as geo;
import '../api.dart';
import '../common.dart';
import '../main.dart';

EdgeInsets contentPadding = EdgeInsets.only(top: 0.4.h, bottom: 1.2.h);

final DateFormat itaDateFormatter = DateFormat('dd/MM/yyyy');

DateFormat formatDateTime(DateTimeFieldPickerMode mode) {
  switch (mode) {
    case DateTimeFieldPickerMode.date:
      return itaDateFormatter;
    case DateTimeFieldPickerMode.time:
      return DateFormat.Hm('it_IT');
    default:
      return DateFormat('dd/MM/yyyy HH:mm');
  }
}

Widget myField(List<String> labels, bool richiesto, Widget child, {bool dense = false}) {
  return new ListTile(
    contentPadding: EdgeInsets.symmetric(vertical: dense ? 0 : 0.8.h, horizontal: 4.0.w),
    dense: dense,
    title: (labels.length > 0)
        ? RichText(
            softWrap: true,
            text: TextSpan(
              text: labels[0],
              style: TextStyle(color: viola, fontFamily: 'ToyotaType Semibold', fontSize: 11.8.sp),
              children: <TextSpan>[
                if (labels.length > 1)
                  TextSpan(
                      text: " - ${labels[1]}",
                      style: TextStyle(color: Colors.black, fontFamily: 'ToyotaType Book', fontStyle: FontStyle.italic, fontSize: 11.8.sp)),
                if (!richiesto)
                  TextSpan(
                    text: " (facoltativo)",
                    style: new TextStyle(color: Colors.black, fontFamily: 'ToyotaType Book', fontSize: 8.6.sp),
                  ),
              ],
            ),
          )
        : null,
    subtitle: child,
    isThreeLine: false,
  );
}

Widget myFieldVoto(List<String> labels, bool richiesto, Widget child, {bool dense = false}) {
  return new ListTile(
    //contentPadding: EdgeInsets.symmetric(vertical: dense ? 0 : 4.0.h, horizontal: 4.0.w),
    dense: dense,
    title: (labels.length > 0)
        ? RichText(
            softWrap: true,
            text: TextSpan(
              text: labels[0],
              style: TextStyle(color: viola, fontFamily: 'ToyotaType Semibold', fontSize: 11.8.sp),
              children: <TextSpan>[
                if (labels.length > 1)
                  TextSpan(
                      text: " - ${labels[1]}",
                      style: TextStyle(color: Colors.black, fontFamily: 'ToyotaType Book', fontStyle: FontStyle.italic, fontSize: 11.8.sp)),
                if (!richiesto)
                  TextSpan(
                    text: " (facoltativo)",
                    style: new TextStyle(color: Colors.black, fontFamily: 'ToyotaType Book', fontSize: 8.6.sp),
                  ),
              ],
            ),
          )
        : null,
    subtitle: child,
    isThreeLine: false,
  );
}

class MyTextField extends StatefulWidget {
  final List<String> labels;
  final List<TextInputFormatter> formatters;
  final String hint;
  final String initialValue;
  final String errText;
  final Icons icon;
  bool obscureText;
  final bool richiesto;
  final bool isReadOnly;
  final bool multiline;
  final void Function(String) setField;
  final String Function(String) validator;
  final TextEditingController controller;

  MyTextField(this.labels,
      {this.formatters,
      this.hint,
      this.initialValue,
      this.errText,
      this.icon,
      this.obscureText = false,
      this.richiesto = true,
      this.isReadOnly = false,
      this.multiline = false,
      this.setField,
      this.controller,
      this.validator});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return myField(
      widget.labels,
      widget.richiesto,
      TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        enabled: !widget.isReadOnly,
        textCapitalization: TextCapitalization.none,
        inputFormatters: widget.formatters,
        obscureText: widget.obscureText,
        cursorColor: Colors.grey,
        style: TextStyle(
            fontFamily: 'ToyotaType Book',
            fontStyle: widget.isReadOnly ? FontStyle.italic : FontStyle.normal,
            fontSize: 11.7.sp,
            color: widget.isReadOnly ? Colors.black54 : Colors.black),
        enableSuggestions: false,
        decoration: widget.obscureText == true
            ? InputDecoration(
                contentPadding: EdgeInsets.only(top: 15.0),
                isDense: true,
                hintText: widget.hint,
                suffixIcon: TextButton(
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                        showPassword = true;
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: viola,
                    )),
              )
            : !showPassword
                ? InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15.0),
                    isDense: true,
                    hintText: widget.hint,
                  )
                : InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15.0),
                    isDense: true,
                    hintText: widget.hint,
                    suffixIcon: TextButton(
                        onPressed: () {
                          setState(() {
                            widget.obscureText = !widget.obscureText;
                            showPassword = true;
                          });
                        },
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: viola,
                        )),
                  ),

        onSaved: widget.isReadOnly ? null : widget.setField,
        onChanged: widget.setField,
        // onEditingComplete: () => print('onEditingComplete ${_controller.value}'),
        // onFieldSubmitted: (value) => print('onFieldSubmitted: $value'),
        maxLines: widget.multiline ? null : 1,
        keyboardType: widget.multiline ? TextInputType.multiline : TextInputType.text,
      ),
    );
  }
}

class MyDateTimeField extends StatelessWidget {
  final List<String> labels;
  final DateTimeFieldPickerMode mode;
  final DatePickerMode initialMode;
  final String hint;
  final String errText;
  final DateTime initialValue;
  final DateTime firstDate;
  final bool richiesto;
  final bool isReadOnly;
  final bool dense;
  final void Function(DateTime) setField;

  MyDateTimeField(this.labels,
      {this.mode = DateTimeFieldPickerMode.dateAndTime,
      this.initialMode = DatePickerMode.day,
      this.hint,
      this.errText,
      this.initialValue,
      this.firstDate,
      this.richiesto = true,
      this.dense = false,
      this.isReadOnly = false,
      @required this.setField});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'ToyotaType Book',
        fontStyle: isReadOnly ? FontStyle.italic : FontStyle.normal,
        fontSize: 11.7.sp,
        color: isReadOnly ? Colors.black54 : Colors.black);

    return myField(
      labels,
      richiesto,
      DateTimeFormField(
        key: Key(initialValue?.toIso8601String()),
        firstDate: firstDate,
        initialDatePickerMode: initialMode,
        dateFormat: formatDateTime(mode),
        mode: mode,
        dateTextStyle: style,
        initialValue: initialValue,
        enabled: !isReadOnly,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 11.0.sp),
          isDense: true,
          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: arancione)),
          hintText: hint,
          contentPadding: contentPadding,
          suffixIcon: isReadOnly
              ? null
              : Icon(
                  Icons.calendar_today,
                  size: 6.0.w,
                ),
          suffixIconConstraints: BoxConstraints(maxHeight: 10.0.h),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (e) => (richiesto && e == null ? (errText == null ? 'Selezionare una data' : errText) : null),
        onDateSelected: setField,
      ),
      dense: dense,
    );
  }
}

class MyVotoField extends StatefulWidget {
  final List<String> labels;
  final List<TextInputFormatter> formatters;
  final String hint;
  final String initialValue;
  final String errText;
  final Icons icon;
  bool obscureText;
  final bool richiesto;
  final bool isReadOnly;
  final bool multiline;
  final void Function(String) setField;
  final String Function(String) validator;
  final TextEditingController controller;

  MyVotoField(this.labels,
      {this.formatters,
      this.hint,
      this.initialValue,
      this.errText,
      this.icon,
      this.obscureText = false,
      this.richiesto = true,
      this.isReadOnly = false,
      this.multiline = false,
      this.setField,
      this.controller,
      this.validator});

  @override
  _MyVotoState createState() => _MyVotoState();
}

class _MyVotoState extends State<MyVotoField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return myFieldVoto(
      widget.labels,
      widget.richiesto,
      TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        enabled: !widget.isReadOnly,
        textCapitalization: TextCapitalization.characters,
        inputFormatters: widget.formatters,
        obscureText: widget.obscureText,
        cursorColor: Colors.grey,
        style: TextStyle(
            fontFamily: 'ToyotaType Book',
            fontStyle: widget.isReadOnly ? FontStyle.italic : FontStyle.normal,
            fontSize: 11.7.sp,
            color: widget.isReadOnly ? Colors.black54 : Colors.black),
        enableSuggestions: false,
        decoration: widget.obscureText == true
            ? InputDecoration(
                contentPadding: EdgeInsets.only(top: 15.0),
                isDense: true,
                hintText: widget.hint,
                suffixIcon: TextButton(
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                        showPassword = true;
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: viola,
                    )),
              )
            : !showPassword
                ? InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15.0),
                    isDense: true,
                    hintText: widget.hint,
                  )
                : InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15.0),
                    isDense: true,
                    hintText: widget.hint,
                    suffixIcon: TextButton(
                        onPressed: () {
                          setState(() {
                            widget.obscureText = !widget.obscureText;
                            showPassword = true;
                          });
                        },
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: viola,
                        )),
                  ),

        onSaved: widget.isReadOnly ? null : widget.setField,
        onChanged: widget.setField,
        // onEditingComplete: () => print('onEditingComplete ${_controller.value}'),
        // onFieldSubmitted: (value) => print('onFieldSubmitted: $value'),
        maxLines: widget.multiline ? null : 1,
        keyboardType: widget.multiline ? TextInputType.multiline : TextInputType.text,
      ),
    );
  }
}

//campo posizione
class MyTypeAheadPositionField extends StatefulWidget {
  final List<String> labels;
  final String hint;
  final String errText;
  final String txtNonRichiesto;
  final bool richiesto;
  final bool isReadOnly;
  final bool onlySelected;
  final bool showBtnPos;
  final LatLng initialPos;
  final String initialValue;
  final void Function(LatLng, String) setField;
  final String Function(String) editSelected;
  final FutureOr<Iterable<String>> Function(String) suggestionsCallback;
  final void Function(LatLng, String) onGeoCodingEnd;

  MyTypeAheadPositionField(this.labels,
      {this.hint,
      this.errText,
      this.txtNonRichiesto,
      this.richiesto = true,
      this.onlySelected = false,
      this.isReadOnly = false,
      this.showBtnPos = true,
      this.initialPos,
      this.initialValue,
      this.editSelected,
      this.setField,
      this.suggestionsCallback,
      this.onGeoCodingEnd});

  @override
  _MyTypeAheadFieldPositionState createState() => _MyTypeAheadFieldPositionState();
}

class _MyTypeAheadFieldPositionState extends State<MyTypeAheadPositionField> {
  final TextEditingController _controller = TextEditingController();
  String valSelected = "";
  geo.LatLon pos;
  bool isGeocoding = false;
  bool isInError = false;

  void takePosition() {
    setState(() {
      isGeocoding = true;
    });

    getLoc().then((locData) {
      pos = geo.LatLon(locData.latitude, locData.longitude);
      reversePosition();
      if (widget.onGeoCodingEnd != null) {
        widget.onGeoCodingEnd(LatLng(pos.latitude, pos.longitude), _controller.text);
      }
    }).onError((e, s) {
      print("$e");
      setState(() {
        isGeocoding = false;
      });
    });
  }

  void reversePosition() {
    if (!isGeocoding) {
      setState(() {
        isGeocoding = true;
      });
    }

    var googleGeocoding = geo.GoogleGeocoding(geocodingApiKey);
    googleGeocoding.geocoding.getReverse(pos).then((value) {
      if (value.status == "OK") {
        _controller.text = value.results.first.formattedAddress;
        print(value.results.first.formattedAddress);
        isInError = false;
      } else {
        isInError = true;
        //showMessage(context, "Errore GoogleMaps");
      }
      setState(() {
        isGeocoding = false;
      });
    }).onError((error, stackTrace) {
      print("$error");
      setState(() {
        isGeocoding = false;
      });
    });
  }

  void forwardPosition() {
    if (!isGeocoding) {
      setState(() {
        isGeocoding = true;
      });
    }

    var googleGeocoding = geo.GoogleGeocoding(geocodingApiKey);
    googleGeocoding.geocoding.get(_controller.text, []).then((value) {
      if (value.status == "OK") {
        geo.Location loc = value.results.first.geometry.location;
        pos = geo.LatLon(loc.lat, loc.lng);

        if (widget.onGeoCodingEnd != null) {
          widget.onGeoCodingEnd(LatLng(pos.latitude, pos.longitude), _controller.text);
        }

        print("lat: ${pos.latitude}, lat: ${pos.longitude}");

        isInError = false;
      } else {
        isInError = true;
        //showMessage(context, "Errore GoogleMaps");
      }
      setState(() {
        isGeocoding = false;
      });
    }).onError((error, stackTrace) {
      print("$error");
      setState(() {
        isGeocoding = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    pos = widget.initialPos == null ? null : geo.LatLon(widget.initialPos.latitude, widget.initialPos.longitude);
    _controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'ToyotaType Book', fontSize: 11.7.sp, color: Colors.black);

    if ((pos == null && widget.initialPos != null) || (trimNull(_controller.text).isEmpty && trimNull(widget.initialValue).isNotEmpty)) {
      pos = widget.initialPos == null ? null : geo.LatLon(widget.initialPos.latitude, widget.initialPos.longitude);
      _controller.text = widget.initialValue;
    }

    if (pos == null && trimNull(_controller.text).isNotEmpty && !isInError) {
      forwardPosition();
    } else if (pos != null && trimNull(_controller.text).isEmpty && !isInError) {
      reversePosition();
    }

    return myField(
      widget.labels,
      widget.richiesto,
      isGeocoding
          ? Container(height: 6.58.h, child: Loader())
          : Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          style: style,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: widget.hint,
                            contentPadding: contentPadding,
                            border: InputBorder.none,
                          ),
                          controller: _controller,
                        ),
                        hideOnEmpty: true,
                        hideOnError: true,
                        keepSuggestionsOnLoading: false,
                        suggestionsCallback: widget.suggestionsCallback,
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(constraints: BoxConstraints(minHeight: 300)),
                        itemBuilder: (context, String suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        transitionBuilder: (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (String suggestion) {
                          _controller.text = (widget.editSelected == null) ? suggestion : widget.editSelected(suggestion);
                          forwardPosition();
                          setState(() {
                            valSelected = _controller.text;
                          });
                        },
                        validator: (value) {
                          String ret;
                          if (trimNull(value).isEmpty) {
                            if (widget.richiesto) return (widget.errText == null ? 'Selezionare un valore' : widget.errText);
                          } else {
                            if (widget.onlySelected && value != valSelected) {
                              ret = 'Il valore deve essere selezionato dalla lista';
                              Scrollable.ensureVisible(context);
                              return ret;
                            }
                          }

                          return null;
                        },
                        onSaved: (value) {
                          if (pos != null) {
                            LatLng gps = LatLng(pos.latitude, pos.longitude);
                            widget.setField(gps, value);
                          }
                        },
                      ),
                    ),
                    if (widget.showBtnPos)
                      IconButton(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.all(0),
                        icon: Image.asset("assets/images/center_icon.png", color: viola, height: 21),
                        onPressed: takePosition,
                      ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 1,
                )
              ],
            ),
    );
  }
}
