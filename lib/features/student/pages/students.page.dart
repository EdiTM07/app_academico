import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/student.provider.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {

    /// ESCUCHA EL PROVIDER
    final students = context.watch<StudentProvider>().students;

    if (students.isEmpty) {
      return const Center(
        child: Text("No hay estudiantes"),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: students.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),

      itemBuilder: (context, index) {
        final student = students[index];

        return _StudentCard(nombre: "${student.firstName} ${student.lastName}", id: student.id);
      },
    );
  }
}

class _StudentCard extends StatelessWidget {
  final String nombre;
  final int id;

  const _StudentCard({required this.nombre, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/student/$id');
      },

      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// FOTO
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.indigo.shade100,

                  child: const Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ),

            /// INFORMACIÓN
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Estudiante',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
