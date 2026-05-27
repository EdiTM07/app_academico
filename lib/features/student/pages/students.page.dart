import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/student.provider.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final studentsView = context.watch<StudentProvider>().students;

    if (studentsView.isEmpty) {
      return const Center(child: Text("No hay estudiantes"));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: studentsView.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final view = studentsView[index];
        final student = view.student;
        final academicProgram = view.academicProgram;

        return _StudentCard(
          id: student.id,
          nombre: "${student.firstName} ${student.lastName}",
          carrera: academicProgram.name,
        );
      },
    );
  }
}

class _StudentCard extends StatelessWidget {
  final int id;
  final String nombre;
  final String carrera;

  const _StudentCard({
    required this.id,
    required this.nombre,
    required this.carrera,
  });

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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    carrera,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
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
