import 'package:flutter/material.dart';
import 'package:information_about_location_futurebuilder/data/city_from_coordinates/city_model.dart';
import 'package:information_about_location_futurebuilder/data/city_from_coordinates/city_service.dart';
import 'package:latlong2/latlong.dart';

class CityWidget1 extends StatelessWidget {
  const CityWidget1({super.key, required this.coord});
  final LatLng coord;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CityModel>(
        future: fetchCityModel(coord),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.country == '') {
              return const Text('unknown location',
                  style: TextStyle(fontSize: 22), textAlign: TextAlign.center);
            } else {
              return Text(
                  'Country: ${snapshot.data!.country}     City: ${snapshot.data!.city}',
                  style: const TextStyle(fontSize: 22),
                  textAlign: TextAlign.center);
            }
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        });
  }
}
