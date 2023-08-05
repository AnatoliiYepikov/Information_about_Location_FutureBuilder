import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.coord});
  final LatLng coord;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          'Take the current position.',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          'Latitude: ${double.parse(coord.latitude.toStringAsFixed(7))}',
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          'Longitude: ${double.parse(coord.longitude.toStringAsFixed(7))}',
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}
