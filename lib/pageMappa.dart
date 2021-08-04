import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logioca/api.dart';
import 'package:logioca/main.dart';
import 'package:sizer/sizer.dart';
import 'common.dart';
import 'models/notifica.dart';

class PageMappa extends StatefulWidget {
  PageMappa(this.lat, this.long, {Key key}) : super(key: key);
  String lat;
  String long;
  @override
  _PageMappaState createState() => _PageMappaState();
}

class _PageMappaState extends State<PageMappa> {
  bool caricamento = true;
  ScrollController controller;
  Set<Marker> markers = new Set();
  LatLng posizione;
  GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    posizione = LatLng(double.parse(widget.lat), double.parse(widget.long));
    controller = new ScrollController();
    markers.add(new Marker(
      markerId: MarkerId(DateTime.now().toIso8601String()),
      position: posizione,
    ));
  }

  @override
  Widget build(BuildContext context) {
    /*return FutureBuilder<ListaNotifiche>(
        future: getNotificheAll(),
        builder: (context, AsyncSnapshot<ListaNotifiche> snapshot) {*/
    return Container(
        child: SafeArea(
            child: Scaffold(
      appBar: myAppBar(),
      body: caricamento
          ? /*SingleChildScrollView(
                controller: controller,
                child: ListBody(children: [
                  SizedBox(
                    height: 4.0.h,
                  ),*/
          Container(
              key: Key(DateTime.now().toString()),
              height: 85.0.h,
              child: GoogleMap(
                minMaxZoomPreference: MinMaxZoomPreference(2.0, 21.0),
                /* buildingsEnabled: false,
                rotateGesturesEnabled: false,
                myLocationEnabled: false,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: false,
                compassEnabled: true,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  new Factory<OneSequenceGestureRecognizer>(
                    () => new EagerGestureRecognizer(),
                  ),
                ].toSet(),*/
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(target: posizione, zoom: 11.0),
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                //onTap: _handleTap,
              ),
            )
          : Loader(),
    )));
  }
}
