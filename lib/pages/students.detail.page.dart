import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentDetailPage extends StatelessWidget {
  final String id;

  const StudentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Estudiante $id')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Text(
              'Detalle del estudiante $id',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const Text(
              'Esta pantalla NO pertenece al ShellRoute.',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              onPressed: () {
                context.push('/chat');
              },

              icon: const Icon(Icons.chat),

              label: const Text('Abrir Chat'),
            ),
          ],
        ),
      ),
    );
  }
}
