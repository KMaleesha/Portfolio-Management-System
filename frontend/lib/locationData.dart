// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LocationMap extends StatefulWidget {
//   @override
//   _LocationMapState createState() => _LocationMapState();
// }

// class _LocationMapState extends State<LocationMap> {
//   late GoogleMapController mapController;

//   final LatLng _center = const LatLng(-33.86, 151.20);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 11.0,
//         ),
//       ),
//     );
//   }
// }
