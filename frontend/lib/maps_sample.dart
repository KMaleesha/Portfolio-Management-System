import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapsSampleApp extends StatefulWidget {
  const MapsSampleApp({Key? key}) : super(key: key);

  @override
  State<MapsSampleApp> createState() => _MapsSampleAppState();
}

class _MapsSampleAppState extends State<MapsSampleApp> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-33.86, 151.20);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTapped(LatLng location) {
    setState(() {
      // Update the text controller with the tapped location
      _locationDataController.text =
          '${location.latitude}, ${location.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LocationDataForm(
                locationDataController: _locationDataController,
              ),
            ),
          ),
          SizedBox(
              height: 16.0), // Added SizedBox to create space between cards
          Expanded(
            child: Card(
              elevation: 5,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                onTap: _onMapTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final TextEditingController _locationDataController = TextEditingController();
}

class LocationDataForm extends StatefulWidget {
  final TextEditingController locationDataController;

  const LocationDataForm({
    Key? key,
    required this.locationDataController,
  }) : super(key: key);

  @override
  _LocationDataFormState createState() => _LocationDataFormState();
}

class _LocationDataFormState extends State<LocationDataForm> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();

  @override
  void dispose() {
    _customerNameController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2:5000/customer/add'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'customerName': _customerNameController.text,
            'locationData': widget.locationDataController.text,
          }),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Customer saved successfully!')),
          );
          _customerNameController.clear();
          widget.locationDataController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save customer')),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to connect to the server')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _customerNameController,
            decoration: InputDecoration(labelText: 'Customer Name'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter a customer name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: widget.locationDataController,
            decoration: InputDecoration(labelText: 'Location Data'),
            enabled: false, // Disable editing
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 169, 203, 231), // Background color
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.black, // Text color
              ),
              textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontSize: 16), // Text size
              ),
            ),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
