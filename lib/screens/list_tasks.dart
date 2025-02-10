import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:todoapp/infraestructure/Models/tasks_model.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({super.key});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  dynamic tareas;

  @override
  void initState(){
    super.initState();
    getTasks();
  }
  Future<void> getTasks() async{
    final response = await Dio().get('api');
       tareas = response.data;
       setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de tareas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tareas?["title"] ?? 'no data')
          ],),
      ),
    );
  }
}