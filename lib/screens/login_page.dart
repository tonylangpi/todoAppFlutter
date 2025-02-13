// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';
import 'package:todoapp/customs/form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/infraestructure/Models/login_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
 final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  LoginPost? loginData;
  SharedPreferences? prefs;

  @override
  void initState(){
    super.initState();
    initPrefs();
  }

  initPrefs() async{
    prefs = await SharedPreferences.getInstance();
  }

 

  Future<void> login(data) async{
    final response = await Dio().post('${dotenv.env['API_KEY']}/api/login', data: {"EMAIL" : data['email'], "CODE": data['password']} );
   
    loginData = LoginPost.fromJson(response.data);
    if (loginData?.person != null) {
       prefs?.setInt('id', loginData!.person!.id);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
        title: const Text('Credenciales incorrectas'),
        content: const Text('Por favor, verifica tu correo y contraseña.'),
        actions: <Widget>[
          TextButton(
          child: const Text('Aceptar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
          ),
        ],
        );
      },
      );
    }
    //     prefs.setInt('id', loginData!.person.id);
    //   }else{
    //     showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Credenciales incorrectas'),
    //         content: const Text('Por favor, verifica tu correo y contraseña.'),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text('Aceptar'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
             key: _formKey,
             child: Center(
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    SizedBox(
                    height: 50.h,
                    child: Image(
                        image: NetworkImage(
                            'https://media.istockphoto.com/id/1435212785/es/vector/marcar-la-plantilla-de-dise%C3%B1o-vectorial-del-icono-en-fondo-blanco.jpg?s=612x612&w=0&k=20&c=mh-DeEWOnX8BpeISl6C567N45dzVcqUygm61FMvxAGs=')
                      )
                    ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FormBuilderCustom(
                    keytype: TextInputType.emailAddress,
                    name: 'email', 
                    obscureText: false, 
                    hintText: 'Ingresa tu correo', 
                    icon: Icons.mail,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(
                        errorText: 'Correo Requerido'
                      ),
                      FormBuilderValidators.email(
                        errorText: 'Correo no valido'
                      )
                      ]
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FormBuilderCustom(
                    keytype: TextInputType.text,
                    name: 'password', 
                    obscureText: true, 
                    hintText: 'Ingresa tu contraseña', 
                    icon: Icons.password,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(
                        errorText: 'Contraseña requerida'
                      ),
                      FormBuilderValidators.maxLength(
                        6,
                        errorText: 'Contraseña invalida solo 6 digitos'
                      )
                      ]
                    ),),
                  ),
          
                  SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      _formKey.currentState?.save();
                      if(_formKey.currentState?.validate() == true){
                        final values = _formKey.currentState?.value;
                        login(values);
                      }
                    }
                  , child: Text('Iniciar Sesión'))
                ],
                ),
             ),
          ),
        ),
      ),
    );
  }
}