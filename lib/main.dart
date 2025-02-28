import 'package:flutter/material.dart';
import 'screens/index_pages.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Material App',
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
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
      },
    );
  }
}
