import 'package:flutter/material.dart';

class CreateTasks extends StatefulWidget {
  const CreateTasks({super.key});

  @override
  State<CreateTasks> createState() => _CreateTasksState();
}

class _CreateTasksState extends State<CreateTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CREAR UNA TAREA'),
      ),
      body: const Center(
        child: Text('crear tareas'),
      ),
    );
  }
}