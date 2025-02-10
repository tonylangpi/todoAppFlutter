import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
             Navigator.pushReplacementNamed(context, '/home');
          },
          child: Text('INGRESAR')),
      ),
    );
  }
}