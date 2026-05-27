import 'package:app_academico/features/student/pages/students.page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentsHomePage extends StatelessWidget {
  const StudentsHomePage({super.key});

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
          final result = await context.push('/students/form', extra: null);
          if (result == true && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Estudiante creado correctamente')),
            ); 
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
