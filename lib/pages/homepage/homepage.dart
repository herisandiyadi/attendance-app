import 'package:att_system_app/constants/theme.dart';
import 'package:att_system_app/pages/homepage/mapspage.dart';
import 'package:att_system_app/util/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _position;
  double? jarakMeter;
  double? lat;
  double? lng;

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _position = position;
    });

    if (_position != null) {
      double distanceInMeters = Geolocator.distanceBetween(
          lat!, lng!, _position!.latitude, _position!.longitude);
      setState(() {
        jarakMeter = distanceInMeters;
      });
    }
  }

  init() async {
    final lat = await LocalStorage.getLat();
    final lng = await LocalStorage.getLng();
    setState(() {
      this.lat = double.parse(lat!);
      this.lng = double.parse(lng!);
    });
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _getCurrentLocation();
    init();
  }

  Future<Position?> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Koordinat Terpilih : ',
              style:
                  whiteTextSytle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            Text(
              '$lat, $lng',
              style:
                  whiteTextSytle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const MapsPage();
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(orangeColor),
                  ),
                  child: Text(
                    'Master Location',
                    style: whiteTextSytle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Divider(
              color: whiteColor,
              thickness: 3,
            ),
            const SizedBox(
              height: 50,
            ),
            const Icon(
              Icons.person,
              color: whiteColor,
              size: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: jarakMeter == null
                    ? ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(orangeColor),
                        ),
                        child: const CircularProgressIndicator(
                          color: whiteColor,
                        ))
                    : ElevatedButton(
                        onPressed: () {
                          if (jarakMeter! > 50.0) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    title: Center(
                                      child: Text(
                                        'Jarak terlalu jauh dari titik Absen',
                                      ),
                                    ),
                                    titleTextStyle: TextStyle(
                                        color: orangeColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Text(
                                        'Absen Berhasil',
                                        style: greenTextSytle.copyWith(
                                            fontSize: 16, fontWeight: bold),
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(orangeColor),
                        ),
                        child: Text(
                          'Absen',
                          style: whiteTextSytle.copyWith(
                              fontSize: 16, fontWeight: semiBold),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
