import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateCustomerPage extends StatefulWidget {
  final Map<String, dynamic> customer;

  UpdateCustomerPage({required this.customer});

  @override
  _UpdateCustomerPageState createState() => _UpdateCustomerPageState();
}

class _UpdateCustomerPageState extends State<UpdateCustomerPage> {
  late TextEditingController _customerNameController;
  late TextEditingController _locationDataController;

  @override
  void initState() {
    super.initState();
    _customerNameController =
        TextEditingController(text: widget.customer['customerName']);
    _locationDataController =
        TextEditingController(text: widget.customer['locationData']);
  }

  Future<void> _updateCustomer() async {
    final response = await http.put(
      Uri.parse(
          'http://10.0.2.2:5000/customer/update/${widget.customer['_id']}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'customerName': _customerNameController.text,
        'locationData': _locationDataController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Customer updated successfully!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update customer')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Color.fromARGB(255, 170, 254, 140), // Light green color
        title: Text('My Portfolio'), // Set your custom title here
        automaticallyImplyLeading: false, // Disable back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shadowColor: Colors.grey[400], // Shadow color
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _customerNameController,
                    decoration: InputDecoration(labelText: 'Customer Name'),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _locationDataController,
                    decoration: InputDecoration(labelText: 'Location Data'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateCustomer,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 169, 203, 231), // Background color
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.black, // Text color
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(fontSize: 16), // Corrected text size
                      ),
                    ),
                    child: Text('Update'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
