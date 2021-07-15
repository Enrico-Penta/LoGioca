import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:sizer/sizer.dart';

import '../common.dart';

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
