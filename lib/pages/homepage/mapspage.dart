import 'dart:async';

import 'package:att_system_app/constants/theme.dart';
import 'package:att_system_app/util/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late double? lat;
  late double? lng;

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(-6.175370307972331, 106.82680774480104),
    zoom: 14.4746,
  );
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _marker = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                onTap: (LatLng latlng) {
                  Marker marker = Marker(
                    markerId: const MarkerId('1'),
                    position: LatLng(latlng.latitude, latlng.longitude),
                  );
                  _marker.add(marker);
                  setState(() {
                    lat = latlng.latitude;
                    lng = latlng.longitude;
                  });
                },
                markers: _marker.toSet(),
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await LocalStorage.setLat(lat);
                    await LocalStorage.setLng(lng);

                    await Navigator.popAndPushNamed(context, '/home');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(orangeColor),
                  ),
                  child: Text(
                    'SAVE',
                    style: whiteTextSytle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
