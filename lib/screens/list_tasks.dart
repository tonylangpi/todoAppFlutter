import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:todoapp/infraestructure/Models/tasks_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({super.key});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  Task? task;
  int? id;

  @override
  void initState(){
    super.initState();
    getTasks();
    _chargeIdUser();
  }
  Future<void> getTasks() async{
    final response = await Dio().get('http://192.168.0.15:8000/api/tasksByPerson/1');
       task = Task.fromJson(response.data);
       setState((){});
  }

  _chargeIdUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
       id = prefs.getInt('id');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Listado de tareas', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(
        child: Column(
            children: [
            if (task != null) 
              ...task!.tasks.map((t) => 
              Card(
                elevation: 60,
                margin: const EdgeInsets.all(20),
                color: const Color.fromARGB(227, 255, 255, 255),
                child: ListTile(
                  title: Text(t.title, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                  subtitle: Text(t.description),
              ))
              )
            else if (task == null)
              const CircularProgressIndicator()
            else
              const Text('No data'),
              Text(id.toString())
          ],),
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