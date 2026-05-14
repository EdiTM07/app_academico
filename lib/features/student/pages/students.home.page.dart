import 'package:app_academico/features/student/pages/students.page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/student.model.dart';
import '../providers/student.provider.dart';

class StudentsHomePage extends StatelessWidget {
  const StudentsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estudiantes')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: StudentsPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final provider = context.read<StudentProvider>();
          //Student? estudiante = provider.getById(1);
          Student? estudiante = null;

        final result = await context.push('/students/form', extra: null);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Estudiante creado')),);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
