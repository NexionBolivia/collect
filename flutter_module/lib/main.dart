import 'package:flutter/material.dart';

import 'screens/organizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organizaciones',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrganizationsScreen(),
    );
  }
}
