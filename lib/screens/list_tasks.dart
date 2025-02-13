import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:todoapp/infraestructure/Models/tasks_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todoapp/customs/form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({super.key});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  Task? task;
  int? id;

  @override
  void initState(){
    super.initState();
    _chargeIdUser();
  }

  Future<void> getTasks() async{
    if (id != null) {
      final response = await Dio().get('${dotenv.env['API_KEY']}/api/tasksByPerson/$id');
      task = Task.fromJson(response.data);
      setState((){});
    }
  }

  _chargeIdUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id');
    });
    if (id != null) {
      getTasks();
    }
  }

   Future<void> editTask(data) async{
    if(id != null){
       try {
         final response = await Dio().put('${dotenv.env['API_KEY']}/updateTaskUser/$id', data: {"title" : data['title'], "description": data['description']} );
         if (response.statusCode == 200) {
           print('Task updated successfully');
         } else {
           print('Failed to update task: ${response.statusCode}');
         }
       } on DioException catch (e) {
         print('Failed to update task: ${e.message}');
       }
    }
  }

  _showModal(tarea) async{
     return  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
          title: const Text('Editar info tarea'),
          content: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              child: Column(
                  children: <Widget>[
                    Text("Titulo"),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: FormBuilderCustom(
                        keytype: TextInputType.text,
                        name: 'title',
                        initialValue: tarea.title, // Set the initial value here
                        obscureText: false,
                        hintText: 'Titulo de la tarea',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Titulo requerido')
                        ]),
                      ),
                    ),
                     Text("Descripcion"),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: FormBuilderCustom(
                        keytype: TextInputType.multiline,
                        name: 'description',
                        initialValue: tarea.description, // Set the initial value here
                        obscureText: false,
                        hintText: 'Descripcion tarea',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'descripcion requerida')
                        ]),
                      ),
                    ),
                     SizedBox(
                    height: 40,
                  ),
                    ElevatedButton.icon(
                    onPressed: () {
                      _formKey.currentState?.save();
                      if (_formKey.currentState?.validate() == true) {
                      final values = _formKey.currentState?.value;
                      editTask(values);
                      }
                    },
                    icon: Icon(Icons.save),
                    label: Text('Guardar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    )
                  ],
                ),
            ),
          ),
          actions: <Widget>[
            TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
            ),
          ],
          ),
        );
      },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Listado de tareas', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              children: [
              if (task != null) 
                ...task!.tasks.map((t) => 
                  Card(
                  elevation: 60,
                  margin: const EdgeInsets.all(20),
                  color: const Color.fromARGB(226, 218, 118, 118),
                  child: ListTile(
                    title: Text(t.title, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                    subtitle: Column(
                       children: [
                          Text(t.description),
                          Text('Fecha creacion: ${DateFormat('yyyy-MM-dd').format(t.dueDate)}'),
                          Text(t.status.toString() == '1' ? 'Activa' : 'Inactiva')
                       ],
                    ),
                    trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                          _showModal(t);
                      },
                      ),
                      IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Add your delete logic here
                        
                      },
                      ),
                    ],
                    ),
                  ),
                  )
                )
              else if (task == null)
                const CircularProgressIndicator()
              else
                const Text('No data'),
            ],),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushReplacementNamed(context, '/');
      },
      backgroundColor: Colors.blue,
      child:  Icon(Icons.logout),
      ),
    );
  }
}