import 'package:flutter/material.dart';
import 'package:todoapp/screens/list_tasks.dart';

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
        '/crearTask': (context) => CreateTasks(),
        '/listTasks': (context) => ListTasks()
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => Page404());
      },
    );
  }
}