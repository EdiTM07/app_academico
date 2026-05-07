import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MateriasPage extends StatelessWidget {
  const MateriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final materias = ['Aplicaciones moviles', 'Desarrollo WEB', 'Base de datos', 'Etica', 'Matematicas'];

    return ListView.builder(
      padding: const EdgeInsets.all(16),

      itemCount: materias.length,

      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),

            title: Text(materias[index]),

            subtitle: const Text('Materias'),

            trailing: const Icon(Icons.arrow_forward_ios),

            onTap: () {
              context.push('/materias/${index + 1}');
            },
          ),
        );
      },
    );
  }
}
