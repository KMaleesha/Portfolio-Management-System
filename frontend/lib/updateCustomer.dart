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
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(labelText: 'Customer Name'),
              ),
              TextFormField(
                controller: _locationDataController,
                decoration: InputDecoration(labelText: 'Location Data'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateCustomer,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
