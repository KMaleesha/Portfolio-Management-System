import 'package:flutter/material.dart';
import 'locationData.dart';
import 'viewData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Location Data'),
              Tab(text: 'Customers'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LocationDataForm(),
            ViewData(),
          ],
        ),
      ),
    );
  }
}
