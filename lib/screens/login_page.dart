import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';
import 'package:todoapp/customs/form_builder.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
 final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  

  Future<void> login(data) async{
    final response = await Dio().post('api', data: {"EMAIL" : data['email'], "CODE": data['password']} );
       print(response.data);
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
                            'https://i.ibb.co/B25Hmjd/Servis.png')
                      )
                    ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FormBuilderCustom(
                    keytype: TextInputType.emailAddress,
                    name: 'email', 
                    obscureText: false, 
                    hintText: 'Ingrea tu correo', 
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
                      FormBuilderValidators.minLength(
                        6,
                        errorText: 'Contraseña invalida'
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