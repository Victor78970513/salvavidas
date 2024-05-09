import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salvavidas_app/features/security/provider/security_provider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final mapController = Completer<GoogleMapController>();

  @override
  void dispose() {
    mapController.future.then((value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = context.watch<SecurityProvider>();
    return mapProvider.permisionIsGranted
        ? GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                mapProvider.userPosition.latitude,
                mapProvider.userPosition.longitude,
              ),
              zoom: 14,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
            },
          )
        : Center(
            child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/loaders/map_loading.gif"),
                    fit: BoxFit.cover)),
          ));
  }
}
