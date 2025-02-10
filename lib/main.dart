import 'package:flutter/material.dart';

import 'screens/index_pages.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => HomePage(),
        '/crearTask': (context) => CreateTasks()
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => Page404());
      },
    );
  }
}