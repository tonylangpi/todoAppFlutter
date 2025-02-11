import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:todoapp/infraestructure/Models/tasks_model.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({super.key});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  Task? task;

  @override
  void initState(){
    super.initState();
    getTasks();
  }
  Future<void> getTasks() async{
    final response = await Dio().get('api');
       task = Task.fromJson(response.data);
       setState((){});
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