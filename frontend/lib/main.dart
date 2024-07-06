import 'package:flutter/material.dart';
import 'maps_sample.dart';
import 'viewData.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Portfolio'),
          backgroundColor:
              Color.fromARGB(255, 170, 254, 140), // Light green color
          bottom: TabBar(
            indicatorColor: Color.fromARGB(
                255, 7, 114, 9), // Color of the selected tab indicator
            labelColor: Colors.black, // Color of the selected tab label
            unselectedLabelColor:
                Colors.white, // Color of the unselected tab label
            tabs: [
              Tab(text: 'Location Data'),
              Tab(text: 'Customers'),
            ],
          ),
        ),
        body: TabBarView(
          children: [MapsSampleApp(), ViewData()],
        ),
      ),
    );
  }
}
