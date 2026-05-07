import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final estudiantes = ['Juan', 'María', 'Pedro', 'Ana', 'Luis'];

    return ListView.builder(
      padding: const EdgeInsets.all(16),

      itemCount: estudiantes.length,

      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),

            title: Text(estudiantes[index]),

            subtitle: const Text('Estudiante'),

            trailing: const Icon(Icons.arrow_forward_ios),

            onTap: () {
              context.push('/student/${index + 1}');
            },
          ),
        );
      },
    );
  }
}
