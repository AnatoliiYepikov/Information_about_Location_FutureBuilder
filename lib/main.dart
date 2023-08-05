import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:information_about_location_futurebuilder/widgets/button_widget/button_widget.dart';
import 'package:information_about_location_futurebuilder/widgets/city_widget/city_widget.dart';
import 'package:information_about_location_futurebuilder/widgets/solar_day_widget/solar_day_widget.dart';
import 'package:information_about_location_futurebuilder/widgets/weather_widget/weather_widget.dart';
import 'package:latlong2/latlong.dart';

import 'data/coordinates/coordinates_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<LatLng> coordinates = determinePosition();
  LatLng coord = LatLng(42.7629600, 11.1094100);
  MapController mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CityWidget1(
                        coord: coord,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SolarDayWidget(
                            coord: coord,
                          ),
                          WeatherWidget(
                            coord: coord,
                          )
                        ],
                      )
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return IconButton(
                          iconSize: constraints.maxHeight,
                          onPressed: () async {
                            coord = await determinePosition()
                                .then((LatLng position) {
                              return LatLng(
                                  position.latitude, position.longitude);
                            });

                            mapController.move(coord, mapController.zoom);

                            setState(() {});
                          },
                          icon: Image.asset(
                            'assets/icons/earth_arrow.png',
                          ),
                        );
                      }),
                      ButtonWidget(
                        coord: coord,
                      ),
                    ],
                  )),
              Expanded(
                flex: 5,
                child: FutureBuilder(
                    future: coordinates,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return FlutterMap(
                          mapController: mapController,
                          options: MapOptions(
                            onTap: (tapPosition, point) {
                              mapController.move(point, mapController.zoom);
                              coord = LatLng(point.latitude, point.longitude);
                              setState(() {});
                            },
                            center: coord,
                            zoom: 7,
                            maxZoom: 18.0,
                          ),
                          nonRotatedChildren: [
                            AttributionWidget.defaultWidget(
                              source: 'OpenStreetMap contributors',
                              onSourceTapped: null,
                            ),
                          ],
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: coord,
                                  builder: (context) => const Icon(
                                    Icons.pin_drop,
                                    color: Colors.green,
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
