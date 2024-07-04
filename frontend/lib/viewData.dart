import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './updateCustomer.dart';
import 'dart:convert';

class ViewData extends StatefulWidget {
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late Future<List<dynamic>> _customers;

  Future<List<dynamic>> _fetchCustomers() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:5000/customer/get-all'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load customers');
    }
  }

  Future<void> _deleteCustomer(String? id) async {
    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Customer ID is null')),
      );
      return;
    }

    final response = await http.delete(
      Uri.parse('http://10.0.2.2:5000/customer/delete/$id'),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Customer deleted successfully!')),
      );
      setState(() {
        _customers = _fetchCustomers();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete customer')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _customers = _fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _customers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final customers = snapshot.data!;
            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  shadowColor: Colors.grey.withOpacity(0.4),
                  color: Colors.white, // Replace with your desired color
                  child: ListTile(
                    title: Text(customer['customerName'] ?? ''),
                    subtitle: Text(customer['locationData'] ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateCustomerPage(customer: customer),
                              ),
                            ).then((value) {
                              setState(() {
                                _customers = _fetchCustomers();
                              });
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            if (customer['_id'] != null) {
                              _deleteCustomer(customer['_id']);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Customer ID is null')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
