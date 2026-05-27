import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/info.title.dart';
import '../../academic_programs/model/academic.program.model.dart';
import '../../academic_programs/providers/academic.program.provider.dart';
import '../models/student.model.dart';
import '../providers/student.provider.dart';

class StudentDetailPage extends StatelessWidget { 
  final String id;
  const StudentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<StudentProvider>();
    final providerAcademic = context.read<AcademicProgramProvider>();
    final studentId = int.tryParse(id);
    if (studentId == null) {
      return const Scaffold(body: Center(child: Text('ID inválido')));
    }
    return FutureBuilder<Student?>(
      future: provider.getById(studentId),
      builder: (context, studentSnapshot) {
        /// LOADING
        if (studentSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        /// STUDENT
        final student = studentSnapshot.data;

        /// NOT FOUND
        if (student == null) {
          return const Scaffold(
            body: Center(child: Text('Estudiante no encontrado')),
          );
        }
        return FutureBuilder<AcademicProgram?>(
          future: providerAcademic.getById(student.academicProgramId),
          builder: (context, academicSnapshot) {
            final academicProgram = academicSnapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  '${student.firstName} '
                  '${student.lastName}',
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final result = await context.push(
                        '/students/form',
                        extra: student,
                      );
                      if (result == true && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Estudiante actualizado correctamente',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// FOTO
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: student.photoUrl.isNotEmpty
                          ? AssetImage(student.photoUrl)
                          : null,
                      child: student.photoUrl.isEmpty
                          ? const Icon(Icons.person, size: 60)
                          : null,
                    ),
                    const SizedBox(height: 20),

                    /// NOMBRE
                    Text(
                      '${student.firstName} '
                      '${student.lastName}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// CÓDIGO
                    Text(
                      'Código: '
                      '${student.code}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    /// ACADEMIC PROGRAM
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.school,
                            size: 16,
                            color: Colors.indigo,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            academicProgram?.name ?? 'Sin carrera',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 30),
                    InfoTitle(
                      icon: Icons.badge,
                      label: "Género",
                      value: student.gender,
                    ),
                    InfoTitle(
                      icon: Icons.email,
                      label: "Email",
                      value: student.email,
                    ),
                    InfoTitle(
                      icon: Icons.phone,
                      label: "Teléfono",
                      value: student.phone,
                    ),
                    InfoTitle(
                      icon: Icons.cake,
                      label: "Fecha nacimiento",
                      value:
                          "${student.birthDate.day}/"
                          "${student.birthDate.month}/"
                          "${student.birthDate.year}",
                    ),
                    const SizedBox(height: 30),

                    /// CHAT
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
          },
        );
      },
    );
  }
}
