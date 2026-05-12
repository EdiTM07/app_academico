import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/student.provider.dart';
import '../models/student.model.dart';

class StudentDetailPage extends StatelessWidget {
  final String id;

  const StudentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();
    final studentId = int.tryParse(id);

    final Student? student = studentId != null 
        ? provider.getById(studentId) 
        : null;

    // Estado: Estudiante no encontrado
    if (student == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil del Estudiante'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_off_outlined, size: 80, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'Estudiante no encontrado',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    // Estado: Estudiante encontrado
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Estudiante'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabecera con fondo y foto
            _buildHeader(context, student),
            
            // Contenido principal (Tarjeta de datos y botón)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildInfoCard(student),
                  const SizedBox(height: 30),
                  
                  // Botón de Chat a ancho completo
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        context.push('/chat');
                      },
                      icon: const Icon(Icons.chat_bubble_outline),
                      label: const Text(
                        'Abrir Chat',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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

  Widget _buildHeader(BuildContext context, Student student) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 24, top: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Hero(
            tag: 'student-avatar-$id',
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                backgroundImage: student.photoUrl.isNotEmpty
                    ? AssetImage(student.photoUrl)
                    : null,
                child: student.photoUrl.isEmpty
                    ? Icon(Icons.person, size: 55, color: Colors.grey.shade400)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${student.firstName} ${student.lastName}',
            style: const TextStyle(
              fontSize: 26, 
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Identificación: ${student.code}',
              style: TextStyle(
                fontSize: 14, 
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(Student student) {
    final day = student.birthDate.day.toString().padLeft(2, '0');
    final month = student.birthDate.month.toString().padLeft(2, '0');
    final year = student.birthDate.year.toString();

    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            _InfoTile(icon: Icons.badge_outlined, label: "Género", value: student.gender),
            const Divider(height: 1, indent: 50, endIndent: 16),
            _InfoTile(icon: Icons.email_outlined, label: "Email", value: student.email),
            const Divider(height: 1, indent: 50, endIndent: 16),
            _InfoTile(icon: Icons.phone_outlined, label: "Teléfono", value: student.phone),
            const Divider(height: 1, indent: 50, endIndent: 16),
            _InfoTile(
              icon: Icons.cake_outlined,
              label: "Fecha nacimiento",
              value: "$day/$month/$year",
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon, 
    required this.label, 
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(
        label,
        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      dense: true,
    );
  }
}